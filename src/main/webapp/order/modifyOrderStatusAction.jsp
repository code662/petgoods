<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

<%
	// 관리자 변경 주문상태 액션파일 
	// 관리자가 변경할 수 있는 주문상태: 결제완료 -> 배송완료 (이 외에는 디폴트값 또는 고객이 직접 변경) 
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
		
	// 요청값 유효성 검사
	// orderNo, createdate 값 중 하나라도 null 이면 orderList.jsp로 이동
	if (request.getParameter("orderNo") == null
	|| request.getParameter("createdate") == null) {
		response.sendRedirect(request.getContextPath() + "/order/orderList.jsp");
		return;
	}
	
	// 요청값
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String createdate = request.getParameter("createdate");
	
	// 디버깅
	System.out.println(orderNo + " <-- orderNo(modifyOrderStatusAction)");
	System.out.println(createdate + " <-- createdate(modifyOrderStatusAction)");

	// model
	// 주문상태 변경을 위한 OrdersDao -> modifyOrdersStatus(Orders order)
	OrdersDao ordersDao = new OrdersDao();
	
	String id = ordersDao.selectCstmId(orderNo);
	System.out.println(id + " <-- id(modifyOrderStatusAction)");
	
	Orders order = new Orders();
	order.setId(id);
	order.setOrderNo(orderNo);
	order.setOrderStatus("배송완료");
	order.setCreatedate(createdate);
	
	int row = ordersDao.modifyOrdersStatus(order);
	System.out.println(row + " <-- row(modifyOrderStatusAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("주문상태 변경 성공");
		msg = URLEncoder.encode("주문상태를 변경했습니다.", "UTF-8");
	} else {
		System.out.println("주문상태 변경 실패");
		msg = URLEncoder.encode("주문상태를 변경에 실패했습니다.", "UTF-8");
	}
	
	// 주문상태 변경 성공 여부 관계없이 메시지와 함께 orderList.jsp로 이동
	response.sendRedirect(request.getContextPath() + "/order/orderList.jsp?msg=" + msg);
%>