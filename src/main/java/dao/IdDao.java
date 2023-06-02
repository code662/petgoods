package dao;

import util.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class IdDao {
	// id 중복 검사
	public int checkId(String id) throws Exception {
		// id 중복 체크 변수
		int check = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM id_list WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			check = rs.getInt(1);
		}
		return check; // 1일 경우 중복값이 있음
	}
	// id_list에 추가
	public int addIdList(Id id) throws Exception{
		//sql 실행시 영향받은 행의 수
		int row = 0;
		// id 중복 검사
		int check = checkId(id.getId());
		if (check == 0) { //중복이 없을 시
			//db 접속
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//id_list에 추가
			String sql = "INSERT INTO id_list(id, last_pw, active, createdate) VALUES(?, ?, 'Y', NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id.getId());
			stmt.setString(2, id.getLastPw());
			row = stmt.executeUpdate();
			// id 생성후 pw_history 추가
			PwHistoryDao phDao = new PwHistoryDao();
			PwHistory pwHistory = new PwHistory();
			pwHistory.setId(id.getId());
			pwHistory.setPw(id.getLastPw());
			phDao.addPw(pwHistory);
		}
		
		return row; //1이면 추가 성공
	}
	// id 삭제 시 비활성화
	public int modifyIdActive(String id) throws Exception{
		//sql 실행시 영향받은 행의 수
		int row = 0;
		//db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//id_list에 비활성화로 수정
		String sql = "UPDATE SET active = 'N' FROM id_list WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		row = stmt.executeUpdate();
		 
		return row;
	}
	// 비밀번호 수정***
	public int modifyLastPw(Id id) throws Exception {
		int row = 0;
		// 이전 비밀번호 중복 검사 후 pw_history 추가
		PwHistoryDao phDao = new PwHistoryDao();
		PwHistory pwHistory = new PwHistory();
		pwHistory.setId(id.getId());
		pwHistory.setPw(id.getLastPw());
		int check = phDao.addPw(pwHistory);
		// 이전 비밀번호 중복이 없어 pw_history에 추가 되었다면
		if(check == 1) {
			//db 접속
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//id_list에 비밀번호 수정
			String sql = "UPDATE SET last_pw = ? FROM id_list WHERE id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id.getLastPw());
			stmt.setString(2, id.getId());
			row = stmt.executeUpdate();
		}
		
		return row;
	}

}
