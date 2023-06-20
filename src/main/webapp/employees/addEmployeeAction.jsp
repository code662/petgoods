<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import = "java.net.*" %>
<%
	//Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");

	//요청값 유효성 검사
	String msg=null;
	if(request.getParameter("id") == null
			|| request.getParameter("pw") == null
			|| request.getParameter("empName") == null
			|| request.getParameter("empLevel") == null
			|| request.getParameter("id").equals("")
			|| request.getParameter("pw").equals("")
			|| request.getParameter("empName").equals("")
			|| request.getParameter("empLevel").equals("")){
		msg = URLEncoder.encode("정보를 입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployee.jsp?msg="+msg);
		return;
	}

	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String empName = request.getParameter("empName");
	String empLevel = request.getParameter("empLevel");
	
	//디버깅
	System.out.println(PURPLE + id + "<--id addEmployeeAction" + RESET);
	System.out.println(PURPLE + pw + "<--pw addEmployeeAction" + RESET);
	System.out.println(PURPLE + empName + "<--empName addEmployeeAction" + RESET);
	System.out.println(PURPLE + empLevel + "<--empLevel addEmployeeAction" + RESET);
	
	EmployeesDao ed = new EmployeesDao();
	//변수에 저장한 요청값 Employees객체로 묶어주기
	Employees employees = new Employees();
	employees.setId(id);
	employees.setPw(pw);
	employees.setEmpName(empName);
	employees.setEmpLevel(empLevel);
	

	int row = ed.addEmployees(employees);
	if(row == 1){
		msg = URLEncoder.encode("사원등록이 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployee.jsp?msg="+msg);
		return;
	}else{
		msg = URLEncoder.encode("사원등록이 실패하였습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/addEmployee.jsp?msg="+msg);	
	}
%>