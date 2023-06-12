<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// 주문 취소 액션 
	// order_status를 주문취소로 변경 -> 완료
	// 주문 시 사용된 포인트가 있으면 되돌리기 -> addOrder.jsp, addOrderAction.jsp 작성 후 기능 추가하기 
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 요청값(order) 유효성 검사
	// orderNo, orderId, createdate 값 중 하나라도 null 또는 공백값이 있으면 내 주문 리스트로 이동 -> 지금은 user1의 주문 목록, 추후 유저별로 수정할 것
	if (request.getParameter("orderNo") == null
	|| request.getParameter("orderNo").equals("")
	|| request.getParameter("orderId") == null
	|| request.getParameter("orderId").equals("")
	|| request.getParameter("createdate") == null
	|| request.getParameter("createdate").equals("")) {
		response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String orderId = request.getParameter("orderId");
	String createdate = request.getParameter("createdate");
	
	// 디버깅
	System.out.println(orderNo + " <-- orderNo(removeMyOrderAction)");
	System.out.println(orderId + " <-- orderId(removeMyOrderAction)");
	System.out.println(createdate + " <-- createdate(removeMyOrderAction)");
	
	// model
	OrdersDao ordersDao = new OrdersDao();
	
	Orders order = new Orders();
	order.setOrderNo(orderNo);
	order.setOrderStatus("주문취소");
	order.setId(orderId);
	order.setCreatedate(createdate);
	
	// 주문 상태 변경
	int row = ordersDao.modifyOrdersStatus(order);
	System.out.println(row + " <-- row(removeMyOrderAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("주문 상태 변경");
		msg = URLEncoder.encode("주문 취소가 완료되었습니다.", "UTF-8"); 
	} else {
		System.out.println("주문 상태 변경 실패");
		msg = URLEncoder.encode("주문 취소에 실패했습니다.", "UTF-8"); 
	}
	
	// 주문 취소 여부 관계없이 메시지와 함께 내 주문 목록으로 이동 -> 이것도 바꿔,,
	response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp?msg=" + msg);

	System.out.println("==============removeMyOrderAction.jsp==============");
%>

