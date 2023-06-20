<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// 단일 상품 주문 처리 액션
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 세션 유효성 검사
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
	String id = "";
	if (session.getAttribute("loginId") != null) {
		Customer customer = (Customer) session.getAttribute("loginId");
		id = customer.getId();
		System.out.println(id + " <-- id(addOrderProductAction)");
	}
	
	// 요청값 유효성 검사
	// 상품번호, 주문수량, 가격 중 하나라도 null 값이 있으면
	if (request.getParameter("productNo") == null
	|| request.getParameter("cnt") == null
	|| request.getParameter("productPrice") == null) {
		System.out.println("addOrderProductAction 유효성 검사");
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 요청값 설정 및 디버깅
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int cnt = Integer.parseInt(request.getParameter("cnt"));
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	
	System.out.println(productNo + " <-- productNo(addOrderProductAction)");
	System.out.println(cnt + " <-- cnt(addOrderProductAction)");
	System.out.println(productPrice + " <-- productPrice(addOrderProductAction)");
	
	// model
	OrdersDao ordersDao = new OrdersDao();
	
	Orders order = new Orders();
	order.setProductNo(productNo);
	order.setId(id);
	order.setOrderCnt(cnt);
	order.setOrderPrice(productPrice);
	
	// 포인트 처리
	
	
	
	// 주문 처리
	int row = ordersDao.addOrders(order);
	System.out.println(row + " <-- row(addOrderProductAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("주문 처리 완료");
		msg = URLEncoder.encode("주문이 완료되었습니다.", "UTF-8"); 
	} else {
		System.out.println("주문 처리 실패");
		msg = URLEncoder.encode("주문에 실패했습니다.", "UTF-8"); 
	}
	
	// 주문 처리 성공 여부 관계없이 메시지와 함께 completeOrder.jsp로 이동
	response.sendRedirect(request.getContextPath() + "/order/completeOrder.jsp?msg=" + msg);
	
	System.out.println("==============addOrderProductAction.jsp==============");
	
	
%>