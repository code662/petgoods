package dao;

import util.*;
import java.util.*;
import java.sql.*;
import vo.*;
import java.io.*;
import com.oreilly.servlet.*;

public class ProductDao {	
	// 상품 갯수 조회
	public int productCnt(String main, String sub) throws Exception{
		//반환할 전체 행의 수 설정
		int row = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 값 저장
		String sql="SELECT COUNT(*) FROM product p INNER JOIN category c ON p.category_no = c.category_no AND c.category_main_name = ? AND c.category_sub_name = ?";
		if(main.equals("전체") && sub.equals("전체")) {
			sql="SELECT COUNT(*) FROM product";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt(1);
			}
		} else if(!main.equals("전체") && sub.equals("전체")){
			sql="SELECT COUNT(*) FROM product p INNER JOIN category c ON p.category_no = c.category_no AND c.category_main_name = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, main);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt(1);
			}
		} else {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, main);
			stmt.setString(2, sub);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt(1);
			}
		}		
		
		return row;
	}	
	
	// 상품 전체 조회
	public ArrayList<Product> selectProductList(int beginRow, int rowPerPage, String main, String sub) throws Exception{
		 //반환할 리스트
		 ArrayList<Product> list = new ArrayList<>();
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 결과 셋 반환받아 리스트에 저장
		 String sql="SELECT p.product_no productNo, p.category_no categoryNo, p.product_name productName, p.product_stock productStock, p.product_price productPrice, p.product_status productStatus, p.product_info productInfo, p.updatedate, p.createdate FROM product p INNER JOIN category c ON p.category_no = c.category_no AND c.category_main_name = ? AND c.category_sub_name = ? LIMIT ?, ?";
		 if(main.equals("전체") && sub.equals("전체")) {
				sql="SELECT product_no productNo, category_no categoryNo, product_name productName, product_stock productStock, product_price productPrice, product_status productStatus, product_info productInfo, updatedate, createdate FROM product LIMIT ?, ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				 stmt.setInt(1, beginRow);
				 stmt.setInt(2, rowPerPage);
				 ResultSet rs = stmt.executeQuery();
				 while(rs.next()) {
					 Product product = new Product();
					 product.setProductNo(rs.getInt("productNo"));
					 product.setCategoryNo(rs.getInt("categoryNo"));
					 product.setProductName(rs.getString("productName"));
					 product.setProductStock(rs.getInt("productStock"));
					 product.setProductPrice(rs.getInt("productPrice"));
					 product.setProductStatus(rs.getString("productStatus"));
					 product.setProductInfo(rs.getString("productInfo"));
					 product.setUpdatedate(rs.getString("updatedate"));
					 product.setCreatedate(rs.getString("createdate"));
					 list.add(product);
				 }
			} else if(!main.equals("전체") && sub.equals("전체")){
				sql="SELECT p.product_no productNo, p.category_no categoryNo, p.product_name productName, p.product_stock productStock, p.product_price productPrice, p.product_status productStatus, p.product_info productInfo, p.updatedate, p.createdate FROM product p INNER JOIN category c ON c.category_main_name = ? AND p.category_no = c.category_no LIMIT ?, ? ";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, main);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					Product product = new Product();
					product.setProductNo(rs.getInt("productNo"));
					product.setCategoryNo(rs.getInt("categoryNo"));
					product.setProductName(rs.getString("productName"));
					product.setProductStock(rs.getInt("productStock"));
					product.setProductPrice(rs.getInt("productPrice"));
					product.setProductStatus(rs.getString("productStatus"));
					product.setProductInfo(rs.getString("productInfo"));
					product.setUpdatedate(rs.getString("updatedate"));
					product.setCreatedate(rs.getString("createdate"));
					list.add(product);
				}
			} else {
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, main);
				stmt.setString(2, sub);
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					Product product = new Product();
					product.setProductNo(rs.getInt("productNo"));
					product.setCategoryNo(rs.getInt("categoryNo"));
					product.setProductName(rs.getString("productName"));
					product.setProductStock(rs.getInt("productStock"));
					product.setProductPrice(rs.getInt("productPrice"));
					product.setProductStatus(rs.getString("productStatus"));
					product.setProductInfo(rs.getString("productInfo"));
					product.setUpdatedate(rs.getString("updatedate"));
					product.setCreatedate(rs.getString("createdate"));
					list.add(product);
				}
			}
		 
		 return list;
	} 
	
	// 상품 상세페이지 조회 
	public Product selectProductOne(int productNo) throws Exception{
		 //반환할 Employees 객체 생성
		 Product product = null;
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 결과 셋 반환받아 리스트에 저장
		 PreparedStatement stmt = conn.prepareStatement("SELECT product_no productNo, category_no categoryNo, product_name productName, product_stock productStock, product_price productPrice, product_status productStatus, product_info productInfo, updatedate, createdate FROM product WHERE product_no=?");
		 stmt.setInt(1, productNo);
		 ResultSet rs = stmt.executeQuery();
		 if(rs.next()) {
			 product = new Product();
			 product.setProductNo(rs.getInt("productNo"));
			 product.setCategoryNo(rs.getInt("categoryNo"));
			 product.setProductName(rs.getString("productName"));
			 product.setProductStock(rs.getInt("productStock"));
			 product.setProductPrice(rs.getInt("productPrice"));
			 product.setProductStatus(rs.getString("productStatus"));
			 product.setProductInfo(rs.getString("productInfo"));
			 product.setUpdatedate(rs.getString("updatedate"));
			 product.setCreatedate(rs.getString("createdate"));
		 }
		 return product;
	 } 
	
	// 상품 이미지 조회
	public String productImgName (int productNo) throws Exception{
		 //반환할 객체 생성
		 String productImgName = "";
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 결과 셋 반환받아 리스트에 저장
		 String sql="SELECT product_save_filename FROM product_img WHERE product_no = ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setInt(1, productNo);
		 ResultSet rs = stmt.executeQuery();
		 if(rs.next()) {
			 productImgName = rs.getString(1);
		 }
		 
		 return productImgName;
	}
	
	// 상품 이미지 추가
	public int addProductImg(ProductImg productImg) throws Exception{
		// 실행시 영향받는 행 설정
		int row = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO product_img(product_no, product_ori_filename, product_save_filename, product_filetype, updatedate, createdate) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,productImg.getProductNo());
		stmt.setString(2,productImg.getProductOriFilename());
		stmt.setString(3,productImg.getProductSaveFilename());
		stmt.setString(4,productImg.getProductFiletype());
		row = stmt.executeUpdate();
		
		return row;
	}
	// 상품 이미지 수정
	public int modifyProductImg(ProductImg productImg) throws Exception{
		 //sql 실행 시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 영향받은 행의 수 반환받아 저장
		 String sql="UPDATE product_img SET product_ori_filename = ?, product_save_filename = ?, product_filetype = ?, updatedate = NOW() WHERE product_img_no = ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1,productImg.getProductOriFilename());
		 stmt.setString(2,productImg.getProductSaveFilename());
		 stmt.setString(3,productImg.getProductFiletype());
		 stmt.setInt(4,productImg.getProductImgNo());
		 row = stmt.executeUpdate();
		
		 return row;
	 }
	
	// 상품 이미지 삭제
	public int removeProductImg(int productImgNo) throws Exception{
		 //sql 실행 시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 영향받은 행의 수 반환받아 저장
		 String sql="DELETE FROM product_img WHERE product_img_no = ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setInt(1, productImgNo);
		 row = stmt.executeUpdate();
		 if(row==1) {
				System.out.println("삭제 성공");
			}else {
				System.out.println("삭제 실패");
			}
		
		 return row;
	}	 
	// 상품 추가
	public int addProduct(Product product) throws Exception{
		// 실행시 영향받는 행 설정
		int row = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO product(category_no, product_name, product_stock, product_price, product_status, product_info, updatedate, createdate) VALUES(?,?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,product.getCategoryNo());
		stmt.setString(2,product.getProductName());
		stmt.setInt(3,product.getProductStock());
		stmt.setInt(4,product.getProductPrice());
		stmt.setString(5,product.getProductStatus());
		stmt.setString(6,product.getProductInfo());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 상품 수정
	public int modifyProduct(Product product) throws Exception{
		 //sql 실행 시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 영향받은 행의 수 반환받아 저장
		 String sql="UPDATE product SET category_no = ?, product_name = ?, product_stock = ?, product_price = ?, product_status = ?, product_info = ?, updatedate = NOW() WHERE product_no = ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setInt(1,product.getCategoryNo());
		 stmt.setString(2,product.getProductName());
		 stmt.setInt(3,product.getProductStock());
		 stmt.setInt(4,product.getProductPrice());
		 stmt.setString(5,product.getProductStatus());
		 stmt.setString(6,product.getProductInfo());
		 stmt.setInt(7,product.getProductNo());
		 row = stmt.executeUpdate();
		
		 return row;
	 }
	
	// 상품 삭제
	public int removeProduct(int productNo) throws Exception{
		 //sql 실행 시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 영향받은 행의 수 반환받아 저장
		 String sql="DELETE FROM product WHERE product_no = ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setInt(1, productNo);
		 row = stmt.executeUpdate();
		 if(row==1) {
				System.out.println("삭제 성공");
			}else {
				System.out.println("삭제 실패");
			}
		
		 return row;
	 }
	
}
