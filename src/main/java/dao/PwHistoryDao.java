package dao;

import util.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class PwHistoryDao {
	// 비밀번호 추가***
	public int addPw(PwHistory pwHistory) throws Exception {
		int row = 0;
		int check = checkPw(pwHistory);
		// 이전 비밀번호 중복 검사
		if(check == 0) {
			// 이전 비밀번호에 중복이 없으면 비밀번호 이력 추가
			// db 접속
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// pw_history에 추가
			String sql = "INSERT INTO pw_history(id, pw, createdate) VALUES(?,PASSWORD(?),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, pwHistory.getId());
			stmt.setString(2, pwHistory.getPw());
			row = stmt.executeUpdate();
			
			removeOldPwHistory(pwHistory.getId()); // 오래된 비밀번호 삭제
		}
		return row;
	}
	
	// 같은 id의 비밀번호 변경 이력 개수 확인
	public int cntPw(String id) throws Exception {
		int cnt = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// pw_history 개수 조회
		String sql = "SELECT COUNT(*) FROM pw_history WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		return cnt;
	}
	
	// 가장 오래된 이력 삭제
	public int removeOldPwHistory(String id) throws Exception {
		int row = 0;
		if(cntPw(id) > 3) {
			//db 접속
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//삭제
			String sql = "DELETE FROM pw_history WHERE id = ? AND createdate = (SELECT MIN(createdate) FROM pw_history WHERE id = ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, id);
			row = stmt.executeUpdate();
		}
		return row;
	}
	
	// 이전 비밀번호 검사
	public int checkPw(PwHistory pwHistory) throws Exception {
		int check = 0;
		String encryptionPw = encryption(pwHistory.getPw()); // 입력받은 비밀번호값 암호화형태로 변경 후 저장
		ArrayList<String> passwords = new ArrayList<>();
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// pw 조회
		String sql = "SELECT pw FROM pw_history WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, pwHistory.getId());
		ResultSet rs = stmt.executeQuery();
		// 이전 비밀번호 리스트에 저장
		while(rs.next()) {
			passwords.add(rs.getString("pw"));
		}
		// 이전 비밀번호 검사
		for(String pw : passwords) {
			System.out.println(encryptionPw + " <--- checkPw 암호화된 비밀번호");
			System.out.println(pw + " <--- checkPw 비밀번호이력 DB에 저장되어있는 이전 비밀번호들");
			if (encryptionPw.equals(pw)) {
				check = 1;
				System.out.println(check + " <--- checkPw check");
				return check;
			}
		}
		System.out.println(check + " <--- checkPw check");
		return check;
	}
	
	// 입력받는 비밀번호 암호화된 형태로 변경
	public String encryption(String pw) throws Exception {
		String password = "";
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 암호화된 pw 조회
		String sql = "SELECT PASSWORD(?) pw";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, pw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			password = rs.getString("pw");
		}
		return password;
	}
}
