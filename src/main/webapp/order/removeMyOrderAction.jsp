<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// 주문 취소 액션 
	// order_status를 주문취소로 변경 -> 완료
	// 주문 시 사용된 포인트가 있으면 되돌리기 -> 완료
	// 주문 취소한 수량만큼 재고 추가 -> 완료
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 세션 유효성 검사
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
	String id = "";
	if (session.getAttribute("loginId") != null) {
		Customer customer = (Customer) session.getAttribute("loginId");
		id = customer.getId();
		System.out.println(id + " <-- id(removeMyOrder)");
	}
	
	// 요청값(order) 유효성 검사
	// orderNo, orderId, createdate 값 중 하나라도 null 또는 공백값이 있으면 내 주문 리스트로 이동 -> 지금은 user1의 주문 목록, 추후 유저별로 수정할 것
	if (request.getParameter("orderNo") == null
	|| request.getParameter("orderNo").equals("")
	|| request.getParameter("createdate") == null
	|| request.getParameter("createdate").equals("")) {
		response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String createdate = request.getParameter("createdate");
	
	// 디버깅
	System.out.println(orderNo + " <-- orderNo(removeMyOrderAction)");
	System.out.println(createdate + " <-- createdate(removeMyOrderAction)");
	
	// model
	OrdersDao ordersDao = new OrdersDao();
	CustomerDao customerDao = new CustomerDao();
	
	Orders order = new Orders();
	order.setOrderNo(orderNo);
	order.setOrderStatus("주문취소");
	order.setId(id);
	order.setCreatedate(createdate);
	
	// 주문 시 사용했던 포인트가 있으면 되돌리기
	// 주문 시 사용한 포인트 조회
	int minusPoint = customerDao.usedPoint(orderNo);
	System.out.println(minusPoint + " <-- minusPoint(removeMyOrderAction)");
		
	
	// 주문 상태 변경
	int row = ordersDao.modifyOrdersStatus(order);
	System.out.println(row + " <-- row(removeMyOrderAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("주문 취소 성공");
		int row2 = customerDao.revertPlusPoint(order);
		System.out.println(row2 + " <-- row2(removeMyOrderAction)");
		if (row2 == 1) {
			System.out.println("포인트 되돌리기 성공");
			// 주문 수량만큼 재고량 되돌리기
			int row3 = ordersDao.addProductStock(orderNo);
			System.out.println(row3 + " <-- row2(removeMyOrderAction)");
			if (row3 == 1) {
				System.out.println("재고량 되돌리기 성공");
			} else {
				System.out.println("재고량 되돌리기 실패");
			}
		} else {
			System.out.println("포인트 되돌리기 실패");
		}
		msg = URLEncoder.encode("주문 취소가 완료되었습니다.", "UTF-8"); 
	} else {
		System.out.println("주문 취소 실패");
		msg = URLEncoder.encode("주문 취소에 실패했습니다.", "UTF-8"); 
	}
	
	// 주문 취소 여부 관계없이 메시지와 함께 내 주문 목록으로 이동 
	response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp?msg=" + msg);

	System.out.println("==============removeMyOrderAction.jsp==============");
%>