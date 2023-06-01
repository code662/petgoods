package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class CustomerDao {
	// 자기 정보 조회
	public ArrayList<Customer> selectMyPage(String id) throws Exception {
		// 반환할 ArrayList<Customer> 생성
		ArrayList<Customer> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT cstm_no cstmNo, id, cstm_name cstmName, cstm_add cstmAdd, cstm_email cstmEmail, cstm_birth cstmBirth, cstm_gender cstmGender, cstm_rank cstmRank, cstm_point cstmPoint, cstm_last_login cstmLastLogin, cstm_agree cstmAgree, createdate, updatedate FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Customer customer = new Customer();
			customer.setCstmNo(rs.getInt("cstmNo"));
			customer.setId(rs.getString("id"));
			customer.setCstmName(rs.getString("cstmName"));
			customer.setCstmAdd(rs.getString("cstmAdd"));
			customer.setCstmEmail(rs.getString("cstmEmail"));
			customer.setCstmBirth(rs.getString("cstmBirth"));
			customer.setCstmGender(rs.getString("cstmGender"));
			customer.setCstmRank(rs.getString("cstmRank"));
			customer.setCstmPoint(rs.getInt("cstmPoint"));
			customer.setCstmLastLogin(rs.getString("cstmLastLogin"));
			customer.setCstmAgree(rs.getString("cstmAgree"));
			customer.setCreatedate(rs.getString("createdate"));
			customer.setUpdatedate(rs.getString("updatedate"));
			list.add(customer);
		}
		
		return list;
	}
	
	// 자기 정보 수정
	public int modifyMyPage(Customer customer) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE customer SET cstm_name = ?, cstm_add = ? , cstm_email = ? , cstm_birth = ? , cstm_gender = ? , updatedate = NOW()  WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCstmName());
		stmt.setString(2, customer.getCstmAdd());
		stmt.setString(3, customer.getCstmEmail());
		stmt.setString(4, customer.getCstmBirth());
		stmt.setString(5, customer.getCstmGender());
		stmt.setInt(6, customer.getCstmNo());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 회원가입
	public int addCustomer(Customer customer) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "INSERT INTO customer(id, cstm_name, cstm_add, cstm_email, cstm_birth, cstm_gender, cstm_rank, cstm_point, cstm_last_login, cstm_agree, createdate, updatedate ) VALUES(?,?,?,?,?,?,'1',0,NOW(),?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getId());
		stmt.setString(2, customer.getCstmName());
		stmt.setString(3, customer.getCstmAdd());
		stmt.setString(4, customer.getCstmEmail());
		stmt.setString(5, customer.getCstmBirth());
		stmt.setString(6, customer.getCstmGender());
		stmt.setString(7, customer.getCstmAgree());
		row = stmt.executeUpdate();
		
		return row;
	}	
	
	// 회원탈퇴
	public int removeCustomer(int cstmNo) throws Exception {
		// sql 실행시 영향받은 행의 수 
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql ="DELETE FROM customer WHERE cstm_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cstmNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 내 포인트 조회
	public int selectMyPoint(String id) throws Exception {
		// 반환할 변수 선언
		int myPoint = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql ="SELECT SUM(point) FROM point_history ph INNER JOIN (SELECT order_no FROM orders WHERE id ='test') o ON ph.order_no = o.order_no WHERE point_pm = '+'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		String sql2 ="SELECT SUM(point) FROM point_history ph INNER JOIN (SELECT order_no FROM orders WHERE id ='test') o ON ph.order_no = o.order_no WHERE point_pm = '-'";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
		
		if(rs.next()) {
			myPoint = rs.getInt(1);
		}
		if(rs2.next()) {
			myPoint -= rs2.getInt(1);
		}
		
		return myPoint;
	}
	// rank 설정 (구매확정 이후에 총 주문금액 확인 후 rank설정)
	
	// 로그인 시 cstm_last_login 갱신

	

}
