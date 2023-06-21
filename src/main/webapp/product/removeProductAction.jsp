<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	// utf-8 인코딩 설정
	request.setCharacterEncoding("utf-8");
	
	// 프로젝트안에 있는 pimg 폴더의 실제 물리적 위치
	String dir = request.getServletContext().getRealPath("/pimg");
	
	// 요청값 유효성 검사
	if(request.getParameter("productNo") == null					// 파라미터 값이 null이거나 공백이면
		|| request.getParameter("productNo").equals("")) {
		// modifyProduct로 가라
		response.sendRedirect(request.getContextPath() + "/product/modifyProduct.jsp?productNo="+request.getParameter("productNo"));
		return;
	}

	// 요청값 변수 저장
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// 삭제하려는 상품의 주문 수 조회
	OrdersDao oDao = new OrdersDao();
	int cnt = oDao.selectOrdersCntByProduct(productNo);
	// 삭제하려는 상품에 주문 내역이 없으면
	if(cnt == 0) {
		// 상품 이미지 삭제
		ProductDao pDao = new ProductDao();
		String preSaveFilename = pDao.productImgName(productNo);
		File f = new File(dir+"/"+preSaveFilename);
		if(f.exists()) {
			f.delete();
		}
		// 상품 이미지, 상품 DB 삭제
		pDao.removeProductImg(productNo);
		pDao.removeProduct(productNo);
		System.out.println("상품 삭제 성공");
	} else {
		System.out.println("주문내역이 있어 삭제할 수 없습니다");
	}
	
	response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
%>