package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class CategoryDao {
	/*
	 * // 메인 카테고리 조회 public ArrayList<Category> selectMainCategory() throws
	 * Exception { // 반환할 ArrayList<Address> 생성 ArrayList<Category> list = new
	 * ArrayList<>(); // DB 접속 DBUtil dbUtil = new DBUtil(); Connection conn =
	 * dbUtil.getConnection(); // sql 전송 후 결과셋 반환받아 리스트에 저장 String sql =
	 * "SELECT category_no categoryNo, category_main_name categoryMainName, category_sub_name categorySubName, createdate, updatedate FROM category"
	 * ; PreparedStatement stmt = conn.prepareStatement(sql);
	 * 
	 * ResultSet rs = stmt.executeQuery(); while(rs.next()) { Category category =
	 * new Category(); category.setCategoryNo(rs.getInt("categoryNo"));
	 * category.setCategoryMainName(rs.getString("categoryMainName"));
	 * category.setCategorySubName(rs.getString("categorySubName"));
	 * category.setCreatedate(rs.getString("createdate"));
	 * category.setUpdatedate(rs.getString("updatedate")); list.add(category); }
	 * return list; }
	 */
	
	// 전체 카테고리 조회
	public ArrayList<Category> selectCategory() throws Exception {
		// 반환할 ArrayList<Address> 생성
		ArrayList<Category> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT category_no categoryNo, category_main_name categoryMainName, category_sub_name categorySubName, createdate, updatedate FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
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

	// 메인 카테고리 조회 (메인, 메인에 속한 서브 카테고리 출력)
	public ArrayList<Category> selectMainCategory() throws Exception {
		ArrayList<Category> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		// GROUP BY -> 여러 값이 그룹화되기 때문에 MIN()과 같은 집계함수 사용하지 않으면 의도와 달리 그룹 내 다른 값으로 덮어쓰기 될
		// 수 있음
		String sql = "SELECT MIN(category_no) categoryNo, category_main_name categoryMainName, GROUP_CONCAT(category_sub_name SEPARATOR '  ') categorySubName, MIN(createdate) createdate, updatedate FROM category GROUP BY category_main_name ORDER BY category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryMainName(rs.getString("categoryMainName"));
			category.setCategorySubName(rs.getString("categorySubName"));
			category.setCreatedate(rs.getString("createdate"));
			category.setUpdatedate(rs.getString("updatedate"));
			list.add(category);
		}

		return list;
		/*
		 * SELECT category_main_name, GROUP_CONCAT(category_sub_name) AS sub_categories
		 * FROM category GROUP BY category_main_name;
		 */
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
		while (rs.next()) {
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
		String sql = "DELETE FROM category WHERE category_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();

		return row;
	}

	// 카테고리 입력, 수정 시 category_main_name, category_sub_name 쌍 중복검사
	public int checkCategoryDuplicate(String categoryMainName, String categorySubName) throws Exception {
		// 메인 카테고리 내 서브 카테고리명 중복 체크 변수
		int check = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// SQL 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT COUNT(*) FROM category WHERE category_main_name = ? AND category_sub_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryMainName);
		stmt.setString(2, categorySubName);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			check = rs.getInt(1);
		}
		return check; // 1일 경우 중복값 있음
	}

	// 카테고리 1개 상세정보
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_main_name categoryMainName, category_sub_name categorySubName, createdate, updatedate FROM category WHERE category_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		ResultSet rs = stmt.executeQuery();
		category = new Category();
		while (rs.next()) {
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryMainName(rs.getString("categoryMainName"));
			category.setCategorySubName(rs.getString("categorySubName"));
			category.setCreatedate(rs.getString("createdate"));
			category.setUpdatedate(rs.getString("updatedate"));
		}

		return category;
	}
	
	// 메인-서브 카테고리 내 입력값(상품) 개수
	public int productCnt(int categoryNo) throws Exception {
		// 메인-서브 카테고리에 존재하는 상품 개수
		int cnt = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) FROM product WHERE category_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			cnt = rs.getInt(1);
		}
		
		return cnt; // 0일 경우 해당 메인-서브 카테고리에 상품 없음
	}
}