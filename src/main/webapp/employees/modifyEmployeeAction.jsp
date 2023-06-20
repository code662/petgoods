<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import = "java.net.*"%>
<% 
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	// 요청값 유효성 검사
	if(request.getParameter("empNo") == null
			|| request.getParameter("empLevel") == null
			|| request.getParameter("empNo").equals("")
			|| request.getParameter("empLevel").equals("")){
		response.sendRedirect(request.getContextPath()+"/employees/modifyEmployee.jsp?empNo="+Integer.parseInt(request.getParameter("empNo")));
		return;
	}
	
	// 요청값 변수에 저장
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String empLevel = request.getParameter("empLevel");
	// 디버깅
	System.out.println(PURPLE + empNo + " <--empNo modifyEmployeeAction" + RESET);
	System.out.println(PURPLE + empLevel + " <--empLevel modifyEmployeeAction" + RESET);
	
	// 변수에 저장한 요청값 Employees객체로 묶음
	Employees employees = new Employees();
	employees.setEmpLevel(empLevel);
	employees.setEmpNo(empNo);
	
	EmployeesDao ed = new EmployeesDao();
	int row = ed.modifyEmployees(employees);
	System.out.println(PURPLE + row + " <--row modifyEmployeeAction" + RESET);
	
	String msg = null;
	if(row == 1){ // 변경 성공한 경우
		msg = URLEncoder.encode("사원레벨이 변경되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/modifyEmployee.jsp?empNo="+empNo+"&msg="+msg);
	} else { // 변경 실패한 경우
		msg = URLEncoder.encode("사원레벨 변경에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/modifyEmployee.jsp?empNo="+empNo+"&msg="+msg);
	}
	
%>