package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class OrdersDao {
	// 전체 고객 주문 조회 (관리자 화면에서 조회)
	public ArrayList<Orders> selectTotalOrders(int beginRow, int rowPerPage) throws Exception {
		// 반환할 ArrayList<Orders> 생성
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
			orders.setOrderCnt(rs.getInt("orderCnt"));
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
	
	// 주문상태별 주문리스트 조회
	public ArrayList<Orders> selectOrdersByOrderStatus(String orderStatus, int beginRow, int rowPerPage) throws Exception {
		// 반환할 ArrayList<Orders> 생성
		ArrayList<Orders> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT order_no orderNo, product_no productNo, id, order_status orderStatus, order_cnt orderCnt, order_price orderPrice, createdate, updatedate FROM orders WHERE order_status=? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orderStatus);
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
			orders.setOrderCnt(rs.getInt("orderCnt"));
			orders.setCreatedate(rs.getString("createdate"));
			orders.setUpdatedate(rs.getString("updatedate"));
			list.add(orders);	
		}

		return list;
	}
	
	// 고객아이디별 주문리스트 조회
	/*
	 * public ArrayList<Orders> selectOrdersById(String id, int beginRow, int
	 * rowPerPage) throws Exception { // 반환할 ArrayList<Orders> 생성 ArrayList<Orders>
	 * list = new ArrayList<>(); // DB 접속 DBUtil dbUtil = new DBUtil(); Connection
	 * conn = dbUtil.getConnection(); String sql = ""; PreparedStatement stmt =
	 * conn.prepareStatement(sql);
	 * 
	 * return list; }
	 */
	
	// 날짜범위별 주문리스트 조회
	
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
			orders.setOrderCnt(rs.getInt("orderCnt"));
			orders.setCreatedate(rs.getString("createdate"));
			orders.setUpdatedate(rs.getString("updatedate"));
			list.add(orders);	
		}
		
		return list;
	}
	
	 // 총 주문 조회 (내 주문 조회 페이징)
	 public int selectMyOrdersCnt(String id) throws Exception {
		 // 나의 총 주문내역 개수
		 int cnt = 0;
		 // DB 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 String sql = "SELECT COUNT (*) FROM orders WHERE id=?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, id);
		 
		 ResultSet rs = stmt.executeQuery();
		 if (rs.next()) {
			 cnt = rs.getInt(1);
		 }
		 
		 return cnt;
	 }
	 
	// 주문 상태 변경 (주문취소, 결제완료, 배송완료, 구매확정)
	public int modifyOrdersStatus(Orders orders) throws Exception{
		// sql 실행시 영향받은 행의 수
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 주문 상태 변경
		String sql = "UPDATE orders SET order_status = ? WHERE id = ? AND createdate = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrderStatus());
		stmt.setString(2, orders.getId());
		stmt.setString(3, orders.getCreatedate());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 고객 id 조회 (관리자 페이지에서 주문상태 변경에 사용)
	public String selectCstmId(int orderNo) throws Exception {
		String id = "";
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 고객 id
		String sql = "SELECT id FROM orders WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			id = rs.getString(1);
		}
		
		return id;
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
	
	// 
	
	// 주문 추가 (결제완료)
	public int addOrders(Orders orders) throws Exception {
		// sql 실행시 영향받은 행의 수
		int row = 0;
		int key = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO orders(product_no, id, order_status, order_cnt, order_price, createdate, updatedate) VALUES(?, ?, '결제완료', ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS); // 
		stmt.setInt(1, orders.getProductNo());
		stmt.setString(2, orders.getId());
		stmt.setInt(3, orders.getOrderCnt());
		stmt.setInt(4, orders.getOrderPrice());
		ResultSet rs = stmt.getGeneratedKeys();
		if (rs.next()) {
			key = rs.getInt(1); 
		}
		
		row = modifyProductStock(key);
	
		return row;
	 } 
		
	// 주문코드 (createdate(연/월/일/시/분/초) + orderNo(4자리)) 조회
	public String selectOrdersCode(int orderNo) throws Exception {
		// 반환할 String fullOrdersNo 생성
		String ordersCode = "";
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT CONCAT(YEAR(createdate), LPAD(MONTH(createdate), 2, '0'), LPAD(DAY(createdate), 2, '0'), LPAD(HOUR(createdate), 2, '0'), LPAD(MINUTE(createdate), 2, '0'), LPAD(SECOND(createdate), 2, '0'), LPAD(order_no, 4, '0')) fullOrdersNo FROM orders WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			ordersCode = rs.getString(1);
		}
		
		return ordersCode;
	}
	
	// 상품이름 조회
	public String selectProductName(int productNo) throws Exception {
		// 반환할 String name 생성
		String name = "";
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT product_name FROM product p INNER JOIN orders o ON p.product_no = o.product_no WHERE o.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			name = rs.getString(1);
		}
		
		return name;
	}
	
	// 상품 이미지 조회
	public String selectImg(int productNo) throws Exception {
		// 반환할 객체 (이미지명)
		String img = "";
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT product_save_filename FROM product_img WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			img = rs.getString(1);
		}
		
		return img;
	}
	
	// 주문 1건 상세정보
	public Orders selectOrderOne(int orderNo) throws Exception {
		Orders order = null;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT order_no orderNo, product_no productNo, id, order_status orderStatus, order_cnt orderCnt, order_price orderPrice, createdate, updatedate FROM orders WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		ResultSet rs = stmt.executeQuery();
		order = new Orders();
		while (rs.next()) {
			order.setOrderNo(rs.getInt("orderNo"));
			order.setProductNo(rs.getInt("productNo"));
			order.setId(rs.getString("id"));
			order.setOrderStatus(rs.getString("orderStatus"));
			order.setOrderCnt(rs.getInt("orderCnt"));
			order.setOrderPrice(rs.getInt("orderPrice"));
			order.setCreatedate(rs.getString("createdate"));
			order.setUpdatedate(rs.getString("updatedate"));
		}
		
		return order;
	}
	
	// 재고량 조회
	public int selectProductStock(int productNo) throws Exception {
		// 반환할 재고량
		int stock = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT product_stock FROM product WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			stock = rs.getInt(1);
		}
		
		return stock;
	}
	
	// 재고량 변경
	public int modifyProductStock(int orderNo) throws Exception {
		// 변경된 재고량
		int row = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE product p INNER JOIN orders o ON p.product_no = o.product_no SET p.product_stock = p.product_stock - o.order_cnt WHERE o.order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		
		row = stmt.executeUpdate();
		
		return row;
		
		/*
		UPDATE customers
		INNER JOIN orders ON customers.id = orders.customer_id
		SET customers.address = 'New Address'
		WHERE orders.total_amount > 100;
		*/
	}
}