<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%@ page import="java.net.*" %>
<%
	//세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	//요청값 유효성 검사
	String msg = null;
	if(request.getParameter("addressNo") == null
			|| request.getParameter("addressNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	// 디버깅
	System.out.println(PURPLE + addressNo + " <-- addressNo removeAddressAction" + RESET );
	
	AddressDao ad = new AddressDao();
	int row = ad.removeAddress(addressNo);
	//디버깅
	System.out.println(PURPLE + row + " <--row removeAddressAction" + RESET );
	
	if(row == 1){
		msg = URLEncoder.encode("배송지가 삭제되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp?msg="+msg);
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp");
%>