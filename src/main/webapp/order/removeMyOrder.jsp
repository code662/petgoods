<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	// 주문취소 폼 -> 요청값 유효성 검사 링크 이슈
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값	(OrdersDao 내 상세 정보 메소드 요청값 -> order_no) 유효성 확인
	// order_no 값 없을 시 내 주문 목록으로 이동 -> 지금은 user1의 주문 목록, 추후 유저별로 수정할 것
	if (request.getParameter("orderNo") == null
	|| request.getParameter("orderNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp");
		return;
	}
	
	// 요청값 디버깅
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo + " <-- orderNo(removeMyOrder)");
	
	// OrdersDao 클래스 객체 생성 -> 메소드 내 쿼리 이용
	OrdersDao ordersDao = new OrdersDao();
	Orders order = new Orders();
	order = ordersDao.selectOrderOne(orderNo); // 해당 주문번호를 가진 상품 상세 정보 조회
	
	// 주문코드 조회
	String orderCode = ordersDao.selectOrdersCode(orderNo);
	
	// 상품이름 조회
	String productName = ordersDao.selectProductName(order.getProductNo());

	System.out.println("==============removeMyOrder.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeMyOrder</title>
	</head>
	<body>
		<div>
			<h1>주문취소</h1>
		</div>
		주문취소 하시겠습니까?
		<form action="<%=request.getContextPath()%>/order/removeMyOrderAction.jsp" method="post">
			<input type="hidden" name="orderNo" value="<%=order.getOrderNo()%>">
			<input type="hidden" name="orderId" value="<%=order.getId()%>">
			<input type="hidden" name="createdate" value="<%=order.getCreatedate()%>">
			<table border="1">
				<tr>
					<th>주문코드</th>
					<td><%=orderCode%></td>
				</tr>
				<tr>
					<th>상품이름</th>
					<td><%=productName%></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><%=order.getOrderPrice()%></td>
				</tr>
				<tr>
					<th>수량</th>
					<td><%=order.getOrderCnt()%></td>
				</tr>
				<tr>
					<th>주문일자</th>
					<td><%=order.getCreatedate()%></td>
				</tr>
			</table>
			<button type="submit">주문취소</button>
		</form>
	</body>
</html>