<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	// 메인에 inc 추가 (오른쪽 팝업) / 공통
	// 오른쪽 서브메뉴: address 상세 띄우기, 총합계금액 표시
	// 하단 결제하기 버튼 생성 (클릭 시 addOrder.jsp 이동) -> 링크로 처리
	
	System.out.println("==============cartList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cartList</title>
	</head>
	<body>
		<div>
			<h1>장바구니</h1>
		</div>
		<table border="1">
			<tr>
				<th>상품이름</th>
				<th>가격</th>
				<th>수량</th>
				<th>금액</th>
			</tr>
			<tr>
				<td>고급사료</td>
				<td>10000</td>
				<td>2</td>
				<td>20000</td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/order/addOrder.jsp">결제하기</a>
	</body>
</html>