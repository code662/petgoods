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
	if(request.getParameter("id") == null
			|| request.getParameter("pw") == null
			|| request.getParameter("cstmName") == null
			|| request.getParameter("cstmEmail") == null
			|| request.getParameter("cstmBirth") == null
			|| request.getParameter("cstmGender") == null
			|| request.getParameter("agree_all") == null
			|| request.getParameter("id").equals("")
			|| request.getParameter("pw").equals("")
			|| request.getParameter("cstmName").equals("")
			|| request.getParameter("cstmEmail").equals("")
			|| request.getParameter("cstmBirth").equals("")
			|| request.getParameter("cstmGender").equals("")
			|| request.getParameter("agree_all").equals("")){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}

	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String cstmName = request.getParameter("cstmName");
	String cstmEmail = request.getParameter("cstmEmail");
	String cstmBirth = request.getParameter("cstmBirth");
	String cstmGender = request.getParameter("cstmGender");
	String cstmAgree = request.getParameter("agree_all");
	
	//디버깅
	System.out.println(PURPLE + id + "<--id addCustomerAction" + RESET);
	System.out.println(PURPLE + pw + "<--pw addCustomerAction" + RESET);
	System.out.println(PURPLE + cstmName + "<--cstmName addCustomerAction" + RESET);
	System.out.println(PURPLE + cstmEmail + "<--cstmEmail addCustomerAction" + RESET);
	System.out.println(PURPLE + cstmBirth + "<--cstmBirth addCustomerAction" + RESET);
	System.out.println(PURPLE + cstmGender + "<--cstmGender addCustomerAction" + RESET);
	System.out.println(PURPLE + cstmAgree + "<--cstmAgree addCustomerAction" + RESET);
	
	CustomerDao cd = new CustomerDao();
	
	//변수에 저장한 요청값 Customer객체로 묶어주기
	Customer customer = new Customer();
	customer.setId(id);
	customer.setPw(pw);
	customer.setCstmName(cstmName);
	customer.setCstmEmail(cstmEmail);
	customer.setCstmBirth(cstmBirth);
	customer.setCstmGender(cstmGender);
	customer.setCstmAgree(cstmAgree);
	
	int row = cd.addCustomer(customer);
	String msg = null;
	String msgAdd = null;
	if(row == 1){
		msg = URLEncoder.encode("회원가입이 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}else{
		// id가 중복된 경우 alert에 띄울 메시지 리다이렉션
		IdDao idDao = new IdDao();
		int chk = idDao.checkId(id);
		if(chk == 1){
			msgAdd = URLEncoder.encode("중복된 아이디가 존재합니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/login.jsp?msgAdd="+msgAdd);
			return;
		}
	}
	response.sendRedirect(request.getContextPath()+"/login.jsp");
%>