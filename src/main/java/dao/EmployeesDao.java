package dao;

import util.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class EmployeesDao {
	// 사원리스트 조회
	public ArrayList<Employees> selectEmployeesListByPage(int beginRow, int rowPerPage) throws Exception{
		 //반환할 리스트
		 ArrayList<Employees> list = new ArrayList<>();
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 결과 셋 반환받아 리스트에 저장
		 PreparedStatement stmt = conn.prepareStatement("SELECT emp_no empNo, id, emp_name empName, emp_level empLevel, updatedate, createdate FROM employees LIMIT ?, ?");
		 stmt.setInt(1, beginRow);
		 stmt.setInt(2, rowPerPage);
		 ResultSet rs = stmt.executeQuery();
		 while(rs.next()) {
			 Employees employees = new Employees();
			 employees.setEmpNo(rs.getInt("empNo"));
			 employees.setId(rs.getString("id"));
			 employees.setEmpName(rs.getString("empName"));
			 employees.setEmpLevel(rs.getString("empLevel"));
			 employees.setUpdatedate(rs.getString("updatedate"));
			 employees.setCreatedate(rs.getString("createdate"));
			 list.add(employees);
		 }
		 return list;
	} 
	
	// 사원 상세정보 조회
	 public Employees selectEmployeesOne(int empNo) throws Exception{
		 //반환할 Employees 객체 생성
		 Employees employees = null;
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 결과 셋 반환받아 리스트에 저장
		 PreparedStatement stmt = conn.prepareStatement("SELECT emp_no empNo, id, emp_name empName, emp_level empLevel, updatedate, createdate FROM employees WHERE emp_no=?");
		 stmt.setInt(1, empNo);
		 ResultSet rs = stmt.executeQuery();
		 if(rs.next()) {
			 employees = new Employees();
			 employees.setEmpNo(rs.getInt("empNo"));
			 employees.setId(rs.getString("id"));
			 employees.setEmpName(rs.getString("empName"));
			 employees.setEmpLevel(rs.getString("empLevel"));
			 employees.setUpdatedate(rs.getString("updatedate"));
			 employees.setCreatedate(rs.getString("createdate"));
		 }
		 return employees;
	 } 

	// 전체 사원 수
	 public int selectEmployeesCnt() throws Exception{
		 //반환할 전체 행의 수
		 int row = 0;
		 //db접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 결과 셋 반환받아 값 저장
		 PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM employees");
		 ResultSet rs = stmt.executeQuery();
		 if(rs.next()) {
			 row = rs.getInt(1);
		 }
		 
		 return row;
	 }
	 
	// 사원 추가
	 public int addEmployees(Employees employees) throws Exception{
		 //sql 실행시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 // id 중복 검사 후 id_list에 추가
		 IdDao idDao = new IdDao();
		 Id id = new Id();
		 id.setId(employees.getId());
		 id.setLastPw(employees.getPw());
		 int check = idDao.addIdList(id);
		 if(check == 1) {
			//employees 추가
			 String sql = "INSERT INTO employees(id, emp_name, emp_level, createdate, updatedate) VALUES(?, ?, ?, NOW(), NOW())";
			 PreparedStatement stmt = conn.prepareStatement(sql);
			 stmt.setString(1, employees.getId());
			 stmt.setString(2, employees.getEmpName());
			 stmt.setString(3, employees.getEmpLevel());
			 row = stmt.executeUpdate();
		 }
		 
		 return row;
	 } 
	
	// 레벨2가 전 사원 레벨 수정
	 public int modifyEmployees(Employees employees) throws Exception{
		 //sql 실행 시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 영향받은 행의 수 반환받아 저장
		 String sql="UPDATE employees SET emp_level = ?, updatedate = NOW() WHERE emp_no = ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, employees.getEmpLevel());
		 stmt.setInt(2, employees.getEmpNo());
		 row = stmt.executeUpdate();
		 
		 return row;
	 } 
	
	// 사원 삭제
	public int removeEmployees(int empNo) throws Exception{
		//sql 실행 시 영향받은 행의 수
		int row = 0;
		//db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql="DELETE FROM employees WHERE emp_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("삭제 성공");
		}else {
			System.out.println("삭제 실패");
		}
		
		return row;
	}
	 
	// 자기 자신의 정보 변경
	public int modifyMyEmp(String beforePw, Employees employees) throws Exception{
		 //sql 실행 시 영향받은 행의 수
		 int row = 0;
		 //db 접속
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		 //sql 전송 후 영향받은 행의 수 반환받아 저장
		 String sql="UPDATE employees SET emp_name = ?, updatedate = NOW() WHERE emp_no = ? AND emp_name != ?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, employees.getEmpName());
		 stmt.setInt(2, employees.getEmpNo());
		 stmt.setString(3, employees.getEmpName());
		 
		 
		 IdDao idDao = new IdDao();
		 if(!beforePw.equals(employees.getPw())) {
			 Id id = new Id();
			 id.setId(employees.getId());
			 id.setLastPw(employees.getPw());
			 int pwRow = idDao.modifyLastPw(id);
			 if(pwRow == 1) {
				 row = stmt.executeUpdate();
			 }
		 }
		 
		 return row;
	 } 
}
