<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

<%
	// 구매확정 액션 파일
	// myOrderList.jsp 에서 구매확정 버튼 눌렀을 때 이동 (orderNo / orderStatus / createdate 값 넘어옴)
	
	// 배송완료 -> 구매확정으로 변경하는 기능
	// 포인트 적립 기능 -> 구매금액의 등급(브, 실, 골)에 따라 1 / 5 / 10 퍼센트
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// id 확인
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
	String msg = "";
	String id = "";
	if (session.getAttribute("loginId") != null) {
		Customer customer = (Customer) session.getAttribute("loginId");
		id = customer.getId();
		System.out.println(id + " <-- id(purchaseAction)");
	}
	
	// 요청값 유효성 검사
	// orderNo, orderStatus, createdate, orderPrice, orderCnt 값 중 하나라도 null이면 myOrderList.jsp로 이동
	if (request.getParameter("orderNo") == null
	|| request.getParameter("orderStatus") == null
	|| request.getParameter("createdate") == null
	|| request.getParameter("orderPrice") == null
	|| request.getParameter("orderCnt") == null) {
		response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp");
		return;
	}
	
	// 요청값
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// String orderStatus = request.getParameter("orderStatus");
	String createdate = request.getParameter("createdate");
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt"));
	
	// 디버깅
	System.out.println(orderNo + " <-- orderNo(purchaseAction)");
	// System.out.println(orderStatus + " <-- orderStatus(purchaseAction)");
	System.out.println(createdate + " <-- createdate(purchaseAction)");
	System.out.println(orderPrice + " <-- orderPrice(purchaseAction)");
	System.out.println(orderCnt + " <-- orderCnt(purchaseAction)");
	
	// model
	// 주문 상태 변경을 위한 OrdersDao -> modifyOrdersStatus(Orders order)
	OrdersDao ordersDao = new OrdersDao();
	
	// 포인트 적립을 위한 CustomerDao -> addPluePoint(Orders order)
	CustomerDao customerDao = new CustomerDao();
	
	Orders order = new Orders();
	order.setId(id);
	order.setOrderNo(orderNo);
	order.setOrderStatus("구매확정");
	order.setCreatedate(createdate);
	order.setOrderPrice(orderPrice);
	order.setOrderCnt(orderCnt);
	
	int row = ordersDao.modifyOrdersStatus(order);
	System.out.println(row + " <-- row(purchaseAction)");
	
	if (row == 1) {
		System.out.println("구매확정 성공");
		msg = URLEncoder.encode("구매확정 및 포인트 적립이 완료되었습니다.", "UTF-8");
		
		int row2 = customerDao.addPlusPoint(order);
		System.out.println(row2 + " <-- row2(purchaseAction)");
		
		if (row2 == 1) {
			System.out.println("포인트 적립 성공");
		} else {
			System.out.println("포인트 적립 실패");
		}
	} else {
		System.out.println("구매확정 실패");
		msg = URLEncoder.encode("구매확정에 실패했습니다.", "UTF-8");
	}
	
	// 구매확정 성공 여부 관계없이 메시지와 함께 myOrderList.jsp 로 이동
	response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp?msg=" + msg);
%>