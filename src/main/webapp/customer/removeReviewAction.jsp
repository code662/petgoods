<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
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
	
	// 프로젝트안에 있는 rimg 폴더의 실제 물리적 위치
	String dir = request.getServletContext().getRealPath("/rimg");
		
	// 요청값 유효성 검사
	String msg = null;
	if(request.getParameter("reviewNo") == null
			|| request.getParameter("reviewNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/customer/reviewList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	// 디버깅
	System.out.println(PURPLE + reviewNo + " <-- reviewNo removeReviewAction" + RESET );
	
	ReviewDao rd = new ReviewDao();
	
	// 폴더 안 리뷰이미지파일 삭제 
	String preSaveFilename = rd.selectReviewImgSaveFilename(reviewNo);
	File f = new File(dir+"/"+preSaveFilename);
	if(f.exists()) {
		f.delete();
	}
	
	// DB에서 리뷰, 리뷰이미지 삭제
	int row = rd.removeReview(reviewNo);
	rd.removeReviewImg(reviewNo);
	// 디버깅
	System.out.println(PURPLE + row + " <--row removeReviewAction" + RESET );
	
	if (row == 1){
		msg = URLEncoder.encode("리뷰가 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/reviewList.jsp?msg="+msg);
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/customer/reviewList.jsp");
%>