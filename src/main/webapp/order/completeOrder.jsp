<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 결제가 완료(실패)되었다는 폼만 생성
	// 쇼핑계속하기 / 주문내역확인
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	System.out.println("==============completeOrder.jsp==============");	
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>completeOrder</title>
	</head>
	<body>
		<h1>결제 완료</h1>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/product/productList.jsp">쇼핑계속하기</a>
		<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp">주문내역확인</a>
	</body>
</html>