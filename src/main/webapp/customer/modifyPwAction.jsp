<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";	

	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	// 요청값 유효성 검사
	String msg = null;
	if(request.getParameter("currentPw") == null
			|| request.getParameter("changePw") == null
			|| request.getParameter("confirmPw") == null
			|| request.getParameter("currentPw").equals("")
			|| request.getParameter("changePw").equals("")
			|| request.getParameter("confirmPw").equals("")){
		msg = URLEncoder.encode("현재 비밀번호 또는 변경할 비밀번호를 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/modifyPw.jsp?msg="+msg);
		return;
	}
	
	// 요청값 변수에 저장
	String currentPw = request.getParameter("currentPw");
	String changePw = request.getParameter("changePw");
	String confirmPw = request.getParameter("confirmPw");
	// 디버깅
	System.out.println(PURPLE + currentPw + " <--currentPw modifyPwAction" + RESET);
	System.out.println(PURPLE + changePw + " <--changePw modifyPwAction" + RESET);
	System.out.println(PURPLE + confirmPw + " <--confirmPw modifyPwAction" + RESET);
	
	// 변경비밀번호와 확인비밀번호가 일치하지 않으면 비밀번호수정폼으로 리다이렉션
	if(!changePw.equals(confirmPw)){
		msg = URLEncoder.encode("변경 비밀번호를 다시 확인해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/modifyPw.jsp?msg="+msg);
		return;
	}
	
	// 로그인 세션 정보 객체에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	
	Id id = new Id();
	id.setId(c.getId());
	id.setLastPw(changePw);

	
	IdDao idDao = new IdDao();
	int row = idDao.modifyLastPw(id);
	System.out.println(PURPLE + row + " <--row modifyPwAction" + RESET);
	
	if(row == 1){ // 변경 성공한 경우
		msg = URLEncoder.encode("비밀번호가 변경되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/modifyPw.jsp?msg="+msg);
	} else { // 변경 실패한 경우
		msg = URLEncoder.encode("비밀번호 변경에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/modifyPw.jsp?msg="+msg);
	}
%>