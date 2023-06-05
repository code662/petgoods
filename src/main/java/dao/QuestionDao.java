package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;


public class QuestionDao {
	// 문의 등록
	public int addQuestion(Question question) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "INSERT INTO question(product_no, id, q_category, q_title, q_content, q_status, createdate, updatedate) VALUES (?, ?, ?, ?, ?, '답변대기', NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, question.getProductNo());
		stmt.setString(2, question.getId());
		stmt.setString(3, question.getqCategory());
		stmt.setString(4, question.getqTitle());
		stmt.setString(5, question.getqContent());
		
		row = stmt.executeUpdate();
		
		return row;
	}
	// 문의 수정
	public int modifyQuestion(Question question) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE question SET q_category = ?, q_title = ?, q_content = ?, updatedate = NOW() WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, question.getqCategory());
		stmt.setString(2, question.getqTitle());
		stmt.setString(3, question.getqContent());
		stmt.setInt(4, question.getqNo());

		row = stmt.executeUpdate();
		
		return row;	
	}
	// 문의 삭제
	public int removeQuestion(int qNo) throws Exception {
		int row = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "DELETE FROM question WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qNo);

		row = stmt.executeUpdate();
		
		return row;	
	}
	// 문의 갯수 조회
	public int selectQuestionCnt(int productNo) throws Exception {
		int cnt = 0;
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM question";
		// productNo이 0일 경우 전체 문의 조회 
		if(productNo == 0) {
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} else {
			sql = "SELECT COUNT(*) FROM question WHERE product_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, productNo);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		}

		return cnt;
	}
	
	// 관리자 문의 조회
	public ArrayList<Question> selectQuestion(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Question> list = new ArrayList<>();
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT q_no qNo, product_no productNo, id, q_category qCategory, q_title qTitle, q_content qContent, q_status qStatus, createdate, updatedate FROM question ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Question question = new Question();
			question.setqNo(rs.getInt("qNo"));
			question.setProductNo(rs.getInt("productNo"));
			question.setId(rs.getString("id"));
			question.setqCategory(rs.getString("qCategory"));
			question.setqTitle(rs.getString("qTitle"));
			question.setqContent(rs.getString("qContent"));
			question.setqStatus(rs.getString("qStatus"));
			question.setCreatedate(rs.getString("createdate"));
			question.setUpdatedate(rs.getString("updatedate"));
			list.add(question);
		}

		return list;
	}
	// 상품 상세 밑에 표시할 문의
	public ArrayList<Question> selectQuestion(int productNo, int beginRow, int rowPerPage) throws Exception {
		ArrayList<Question> list = new ArrayList<>();
		
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT q_no qNo, product_no productNo, id, q_category qCategory, q_title qTitle, q_content qContent, q_status qStatus, createdate, updatedate FROM question WHERE product_no = ? ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Question question = new Question();
			question.setqNo(rs.getInt("qNo"));
			question.setProductNo(rs.getInt("productNo"));
			question.setId(rs.getString("id"));
			question.setqCategory(rs.getString("qCategory"));
			question.setqTitle(rs.getString("qTitle"));
			question.setqContent(rs.getString("qContent"));
			question.setqStatus(rs.getString("qStatus"));
			question.setCreatedate(rs.getString("createdate"));
			question.setUpdatedate(rs.getString("updatedate"));
			list.add(question);
		}

		return list;
	}
}

