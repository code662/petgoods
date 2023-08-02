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
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
		
	// 요청값 유효성 검사
	String msg = null;
	if(request.getParameter("questionNo") == null
			|| request.getParameter("questionNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/qna/myQuestionList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	// 디버깅
	System.out.println(questionNo + " <-- questionNo removeQuestionAction");
	
	QuestionDao qd = new QuestionDao();
	
	
	// DB에서 리뷰, 리뷰이미지 삭제
	int row = qd.removeQuestion(questionNo);
	// 디버깅
	System.out.println(row + " <--row removeQuestionAction");
	
	if (row == 1){
		msg = URLEncoder.encode("문의가 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/qna/myQuestionList.jsp?msg="+msg);
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/qna/myQuestionList.jsp");
%>