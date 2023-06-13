<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 로그인세션 테스트용
	Customer ctest = new Customer();
	ctest.setId("user7");
	ctest.setPw("1234");
	session.setAttribute("loginId", ctest);
	
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	// 디버깅
	System.out.println(PURPLE + id + " <--id myPage" + RESET);
	
	CustomerDao cd = new CustomerDao();
	Customer customer = cd.selectMyPage(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
<table>
	<tr>
		<td>ID</td>
		<td><%=customer.getId() %></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><%=customer.getCstmName() %></td>
	</tr>
	<tr>
		<td>등급</td>
		<td><%=customer.getCstmRank() %></td>
	</tr>
	<tr>
		<td>포인트</td>
		<td><%=customer.getCstmPoint() %></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="<%=request.getContextPath()%>/customer/modifyCustomer.jsp?cstmNo=<%=customer.getCstmNo()%>">
				내정보수정
			</a>
		</td>
		<!-- <td></td> -->
	</tr>
	<tr>
		<td colspan="2">
			<a href="<%=request.getContextPath()%>/customer/modifyPw.jsp">
				비밀번호 변경
			</a>
		</td>
		<!-- <td></td> -->
	</tr>
	<tr>
		<td colspan="2">
			<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp">
				내주문조회
			</a>
		</td>
		<!-- <td></td> -->
	</tr>
	<tr>
		<td colspan="2">
			<a href="<%=request.getContextPath()%>/customer/addressList.jsp">
				내배송지관리
			</a>
		</td>
		<!-- <td></td> -->
	</tr>
	<tr>
		<td colspan="2">
			<a href="<%=request.getContextPath()%>/customer/reviewList.jsp">
				내리뷰관리
			</a>
		</td>
		<!-- <td></td> -->
	</tr>
</table>
</body>
</html>