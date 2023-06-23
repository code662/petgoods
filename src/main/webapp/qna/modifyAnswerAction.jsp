<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 로그인 아이디 유효성 검사
	if(session.getAttribute("loginId") == null
		|| !(session.getAttribute("loginId") instanceof Employees)) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	Employees emp = (Employees)session.getAttribute("loginId");

	// 파라미터 유효성 검사
	if(request.getParameter("questionNo") == null
		|| request.getParameter("answerNo") == null
		|| request.getParameter("AnswerContent") == null
		|| request.getParameter("questionNo").equals("")
		|| request.getParameter("answerNo").equals("") 
		|| request.getParameter("AnswerContent").equals("")) { 
		
		response.sendRedirect(request.getContextPath()+"/qna/questionOne.jsp?questionNo="+request.getParameter("questionNo"));
		return;
	}
	
	// 파라미터 변수에 저장
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	int answerNo = Integer.parseInt(request.getParameter("answerNo"));
	String AnswerContent = request.getParameter("AnswerContent");
	
	// 답변 정보 객체에 저장
	Answer answer = new Answer();
	answer.setaNo(answerNo);
	answer.setId(emp.getId());
	answer.setaContent(AnswerContent);
	
	// 답변 DB 수정
	AnswerDao aDao = new AnswerDao();
	int row = aDao.modifyAnswer(answer);
	
	if(row == 1) {
		System.out.println("답변 수정 성공");
	} else {
		System.out.println("답변 수정 실패");
	}
	
	response.sendRedirect(request.getContextPath() + "/qna/questionOne.jsp?questionNo="+questionNo);
%>
