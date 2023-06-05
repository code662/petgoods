package dao;

import util.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ReviewDao {
	// 상품 리뷰 갯수
	public int reviewCnt(int productNo) throws Exception {
		int cnt = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM review r INNER JOIN order o ON r.order_no = o.order_no AND o.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		 
		return cnt;
	}
	
	// 내 상품 리뷰 갯수
	public int reviewCnt(String id) throws Exception {
		int cnt = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM review r INNER JOIN order o ON r.order_no = o.order_no AND o.id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		 
		return cnt;
	}
	// 상품 리뷰 조회
	public ArrayList<HashMap<String,Object>> selectReview(int productNo, int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "SELECT r.review_no reviewNo, r.order_no orderNo, o.id id, r.review_title reviewTitle, r.review_content reviewContent, r.createdate createdate FROM review r INNER JOIN order o ON r.order_no = o.order_no AND o.product_no = ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<>();
			map.put("reviewNo", rs.getInt("reviewNo"));
			map.put("orderNo", rs.getInt("orderNo"));
			map.put("id", rs.getString("id"));
			map.put("reviewTitle", rs.getString("reviewTitle"));
			map.put("reviewContent", rs.getString("reviewContent"));
			map.put("createdate", rs.getString("createdate"));
			list.add(map);
		}
		 
		return list;
	}
	// 내 리뷰 조회
	public ArrayList<HashMap<String,Object>> selectReview(String id, int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "SELECT r.review_no reviewNo, r.order_no orderNo, o.id id, r.review_title reviewTitle, r.review_content reviewContent, r.createdate createdate FROM review r INNER JOIN order o ON r.order_no = o.order_no AND o.id = ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<>();
			map.put("reviewNo", rs.getInt("reviewNo"));
			map.put("orderNo", rs.getInt("orderNo"));
			map.put("id", rs.getString("id"));
			map.put("reviewTitle", rs.getString("reviewTitle"));
			map.put("reviewContent", rs.getString("reviewContent"));
			map.put("createdate", rs.getString("createdate"));
			list.add(map);
		}
		 
		return list;
	}
	// 리뷰 추가
	public int addReview(Review review) throws Exception {
		int row = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "INSERT INTO review(order_no, review_title, review_content, createdate, updatedate) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, review.getOrderNo());
		stmt.setString(2, review.getReviewTitle());
		stmt.setString(3, review.getReviewContent());
		row = stmt.executeUpdate();
		
		return row;
	}
	// 리뷰 수정
	public int modifyReview(Review review) throws Exception {
		int row = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "UPDATE review SET review_title = ?, review_content = ?, updatedate = NOW() WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, review.getReviewTitle());
		stmt.setString(2, review.getReviewContent());
		stmt.setInt(3, review.getReviewNo());
		row = stmt.executeUpdate();
		
		return row;
	}
	// 리뷰 삭제
	public int removeReview(int reviewNo) throws Exception {
		int row = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql = "DELETE FROM review WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	// 리뷰 이미지 조회
	public String reviewImgName (int reviewNo) throws Exception{
		//반환할 객체 생성
		String reviewImgName = "";
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql="SELECT review_save_filename FROM review_img WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			reviewImgName = rs.getString(1);
		}
		 
		return reviewImgName;
	}
	// 리뷰 이미지 추가
	public int addReviewImg (ReviewImg reviewImg) throws Exception{
		//반환할 객체 생성
		int row = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql="INSERT INTO review_img(review_no, review_ori_filename, review_save_filename, review_filetype, createdate, updatedate) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewImg.getReviewNo());
		stmt.setString(2, reviewImg.getReviewOriFilename());
		stmt.setString(3, reviewImg.getReviewSaveFilename());
		stmt.setString(4, reviewImg.getReviewFiletype());
		
		row = stmt.executeUpdate();
		 
		return row;
	}
	// 리뷰 이미지 수정
	public int modifyReviewImg (ReviewImg reviewImg) throws Exception{
		//반환할 객체 생성
		int row = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql="UPDATE review_img SET review_ori_filename = ?, review_save_filename = ?, review_filetype = ?, updatedate = NOW() WHERE review_img_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, reviewImg.getReviewOriFilename());
		stmt.setString(2, reviewImg.getReviewSaveFilename());
		stmt.setString(3, reviewImg.getReviewFiletype());
		stmt.setInt(4, reviewImg.getReviewImgNo());
		
		row = stmt.executeUpdate();
		 
		return row;
	}
	// 리뷰 이미지 삭제
	public int removeReviewImg (int reviewImgNo) throws Exception{
		//반환할 객체 생성
		int row = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql="DELETE FROM review_img WHERE review_img_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewImgNo);
		
		row = stmt.executeUpdate();
		 
		return row;
	}
}
