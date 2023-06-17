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
	if(request.getParameter("postcode") == null 
			|| request.getParameter("address") == null 
			|| request.getParameter("detailAddress") == null 
			|| request.getParameter("postcode").equals("")
			|| request.getParameter("address").equals("")
			|| request.getParameter("detailAddress").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/addAddress.jsp");
		return;
	}
	
	//요청값 변수에 저장
	String addAddress = request.getParameter("postcode") + " " + request.getParameter("address") + " " + request.getParameter("detailAddress") + request.getParameter("extraAddress");
	//디버깅
	System.out.println(PURPLE + addAddress + RESET +"<--addAddress addAddressAction");
	
	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId();
	
	AddressDao ad = new AddressDao();
	Address address = new Address();
	address.setId(id);
	address.setAddress(addAddress);
	
	int row = ad.addAddress(address);
	String msg = null;
	if(row == 1){
		msg = URLEncoder.encode("배송지가 추가되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp?msg="+msg);
		return;
	}
	response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp");
%>