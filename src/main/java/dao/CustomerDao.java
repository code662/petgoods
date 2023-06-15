package dao;

import java.sql.*;
import util.*;
import vo.*;

public class CustomerDao {
	// 자기 정보 조회
	public Customer selectMyPage(String id) throws Exception {
		// 반환할 Customer객체 생성
		Customer customer = null;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아서 저장
		String sql = "SELECT cstm_no cstmNo, id, cstm_name cstmName, cstm_email cstmEmail, cstm_birth cstmBirth, cstm_gender cstmGender, cstm_rank cstmRank, cstm_point cstmPoint, cstm_last_login cstmLastLogin, cstm_agree cstmAgree, createdate, updatedate FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			customer = new Customer();
			customer.setCstmNo(rs.getInt("cstmNo"));
			customer.setId(rs.getString("id"));
			customer.setCstmName(rs.getString("cstmName"));
			customer.setCstmEmail(rs.getString("cstmEmail"));
			customer.setCstmBirth(rs.getString("cstmBirth"));
			customer.setCstmGender(rs.getString("cstmGender"));
			customer.setCstmRank(rs.getString("cstmRank"));
			customer.setCstmPoint(rs.getInt("cstmPoint"));
			customer.setCstmLastLogin(rs.getString("cstmLastLogin"));
			customer.setCstmAgree(rs.getString("cstmAgree"));
			customer.setCreatedate(rs.getString("createdate"));
			customer.setUpdatedate(rs.getString("updatedate"));
		}
		
		return customer;
	}
	
	// 자기 정보 수정
	public int modifyMyPage(Customer customer) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE customer SET cstm_name = ?, cstm_email = ? , updatedate = NOW()  WHERE cstm_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCstmName());
		stmt.setString(2, customer.getCstmEmail());
		stmt.setInt(3, customer.getCstmNo());
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
		// id 중복 검사 후 id_list에 추가
		IdDao idDao = new IdDao();
		Id id = new Id();
		id.setId(customer.getId());
		id.setLastPw(customer.getPw());
		int check = idDao.addIdList(id); // 1 = id_list에 추가 성공
		if(check == 1) {
			// id_list에 추가 완료 후 customer에 추가
			String sql = "INSERT INTO customer(id, cstm_name, cstm_email, cstm_birth, cstm_gender, cstm_rank, cstm_point, cstm_last_login, cstm_agree, createdate, updatedate ) VALUES(?,?,?,?,?,'1',0,NOW(),?,NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getId());
			stmt.setString(2, customer.getCstmName());
			stmt.setString(3, customer.getCstmEmail());
			stmt.setString(4, customer.getCstmBirth());
			stmt.setString(5, customer.getCstmGender());
			stmt.setString(6, customer.getCstmAgree());
			row = stmt.executeUpdate();
		 }
		
		return row;
	}	
	
	// 회원탈퇴
	public int removeCustomer(String id) throws Exception {
		// sql 실행시 영향받은 행의 수 
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql ="DELETE FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		row = stmt.executeUpdate();
		
		// id_list에서 비활성상태로 변경
		IdDao idDao = new IdDao(); 
		idDao.modifyIdActive(id);
		
		return row;
	}
	
	// 포인트 추가
	// 주문 목록에서 구매확정 클릭 시 적립 -> orderNo에 해당하는 구매금액(orderPrice * orderCnt)의 1% (등급에 따라 5%, 10% 변경)
	public int addPlusPoint(Orders order) throws Exception {
		int row = 0;
		String rank = selectMyRank(order.getId());
		System.out.println(rank);
		int point = order.getOrderPrice() * order.getOrderCnt();
		if (rank.equals("BRONZE")) {
			point = (int) (point * 0.01);
		} else if (rank.equals("SILVER")) {
			point = (int) (point * 0.05);
		} else {
			point = (int) (point * 0.1);
		}
		System.out.println(point);
		
		System.out.println(order.getOrderNo());
			
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO point_history(order_no, point_pm, point, createdate) VALUES(?, '+', ?, NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getOrderNo());
		stmt.setInt(2, point);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		if (row == 1) {
			row = modifyMyPoint(order.getId());
		}
		
		return row;
	}
	
	// 포인트 추가 2
	// point_history에 더해진 금액을 customer 테이블의 cstm_point에도 저장
	// public int addPlusPoint()
	
	// 포인트 사용
	// 주문 시 사용
	public int addMinusPoint(Orders order, int point) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO point_history(order_no, point_pm, point, createdate) VALUES(?, '-', ?, NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getOrderNo());
		stmt.setInt(2, point);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		if (row == 1) {
			row = modifyMyPoint(order.getId());
		}
		
		return row;
	}
	
	
	// 내 포인트 설정
	public int modifyMyPoint(String id) throws Exception {
		int row = 0;
		int point = selectMyPoint(id);
		
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE customer SET cstm_point = ? WHERE id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, point);
		stmt.setString(2, id);
		System.out.println(stmt);
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
		String sql ="SELECT SUM(point) FROM point_history ph INNER JOIN (SELECT order_no FROM orders o1 WHERE o1.id = ?) o2 ON ph.order_no = o2.order_no WHERE point_pm = '+'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		
		String sql2 ="SELECT SUM(point) FROM point_history ph INNER JOIN (SELECT order_no FROM orders o1 WHERE o1.id = ?) o2 ON ph.order_no = o2.order_no WHERE point_pm = '-'";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, id);
		System.out.println(stmt);
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
	public int modifyRank(String id) throws Exception {
		// 반환할 변수 선언
		String rank = "";
		int row = 0;
		// 총 주문금액 조회한거 들고와서 rank 설정
		OrdersDao ordersDao = new OrdersDao();
		int totalOrdersPrice = ordersDao.selectTotalOrdersPrice(id);
		if(totalOrdersPrice<100000) {
			rank = "BRONZE";
		}else if(totalOrdersPrice<200000) {
			rank = "SILVER";
		}else {
			rank = "GOLD";
		}
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 주문 상태 변경
		String sql = "UPDATE customer SET cstm_rank = ?, updatedate = NOW() WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, rank);
		stmt.setString(2, id);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// rank 조회
	public String selectMyRank(String id) throws Exception {
		// 반환할 변수 선언
		String myRank = "";
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql ="SELECT cstm_rank RANK FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			myRank = rs.getString(1);
		}

		return myRank;
	}
	
	// 로그인 시 cstm_last_login 갱신
	public int modifyLastLogin(String id) throws Exception {
		// 반환할 변수 선언
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE customer SET cstm_last_login = NOW(), updatedate = NOW()  WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		row = stmt.executeUpdate();
		// 디버깅
		if(row == 1 ) {
			System.out.println("최근 로그인 일자 갱신 성공");
		}else {
			System.out.println("최근 로그인 일자 갱신 실패");
		}
		
		return row;
	}
}