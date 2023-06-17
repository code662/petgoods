<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
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
			|| request.getParameter("addressNo") == null
			|| request.getParameter("postcode").equals("")
			|| request.getParameter("address").equals("")
			|| request.getParameter("detailAddress").equals("")
			|| request.getParameter("addressNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/modifyAddress.jsp");
		return;
	}
	
	//요청값 변수에 저장
	String addAddress = request.getParameter("postcode") + " " + request.getParameter("address") + " " + request.getParameter("detailAddress") + request.getParameter("extraAddress");
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	//디버깅
	System.out.println(PURPLE + addAddress + RESET +"<--addAddress modifyAddressAction");
	System.out.println(PURPLE + addressNo + RESET +"<--addressNo modifyAddressAction");
	
	AddressDao ad = new AddressDao();
	Address address = new Address();
	address.setAddress(addAddress);
	address.setAddressNo(addressNo);
	
	int row = ad.modifyAddress(address);
	String msg = null;
	if(row == 1){
		msg = URLEncoder.encode("배송지가 수정되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp?msg="+msg);
		return;
	}
	response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp");

%>