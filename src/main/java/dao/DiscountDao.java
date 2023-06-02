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
		String sql = "SELECT discount_no discountNo, product_no productNo, discount_start discountStart, discount_end discontEnd, discout_rate discountRate, createdate, updatedate FROM dicount LIMIT ? ,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Discount discount = new Discount();
			discount.setDiscountNo(rs.getInt("discountNo"));
			discount.setProductNo(rs.getInt("productNo"));
			discount.setDiscountStart(rs.getString("discountStart"));
			discount.setDiscountEnd(rs.getString("discontEnd"));
			discount.setDiscountRate(rs.getDouble("discountRate"));
			discount.setCreatedate(rs.getString("createdate"));
			discount.setUpdatedate(rs.getString("updatedate"));
			list.add(discount);	
		}
		
		return list;
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
			checkSql = "SELECT COUNT(*) FROM discount WHERE discount_no != ? AND product_no = ? AND ? BETWEEN discount_start AND discount_end OR ? BETWEEN discount_start AND discount_end";
			checkStmt = conn.prepareStatement(checkSql);
			checkStmt.setInt(1, discount.getDiscountNo());
			checkStmt.setInt(2, discount.getProductNo());
			checkStmt.setString(3, discount.getDiscountStart());
			checkStmt.setString(4, discount.getDiscountEnd());
		} else { 
			// 추가시 기간 중복 체크
			checkSql = "SELECT COUNT(*) FROM discount WHERE product_no = ? AND ? BETWEEN discount_start AND discount_end OR ? BETWEEN discount_start AND discount_end";
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
		row = stmt.executeUpdate();
		
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
		String sql = "UPDATE SET discount_start = ?, discount_end = ?, discout_rate = ?, updatedate = NOW() FROM discount WHERE discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, discount.getDiscountStart());
		stmt.setString(2, discount.getDiscountEnd());
		stmt.setDouble(3, discount.getDiscountRate());
		stmt.setInt(4, discount.getDiscountNo());
		row = stmt.executeUpdate();
		
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
