package dao;

import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class LoginDao {
	// 관리자,고객 로그인 정보 조회
	public HashMap<String, Object> selectLogin(String id, String pw) throws Exception{
		 //반환할 리스트
		 HashMap<String, Object> map = new HashMap<>();
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 String sql = "";
		 int check = checkId(id, pw);
		 if(check == 1) {
			 if(checkCustomer(id) == 1) {
					//sql 전송 후 결과 셋 반환받아 리스트에 저장
					 sql = "SELECT cstm_no cstmNo, id, cstm_name cstmName, cstm_email cstmEmail, cstm_birth cstmBirth, cstm_gender cstmGender, cstm_rank cstmRank, cstm_point cstmPoint, cstm_last_login cstmLastLogin, cstm_agree cstmAgree, createdate, updatedate FROM customer WHERE id = ?";
					 PreparedStatement stmt = conn.prepareStatement(sql);
					 stmt.setString(1, id);
					 ResultSet rs = stmt.executeQuery();
					 if(rs.next()) {
						 Customer customer = new Customer();
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
						 customer.setUpdatedate(rs.getString("updatedate"));
						 customer.setCreatedate(rs.getString("createdate"));
						 customer.setPw(pw);
						 map.put("login", customer);
					 } 
				 } else if(checkEmployees(id) == 1) {
					//sql 전송 후 결과 셋 반환받아 리스트에 저장
					 sql = "SELECT  emp_no empNo, id, emp_name empName, emp_level empLevel, createdate, updatedate FROM employees WHERE id = ?";
					 PreparedStatement stmt = conn.prepareStatement(sql);
					 stmt.setString(1, id);
					 ResultSet rs = stmt.executeQuery();
					 if(rs.next()) {
						 Employees employees = new Employees();
						 employees.setEmpNo(rs.getInt("empNo"));
						 employees.setId(rs.getString("id"));
						 employees.setEmpName(rs.getString("empName"));
						 employees.setEmpLevel(rs.getString("empLevel"));
						 employees.setUpdatedate(rs.getString("updatedate"));
						 employees.setCreatedate(rs.getString("createdate"));
						 employees.setPw(pw);
						 map.put("login", employees);
					 }
				 } 
		 }	 
		 return map;
	} 
	
	// 관리자인지 고객인지 체크
	
	// 고객 체크 
	public int checkCustomer(String id) throws Exception{
		// 변수 선언
		int check = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql ="SELECT COUNT(*) FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			check = rs.getInt(1);
		}
		return check;
	}
	
	// 관리자 체크 
	public int checkEmployees(String id) throws Exception{
		// 변수 선언
		int check = 0;
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql ="SELECT COUNT(*) FROM employees WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			check = rs.getInt(1);
		}
		return check;
	}
	// 아이디 체크
	public int checkId(String id, String pw) throws Exception {
		int check = 0;
		
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 결과 셋 반환받아 리스트에 저장
		String sql ="SELECT COUNT(*) FROM id_list WHERE id = ? AND last_pw =  PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			check = rs.getInt(1);
		}
		return check;
	}
}
