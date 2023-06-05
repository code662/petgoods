package dao;


import java.sql.*;
import util.*;
import vo.*;

public class AnswerDao {
	// 답변 추가 시 답변완료
	public int completeAnswer(int qNo) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE question SET q_status = '답변완료', updatedate = NOW() WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qNo);

		row = stmt.executeUpdate();
		
		return row;			
	}
	// 문의 답변 추가
	public int addAnswer(Answer answer) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "INSERT INTO answer(q_no, id, a_content, createdate, updatedate) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, answer.getqNo());
		stmt.setString(2, answer.getId());
		stmt.setString(3, answer.getaContent());
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			completeAnswer(answer.getqNo());	
		}
		
		return row;			
	}
	// 문의 답변 삭제
	public int removeAnswer(int aNo) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "DELETE FROM answer WHERE a_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, aNo);

		row = stmt.executeUpdate();
		
		return row;	
	}
	// 문의 답변 수정
	public int modifyAnswer(Answer answer) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE answer SET a_content = ?, updatedate = NOW() WHERE a_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, answer.getaContent());
		stmt.setInt(2, answer.getaNo());

		row = stmt.executeUpdate();
		
		return row;	
	}
	
	// 문의 답변 조회
	public Answer selectAnswerOne(int qNo) throws Exception {
		Answer answer = new Answer();
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT a_no aNo, q_no qNo, id, a_content aContent, createdate, updatedate FROM answer WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, answer.getqNo());

		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			answer.setaNo(rs.getInt("aNo"));
			answer.setqNo(rs.getInt("qNo"));
			answer.setId(rs.getString("id"));
			answer.setaContent(rs.getString("aContent"));
			answer.setCreatedate(rs.getString("createdate"));
			answer.setUpdatedate(rs.getString("updatedate"));
		}
		
		return answer;
	}
}
