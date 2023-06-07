package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class CategoryDao {
	// 메인 카테고리 조회
	public ArrayList<Category> selectMainCategory() throws Exception {
		// 반환할 ArrayList<Address> 생성
		ArrayList<Category> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT category_no categoryNo, category_main_name categoryMainName, category_sub_name categorySubName, createdate, updatedate FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryMainName(rs.getString("categoryMainName"));
			category.setCategorySubName(rs.getString("categorySubName"));
			category.setCreatedate(rs.getString("createdate"));
			category.setUpdatedate(rs.getString("updatedate"));
			list.add(category);	
		}
		return list;
	}
	
	// 서브 카테고리 조회
	public ArrayList<Category> selectSubCategory(String categoryMainName) throws Exception {
		// 반환할 ArrayList<Address> 생성
		ArrayList<Category> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT category_no categoryNo, category_main_name categoryMainName, category_sub_name categorySubName, createdate, updatedate FROM category WHERE category_main_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryMainName);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryMainName(rs.getString("categoryMainName"));
			category.setCategorySubName(rs.getString("categorySubName"));
			category.setCreatedate(rs.getString("createdate"));
			category.setUpdatedate(rs.getString("updatedate"));
			list.add(category);	
		}
		return list;
	}
	
	// 카테고리 추가
	public int addCategory(Category category) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "INSERT INTO category(category_main_name, category_sub_name, createdate, updatedate) VALUES(?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryMainName());
		stmt.setString(2, category.getCategorySubName());

		row = stmt.executeUpdate();
		
		return row;
	}	
	
	// 카테고리 수정
	public int modifyCategory(Category category) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE category SET category_main_name = ?, category_sub_name = ?, updatedate = NOW() WHERE category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryMainName());
		stmt.setString(2, category.getCategorySubName());
		stmt.setInt(3, category.getCategoryNo());
		row = stmt.executeUpdate();
		
		return row;
	}	
	
	// 카테고리 삭제
	public int removeCategory(int categoryNo) throws Exception {
		// sql 실행시 영향받은 행의 수 
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql ="DELETE FROM category WHERE category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		
		return row;
	}
}