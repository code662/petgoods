package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class CartDao {
	// 나의 장바구니 조회 (로그인 상태)
	public ArrayList<Cart> selectMyCart(String id) throws Exception {
		ArrayList<Cart> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT cart_no cartNo, product_no productNo, id, cart_cnt cartCnt, createdate, updatedate FROM cart WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Cart cart = new Cart();
			cart.setCartNo(rs.getInt("cartNo"));
			cart.setProductNo(rs.getInt("productNo"));
			cart.setId(rs.getString("id"));
			cart.setCartCnt(rs.getInt("cartCnt"));
			cart.setCreatedate(rs.getString("createdate"));
			cart.setUpdatedate(rs.getString("updatedate"));
			list.add(cart);
		}
		
		return list;
	}
	
	// 상품 이름 조회 (로그인 상태)
	public String selectProductName(int productNo) throws Exception {
		// 반환할 String name 생성
		String name = "";
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT product_name FROM product p INNER JOIN cart c ON p.product_no = c.product_no WHERE c.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			name = rs.getString(1);
		}
		
		return name;
	}
	
	// 상품 금액 조회 (로그인 상태)
	public int selectProductPrice(int productNo) throws Exception {
		int price = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT product_price FROM product p INNER JOIN cart c ON p.product_no = c.product_no WHERE c.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			price = rs.getInt(1);
		}
		
		return price;
	}
	
	// 나의 장바구니 추가 (로그인 상태)
	public int addMyCart(Cart cart) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 실행 쿼리문
		String sql = "INSERT INTO cart(product_no, id, cart_cnt, createdate, updatedate) VALUES(?, ?, 1, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getProductNo());
		stmt.setString(2, cart.getId());
		row = stmt.executeUpdate();
		
		return row;
	}

	// 나의 장바구니 추가 시 중복검사 (로그인 상태)
	public int checkCartDuplicate(int productNo) throws Exception {
		// 장바구니에 추가하려는 상품 중복 체크 변수
		int check = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// SQL 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM cart WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			check = rs.getInt(1);
		}
		
		return check; // 1일 경우 중복값 있음
	}
	
	// 나의 장바구니 수정(수량) (로그인 상태)
	public int modifyMyCart(Cart cart) throws Exception {
		// 반한할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 해당 상품 수량 변경
		String sql = "UPDATE cart SET cart_cnt = ? WHERE id = ? AND cart_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartCnt());
		stmt.setString(2, cart.getId());
		stmt.setInt(3, cart.getCartNo());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 나의 장바구니 삭제 (로그인 상태)
	public int removeMyCart(int cartNo) throws Exception {
		// 반한할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// DB에서 해당 카테고리 삭제
		String sql = "DELETE FROM cart WHERE cart_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cartNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 장바구니 추가 (로그인 X, 세션 사용)
	// 장바구니 추가 시 중복검사(로그인 X, 세션 사용 - 세션 내 상품정보와 비교)
	// 장바구니 수정 (로그인 X, 세션 사용)
	// 장바구니 삭제 (로그인X, 세션 사용)
	// 장바구니 조회 (로그인 X, 세션 사용)
	// -> DAO 생성하지 않음
}