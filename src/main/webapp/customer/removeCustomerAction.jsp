<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%@ page import="java.net.*" %>
<%
	//세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	//요청값 유효성 검사
	String msg = null;
	if(request.getParameter("pw") == null
			|| request.getParameter("pw").equals("")){
		response.sendRedirect(request.getContextPath()+"/customer/removeCustomer.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	String pw = request.getParameter("pw");
	
	// 로그인 세션 정보 객체에 저장
	CustomerDao cd = new CustomerDao();
	Customer c =(Customer)session.getAttribute("loginId");
	
	int row = 0;
	if(pw.equals(c.getPw())){ // 로그인 비밀번호랑 현재비밀번호로 입력된 비밀번호가 같으면 삭제 실행 
		row = cd.removeCustomer(c.getId());
	}
	//디버깅
	System.out.println(PURPLE + row + " <--row removeCustomer" + RESET);
	
	if (row == 1){
		msg = URLEncoder.encode("회원탈퇴되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		session.invalidate();
		return;
	} else {
		msg = URLEncoder.encode("비밀번호를 확인해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/removeCustomer.jsp?msg="+msg);
	}
%>