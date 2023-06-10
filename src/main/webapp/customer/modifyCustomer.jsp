<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	/*
	//세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	*/
	//요청값 변수에 저장
	String id = "user1";	
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
	<!-- 수정 폼 -->
	<form action="<%=request.getContextPath()%>/customer/modifyCustomerAction.jsp" method="post">
		<table class="table">
			<tr>
				<th>아이디</th>
				<td><%=customer.getId() %></td>
			</tr>
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
				<th>생일</th>
				<td>
					<input type="date" name="cstmBirth" value="<%=customer.getCstmBirth()%>"> 
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
				<%
					if(customer.getCstmGender().equals("M")){
				%>
						<input type="radio" name="cstmGender" style="width: 20px;" value="M" checked="checked">남
						<input type="radio" name="cstmGender" style="width: 20px;" value="F">여
				<%
					}else{
				%>
						<input type="radio" name="cstmGender" style="width: 20px;" value="M">남
						<input type="radio" name="cstmGender" style="width: 20px;" value="F" checked="checked">여
				<%
					}
				%>
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
</body>
</html>