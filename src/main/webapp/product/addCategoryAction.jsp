<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*" %>  
<%
	// controller
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값 유효성 확인
	// 메인 카테고리명, 서브 카테고리명 중 하나라도 null 또는 공백값이 입력되면 msg와 함께 입력폼으로 다시 이동
	String msg = "";
	if (request.getParameter("categoryMainName") == null
	|| request.getParameter("categoryMainName").equals("")
	|| request.getParameter("categorySubName") == null
	|| request.getParameter("categorySubName").equals("")) {
		msg = URLEncoder.encode("메인, 서브 카테고리명을 모두 입력해주세요.", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/product/addCategory.jsp?msg=" + msg);
		return;
	}
	
	// 넘어온 메인, 서브 카테고리명
	String categoryMainName = request.getParameter("categoryMainName");
	String categorySubName = request.getParameter("categorySubName");
	
	// 디버깅
	System.out.println(categoryMainName + " <-- categoryMainName(addCategory)");
	System.out.println(categorySubName + " <-- categorySubName(addCategory)");
	
	// model
	CategoryDao cateDao = new CategoryDao();
	
	// 카테고리명 중복값 확인 
	int check = cateDao.checkCategorySubName(categoryMainName, categorySubName);
	System.out.println(check + " <-- check(addCategoryAction)");
	if (check == 0) {
		System.out.println("중복값 없음");
	} else {
		System.out.println("중복값 존재");
		msg = URLEncoder.encode("이미 존재하는 메인-서브 카테고리명입니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/product/addCategory.jsp?msg=" + msg);
		return;
	}
	
	Category category = new Category();
	category.setCategoryMainName(categoryMainName);
	category.setCategorySubName(categorySubName);
	
	// 입력 메소드 실행
	int row = cateDao.addCategory(category);
	System.out.println(row + " <-- row(addCategoryAction)");
	
	if (row == 1) {
		System.out.println("입력 성공");
		msg = URLEncoder.encode("새 메인-서브 카테고리명이 입력되었습니다.", "UTF-8"); 
	} else {
		System.out.println("입력 실패");
		msg = URLEncoder.encode("새 메인-서브 카테고리명이 입력에 실패했습니다.", "UTF-8"); 
	}
	
	// 입력 성공 여부 관계없이 메인 카테고리 목록으로 이동
	response.sendRedirect(request.getContextPath() + "/product/mainCategoryList.jsp?msg=" + msg);
	
	System.out.println("=============addCategoryAction.jsp=============");
%>
    
    