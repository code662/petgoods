<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 로그인 아이디 유효성 검사
	if(session.getAttribute("loginId") == null
		|| !(session.getAttribute("loginId") instanceof Customer)) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	Customer cstm = (Customer)session.getAttribute("loginId");

	System.out.println(request.getParameter("questionNo") + "<-- questionNo modifyQuestionAction"); 
	// 파라미터 유효성 검사
	if(request.getParameter("questionNo") == null
		|| request.getParameter("questionNo").equals("")) {  
		
		response.sendRedirect(request.getContextPath()+"/qna/myQustionList.jsp");
		return;
	}
	if(request.getParameter("questionTitle") == null
		|| request.getParameter("questionCategory") == null
		|| request.getParameter("questionContent") == null
		|| request.getParameter("questionTitle").equals("")
		|| request.getParameter("questionCategory").equals("")
		|| request.getParameter("questionContent").equals("")) { 
		
		response.sendRedirect(request.getContextPath()+"/qna/myQuestionOne.jsp?questionNo="+request.getParameter("questionNo"));
		return;
	}
	
	// 파라미터 변수에 저장
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	String questionTitle = request.getParameter("questionTitle");
	String questionCategory = request.getParameter("questionCategory");
	String questionContent = request.getParameter("questionContent");
	
	// 문의 정보 객체에 저장
	Question question = new Question();
	question.setqNo(questionNo);
	question.setId(cstm.getId());
	question.setqTitle(questionTitle);
	question.setqCategory(questionCategory);
	question.setqContent(questionContent);
	
	// 문의 DB 수정
	QuestionDao qDao = new QuestionDao();
	int row = qDao.modifyQuestion(question);
	
	if(row == 1) {
		System.out.println("답변 수정 성공");
	} else {
		System.out.println("답변 수정 실패");
	}
	
	response.sendRedirect(request.getContextPath() + "/qna/myQuestionOne.jsp?questionNo="+questionNo);
%>
