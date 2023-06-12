<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Ansi코드 // 콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 요청값 유효성 검사
	if(request.getParameter("cstmNo") == null 
			|| request.getParameter("cstmNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myPage.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId();	
	// 디버깅
	System.out.println(PURPLE + id + " <--id modifyCustomer" + RESET);
	
	CustomerDao cd = new CustomerDao();
	Customer customer = cd.selectMyPage(id);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
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
	
	<!-- 수정 폼 -->
	<form action="<%=request.getContextPath()%>/customer/modifyCustomerAction.jsp?cstmNo=<%=customer.getCstmNo() %>" method="post">
		<table class="table">
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" value="<%=customer.getId() %>" style="border:none" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="currentPw" required="required">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="cstmName" value="<%=customer.getCstmName()%>"> 
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="cstmAdd" value="<%=customer.getCstmAdd()%>"> 
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="cstmEmail" value="<%=customer.getCstmEmail()%>"> 
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">수정</button>
				</td>
				<!-- <td></td> -->
			</tr>
		</table>
	</form>
	<a href="<%=request.getContextPath()%>/customer/myPage.jsp?cstmNo=<%=customer.getCstmNo()%>">
		<button>취소</button>
	</a>
</body>
</html>