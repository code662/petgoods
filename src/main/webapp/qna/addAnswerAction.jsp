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
		|| request.getParameter("AnswerContent") == null
		|| request.getParameter("questionNo").equals("")
		|| request.getParameter("AnswerContent").equals("")) { 
		
		response.sendRedirect(request.getContextPath()+"/qna/questionOne.jsp?questionNo="+request.getParameter("questionNo"));
		return;
	}
	
	// 파라미터 변수에 저장
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	String AnswerContent = request.getParameter("AnswerContent");
	
	// 답변 정보 객체에 저장
	Answer answer = new Answer();
	answer.setqNo(questionNo);
	answer.setId(emp.getId());
	answer.setaContent(AnswerContent);
	
	// 답변 DB에 저장
	AnswerDao aDao = new AnswerDao();
	int row = aDao.addAnswer(answer);
	
	// 답변 등록이 성공하면
	if(row == 1) {
		// 문의 상태 답변완료로 변경
		row = aDao.completeAnswer(questionNo);
	} else {
		// 실패
		row = 0;
	}
	
	if(row == 1) {
		System.out.println("답변 등록 성공");
	} else {
		System.out.println("답변 등록 실패");
	}
	
	response.sendRedirect(request.getContextPath() + "/qna/questionOne.jsp?questionNo="+questionNo);
%>
