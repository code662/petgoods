<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	String msg = null;
	
	// 요청값 유효성 검사
	if(request.getParameter("cstmNo") == null 
			|| request.getParameter("id") == null 
			|| request.getParameter("cstmNo").equals("")
			|| request.getParameter("id").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myPage.jsp");
		return;
	}
	
	if(request.getParameter("cstmName") == null 
			|| request.getParameter("cstmEmail") == null 
			|| request.getParameter("currentPw") == null 
			|| request.getParameter("cstmName").equals("")
			|| request.getParameter("cstmEmail").equals("")
			|| request.getParameter("currentPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/customer/modifyCustomer.jsp?cstmNo="+request.getParameter("cstmNo"));
		return;
	}

	// 로그인 세션 정보(비밀번호) 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String pw = c.getPw();
	
	// 요청값 변수에 저장
	int cstmNo = Integer.parseInt(request.getParameter("cstmNo"));
	String id = request.getParameter("id");
	String currentPw = request.getParameter("currentPw");
	String cstmName = request.getParameter("cstmName");
	String cstmEmail = request.getParameter("cstmEmail");

	
	CustomerDao cd = new CustomerDao();
	Customer customer = new Customer();
	customer.setCstmNo(cstmNo);
	customer.setId(id);
	customer.setCstmName(cstmName);
	customer.setCstmEmail(cstmEmail);
	
	int row = 0;
	if(pw.equals(currentPw)){ // 로그인 비밀번호랑 현재비밀번호로 입력된 비밀번호가 같으면 수정 실행 
		row = cd.modifyMyPage(customer);
	}
	// 디버깅
	System.out.println(PURPLE + row +" <-- row modifyCustomerAction" + RESET);
	
	if(row == 1){
		msg = URLEncoder.encode("정보가 수정되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/modifyCustomer.jsp?msg="+msg+"&cstmNo="+cstmNo);
		return;
	}else{
		msg = URLEncoder.encode("정보 수정에 실패하였습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/modifyCustomer.jsp?msg="+msg+"&cstmNo="+cstmNo);	
	}
%>