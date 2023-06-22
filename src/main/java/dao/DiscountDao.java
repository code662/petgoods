package dao;

import java.sql.*;
import java.util.*;

import util.*;
import vo.*;

public class DiscountDao {
	
	// 할인 품목 조회
	public ArrayList<Discount> selectDiscount(int beginRow, int rowPerPage) throws Exception {
		// 반환할 ArrayList<Discount> 생성
		ArrayList<Discount> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT p.product_name productName, d.discount_no discountNo, d.product_no productNo, d.discount_start discountStart, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate FROM discount d INNER JOIN product p ON d.product_no = p.product_no LIMIT ? ,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Discount discount = new Discount();
			discount.setProductName(rs.getString("productName"));
			discount.setDiscountNo(rs.getInt("discountNo"));
			discount.setProductNo(rs.getInt("productNo"));
			discount.setDiscountStart(rs.getString("discountStart"));
			discount.setDiscountEnd(rs.getString("discountEnd"));
			discount.setDiscountRate(rs.getDouble("discountRate"));
			discount.setCreatedate(rs.getString("createdate"));
			discount.setUpdatedate(rs.getString("updatedate"));
			list.add(discount);	
		}
		
		return list;
	}
	
	// product_no로 검색한 할인 품목 조회
	public ArrayList<Discount> searchProducNo(int searchProductNo, int beginRow, int rowPerPage) throws Exception {
		// 반환할 ArrayList<Discount> 생성
		ArrayList<Discount> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT p.product_name productName, d.discount_no discountNo, d.product_no productNo, d.discount_start discountStart, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate createdate, d.updatedate updatedate FROM discount d INNER JOIN product p ON d.product_no = p.product_no WHERE d.product_no = ? ORDER BY d.createdate DESC LIMIT ? ,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, searchProductNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Discount discount = new Discount();
			discount.setProductName(rs.getString("productName"));
			discount.setDiscountNo(rs.getInt("discountNo"));
			discount.setProductNo(rs.getInt("productNo"));
			discount.setDiscountStart(rs.getString("discountStart"));
			discount.setDiscountEnd(rs.getString("discountEnd"));
			discount.setDiscountRate(rs.getDouble("discountRate"));
			discount.setCreatedate(rs.getString("createdate"));
			discount.setUpdatedate(rs.getString("updatedate"));
			list.add(discount);	
		}
		
		return list;
	}
	
	// 할인 품목 개별 조회
	public Discount selectDiscountOne(int discountNo) throws Exception {
		// 반환할 Discount객체 생성
		Discount discount = new Discount();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장 
		String sql = "SELECT p.product_name productName, d.discount_no discountNo, d.product_no productNo, d.discount_start discountStart, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate FROM discount d INNER JOIN product p ON d.product_no = p.product_no WHERE discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discountNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			discount.setProductName(rs.getString("productName"));
			discount.setDiscountNo(rs.getInt("discountNo"));
			discount.setProductNo(rs.getInt("productNo"));
			discount.setDiscountStart(rs.getString("discountStart"));
			discount.setDiscountEnd(rs.getString("discountEnd"));
			discount.setDiscountRate(rs.getDouble("discountRate"));
			discount.setCreatedate(rs.getString("createdate"));
			discount.setUpdatedate(rs.getString("updatedate"));
		}
		
		return discount;
	}
	
	// 상품의 현재 할인 내역 조회
	public Discount selectDiscountOneNow(int productNo) throws Exception {
		// 반환할 ArrayList<Discount> 생성
		Discount discount = null;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT discount_no discountNo, product_no productNo, discount_start discountStart, discount_end discontEnd, discount_rate discountRate, createdate, updatedate FROM discount WHERE product_no=? AND (NOW() BETWEEN discount_start AND discount_end)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			discount = new Discount();
			discount.setDiscountNo(rs.getInt("discountNo"));
			discount.setProductNo(rs.getInt("productNo"));
			discount.setDiscountStart(rs.getString("discountStart"));
			discount.setDiscountEnd(rs.getString("discontEnd"));
			discount.setDiscountRate(rs.getDouble("discountRate"));
			discount.setCreatedate(rs.getString("createdate"));
			discount.setUpdatedate(rs.getString("updatedate"));
		}
		
		return discount;
	}
	
	// 할인 품목 갯수
	public int discountCnt() throws Exception {
		int cnt = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM discount";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		 
		return cnt;
	}
		
	// 같은 제품 할인 기간 중복 체크
	public int checkDiscountPeriod(Discount discount) throws Exception {
		// 중복 체크 변수
		int check = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 같은 제품에 대한 할인 기간 중복 여부 확인
		String checkSql = "";
		PreparedStatement checkStmt = null;

		if(discount.getDiscountNo() != 0) {
			// 수정시 기간 중복 체크
			checkSql = "SELECT COUNT(*) FROM discount WHERE discount_no != ? AND product_no = ? AND ((? BETWEEN discount_start AND discount_end) OR( ? BETWEEN discount_start AND discount_end))";
			checkStmt = conn.prepareStatement(checkSql);
			checkStmt.setInt(1, discount.getDiscountNo());
			checkStmt.setInt(2, discount.getProductNo());
			checkStmt.setString(3, discount.getDiscountStart());
			checkStmt.setString(4, discount.getDiscountEnd());
		} else { 
			// 추가시 기간 중복 체크
			checkSql = "SELECT COUNT(*) FROM discount WHERE product_no = ? AND ((? BETWEEN discount_start AND discount_end) OR (? BETWEEN discount_start AND discount_end))";
			checkStmt = conn.prepareStatement(checkSql);
			checkStmt.setInt(1, discount.getProductNo());
			checkStmt.setString(2, discount.getDiscountStart());
			checkStmt.setString(3, discount.getDiscountEnd());
		}
		ResultSet checkRs = checkStmt.executeQuery();
		if(checkRs.next()) {
			check = checkRs.getInt(1);
		}
		return check;
	}
	
	// 할인 제품 추가
	public int addDiscount(Discount discount) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "INSERT INTO discount(product_no, discount_start, discount_end, discount_rate, createdate, updatedate) VALUES (?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discount.getProductNo());
		stmt.setString(2, discount.getDiscountStart());
		stmt.setString(3, discount.getDiscountEnd());
		stmt.setDouble(4, discount.getDiscountRate());
		
		DiscountDao dd = new DiscountDao();
		int check = dd.checkDiscountPeriod(discount);
		if(check == 0 ) {
			row = stmt.executeUpdate();
		}
		return row;
	}
	
	// 할인 제품 수정
	public int modifyDiscount(Discount discount) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE discount SET discount_start = ?, discount_end = ?, discount_rate = ?, updatedate = NOW() WHERE discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, discount.getDiscountStart());
		stmt.setString(2, discount.getDiscountEnd());
		stmt.setDouble(3, discount.getDiscountRate());
		stmt.setInt(4, discount.getDiscountNo());
		
		DiscountDao dd = new DiscountDao();
		int check = dd.checkDiscountPeriod(discount);
		if(check == 0 ) {
			row = stmt.executeUpdate();
		}
		
		return row;
	}
	
	// 할인 제품 삭제
	public int removeDiscount(int discountNo) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "DELETE FROM discount WHERE discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discountNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 제품 할인율 조회
	public double selectDiscountRate(int productNo) throws Exception {
		// 반환할 할인율 변수 생성
		double rate = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT discount_rate discountRate FROM discount WHERE product_no = ? AND NOW() BETWEEN discount_start AND discount_end";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			rate = rs.getDouble("discountRate");
		}
		
		return rate;
	}
}
