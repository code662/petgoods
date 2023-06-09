<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
    
<%
	// controller

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");	

	// 입력값 유효성 확인
	// CategoryDao.java에서 설정한 삭제 메소드의 쿼리문에 따라 categoryNo 값만 확인
	if (request.getParameter("categoryNo") == null
	|| request.getParameter("categoryNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/product/mainCategoryList.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	System.out.println(categoryNo + " <-- categoryNo(removeCategoryAction)");
	
	// model
	CategoryDao cateDao = new CategoryDao();
	
	int row = cateDao.removeCategory(categoryNo);
	System.out.println(row + " <-- removeCategoryAction");
	
	String msg = "";
	if (row == 1) {
		System.out.println("삭제 성공");
		msg = URLEncoder.encode("해당 메인-서브 카테고리 정보가 삭제되었습니다.", "UTF-8"); 
	} else {
		System.out.println("삭제 실패");
		msg = URLEncoder.encode("카테고리 정보가 삭제에 실패했습니다.", "UTF-8");
	}
	
	// 삭제 성공 여부 관계없이 메시지와 함께 메인 카테고리 목록으로 이동
	response.sendRedirect(request.getContextPath() + "/product/mainCategoryList.jsp?msg=" + msg);

	System.out.println("==============removeCategoryAction.jsp==============");
%>