<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%@ page import="java.net.*" %>
<%
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	// 요청값 유효성 검사
	String msg = null;
	if(request.getParameter("empNo") == null
			|| request.getParameter("empNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/employees/employeeOne.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	// 디버깅
	System.out.println(PURPLE + empNo + " <--empNo removeEmployeeAction" + RESET);
	
	
	EmployeesDao ed = new EmployeesDao();
	int row = ed.removeEmployees(empNo);
	// 디버깅
	System.out.println(PURPLE + row + " <--row removeEmployeeAction" + RESET);
	
	if (row == 1){
		msg = URLEncoder.encode("사원이 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/employees/employeeList.jsp?msg="+msg);
		return;
	} else {
		response.sendRedirect(request.getContextPath()+"/employees/employeeList.jsp");
	}
%>