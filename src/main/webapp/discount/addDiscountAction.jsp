<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import = "java.net.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");

	// 요청값 유효성 검사
	String msg=null;
	if(request.getParameter("productNo") == null
			|| request.getParameter("discountStart") == null
			|| request.getParameter("discountEnd") == null
			|| request.getParameter("discountRate") == null
			|| request.getParameter("productNo").equals("")
			|| request.getParameter("discountStart").equals("")
			|| request.getParameter("discountEnd").equals("")
			|| request.getParameter("discountRate").equals("")){
		msg = URLEncoder.encode("정보를 입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/discount/addDiscount.jsp?msg="+msg);
		return;
	}

	// 요청값 변수에 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountStart = request.getParameter("discountStart");
	String discountEnd = request.getParameter("discountEnd");
	double discountRate = Double.parseDouble(request.getParameter("discountRate"))/100;
	
	// 디버깅
	System.out.println(PURPLE + productNo + "<--productNo addDiscountAction" + RESET);
	System.out.println(PURPLE + discountStart + "<--discountStart addDiscountAction" + RESET);
	System.out.println(PURPLE + discountEnd + "<--discountEnd addDiscountAction" + RESET);
	System.out.println(PURPLE + discountRate + "<--discountRate addDiscountAction" + RESET);
	
	DiscountDao dd = new DiscountDao();
	// 변수에 저장한 요청값 Discount객체로 묶어주기
	Discount discount = new Discount();
	discount.setProductNo(productNo);
	discount.setDiscountStart(discountStart);
	discount.setDiscountEnd(discountEnd);
	discount.setDiscountRate(discountRate);
	

	int row = dd.addDiscount(discount);
	if(row == 1){
		msg = URLEncoder.encode("할인 상품 등록이 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/discount/addDiscount.jsp?msg="+msg);
		return;
	}else{
		msg = URLEncoder.encode("할인 상품 등록에 실패하였습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/discount/addDiscount.jsp?msg="+msg);	
	}
%>