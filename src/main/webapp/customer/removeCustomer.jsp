<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
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
	
	<!-- 회원탈퇴 폼 -->
	<form action="<%=request.getContextPath()%>/customer/removeCustomerAction.jsp" method="post">
		<table>
			<tr>
				<td>
					<div>회원탈퇴 하시겠습니까?</div>
					<div>탈퇴를 진행하시려면 비밀번호를 입력해주세요.</div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="pw">
				</td>
			</tr>
		</table>
		<button type="submit">탈퇴하기</button>
	</form>
</body>
</html>