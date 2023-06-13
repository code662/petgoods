<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<% 
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId();
	// 디버깅
	System.out.println(PURPLE + id + " <--id modifyPw" + RESET);
	
	CustomerDao cd = new CustomerDao();
	Customer customer = cd.selectMyPage(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<body>
	<h1>비밀번호 변경</h1>
		
	<!-- 리다이렉션 메시지 -->
	<div>
	<%
		if(request.getParameter("msg") != null){
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
	</div>
	
	<!-- 비밀번호 변경 폼 : 현재 비밀번호 확인 및 변경 비밀번호 입력 -->
	<form action="<%=request.getContextPath()%>/customer/modifyPwAction.jsp" method="post">
		<table>
			<tr>
				<th>현재 비밀번호</th>
				<td>
					<input type="password" name="currentPw">
				</td>
			</tr>
			<tr>
				<th>변경 비밀번호</th>
				<td>
					<input type="password" name="changePw">
				</td>
			</tr>
			<tr>
				<th>변경 비밀번호 확인</th>
				<td>
					<input type="password" name="confirmPw">
				</td>
			</tr>
		</table>
		<button type="submit">변경하기</button>
	</form>
	<a href="<%=request.getContextPath()%>/customer/myPage.jsp">
		<button>취소</button>
	</a>
</body>
</html>