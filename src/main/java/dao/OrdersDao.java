package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class OrdersDao {
	// 전체 고객 주문 조회 (관리자 화면에서 조회)
	public ArrayList<Orders> selectTotalOrders(int beginRow, int rowPerPage) throws Exception {
		// 반환할 ArrayList<Order> 생성
		ArrayList<Orders> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT order_no orderNo, product_no productNo, id, order_status orderStatus, order_cnt orderCnt, order_price orderPrice, createdate, updatedate FROM orders ORDER BY createdate DESC LIMIT ? ,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Orders orders = new Orders();
			orders.setOrderNo(rs.getInt("orderNo"));
			orders.setProductNo(rs.getInt("productNo"));
			orders.setId(rs.getString("id"));
			orders.setOrderStatus(rs.getString("orderStatus"));
			orders.setOrderPrice(rs.getInt("orderPrice"));
			orders.setCreatedate(rs.getString("createdate"));
			orders.setUpdatedate(rs.getString("updatedate"));
			list.add(orders);	
		}
		
		return list;
	}
	
	// 총 주문 건수 (관리자 화면 페이징)
	public int selectOrdersCnt() throws Exception {
		// 반환할 전체 행의 수
		int row = 0;
		// db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과 셋 반환받아 값 저장
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM orders");
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			row = rs.getInt(1);
		}
		 
		 return row;
	 }
	
	// 내 주문 조회 
	 public ArrayList<Orders> selectMyOrders(String id, int beginRow, int rowPerPage) throws Exception {
		// 반환할 ArrayList<Order> 생성
		ArrayList<Orders> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT order_no orderNo, product_no productNo, id, order_status orderStatus, order_cnt orderCnt, order_price orderPrice, createdate, updatedate FROM orders WHERE id = ? ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Orders orders = new Orders();
			orders.setOrderNo(rs.getInt("orderNo"));
			orders.setProductNo(rs.getInt("productNo"));
			orders.setId(rs.getString("id"));
			orders.setOrderStatus(rs.getString("orderStatus"));
			orders.setOrderPrice(rs.getInt("orderPrice"));
			orders.setCreatedate(rs.getString("createdate"));
			orders.setUpdatedate(rs.getString("updatedate"));
			list.add(orders);	
		}
		
		return list;
	}
		 
	// 주문 상태 변경 (주문취소, 결제완료, 배송완료, 구매확정)
	public int modifyOrdersStatus(Orders orders) throws Exception{
		// sql 실행시 영향받은 행의 수
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 주문 상태 변경
		String sql = "UPDATE SET orders_status = ? FROM orders WHERE id = ? AND createdate = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrderStatus());
		stmt.setString(2, orders.getId());
		stmt.setString(3, orders.getCreatedate());
		row = stmt.executeUpdate();
		 
		return row;
	}
	 
	// 총 주문 금액 조회 (회원등급 구하기 위함)
	public int selectTotalOrdersPrice(String id) throws Exception {
		int totalOrdersPrice = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 총 주문 금액 조회
		String sql = "SELECT SUM(order_price) totalPrice FROM orders WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			totalOrdersPrice = rs.getInt(1);
		}
		
		return totalOrdersPrice;
	}
	
	// 주문 추가
	public int addOrders(Orders orders) throws Exception {
		// sql 실행시 영향받은 행의 수
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO orders(product_no, id, order_status, order_cnt, order_price, createdate, updatedate) VALUES(?, ?, '결제완료', ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orders.getProductNo());
		stmt.setString(2, orders.getId());
		stmt.setInt(3, orders.getOrderCnt());
		stmt.setInt(4, orders.getOrderPrice());
		row = stmt.executeUpdate();
		 
		return row;
	 } 
		
	
	// 주문번호 조회
}
	 
	 