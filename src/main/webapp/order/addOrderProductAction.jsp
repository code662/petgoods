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
	// 상품번호, 주문수량, 가격 중 하나라도 null 값이 있으면 home.jsp로 리다이렉트
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
	int point = 0;
	if (request.getParameter("point") != null && !request.getParameter("point").equals("")) {
		point = Integer.parseInt(request.getParameter("point"));
	}
	
	System.out.println(productNo + " <-- productNo(addOrderProductAction)");
	System.out.println(cnt + " <-- cnt(addOrderProductAction)");
	System.out.println(productPrice + " <-- productPrice(addOrderProductAction)");
	System.out.println(point + " <-- point(addOrderProductAction)");
	
	// model
	OrdersDao ordersDao = new OrdersDao();
	CustomerDao customerDao = new CustomerDao();
	
	Orders order = new Orders();
	order.setProductNo(productNo);
	order.setId(id);
	order.setOrderCnt(cnt);
	order.setOrderPrice(productPrice);
	
	String msg = "";
	// 포인트 처리 (유효값 입력 시 주문할 때 처리)
	// 0보다 작은 수 또는 보유 포인트보다 큰 수를 입력했을 경우 메시지와 함께 유효값을 입력하라는 메시지 리다이렉트 
	// 나의 포인트 조회
	int myPoint = customerDao.selectMyPoint(id);
	System.out.println(myPoint + " <-- myPoint(addOrderProductAction)");
	if (point > myPoint || point < 0) {
		msg = URLEncoder.encode("유효한 포인트(0 ~ " + myPoint + ") 를 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/order/addOrderProduct.jsp?productPrice=" + productPrice + "&cnt=" + cnt + "&productNo=" + productNo + "&msg=" + msg);
		return;
	}
	
	// 재고량 비교 -> 재고량보다 많은 수량을 주문하면 메시지와 함께 해당 상품 상세 페이지로 리다이렉트 
	int stock = ordersDao.selectProductStock(productNo); // 재고량 조회
	System.out.println(stock + " <-- stock(addOrderProductAction)");
	if (stock < cnt) { // 재고량보다 주문량이 많으면 productOne.jsp로 리다이렉트
		msg = URLEncoder.encode("재고량(" + stock + "개) 이하의 수량만 주문 가능합니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo + "&msg=" + msg);
		return;
	}
	
	// 주문 처리
	if (point == 0) { // 주문(포인트를 사용하지 않은 경우) 
		int row = ordersDao.addOrders(order);
		System.out.println(row + " <-- row(addOrderProductAction)");
		
		if (row == 1) {
			System.out.println("주문 처리 완료");
			msg = URLEncoder.encode("주문이 완료되었습니다.", "UTF-8"); 
			
		} else {
			System.out.println("주문 처리 실패");
			msg = URLEncoder.encode("주문에 실패했습니다.", "UTF-8"); 
		}
	} else { // 주문(포인트를 사용한 경우)
		int row = ordersDao.addOrders(order, point);
		System.out.println(row + " <-- row(addOrderProductAction)");
		
		if (row == 1) {
			System.out.println("주문 처리 완료");
			msg = URLEncoder.encode("주문이 완료되었습니다.", "UTF-8"); 
		} else {
			System.out.println("주문 처리 실패");
			msg = URLEncoder.encode("주문에 실패했습니다.", "UTF-8"); 
		}
	}
	
	// 주문 처리 성공 여부 관계없이 메시지와 함께 completeOrder.jsp로 이동
	response.sendRedirect(request.getContextPath() + "/order/completeOrder.jsp?msg=" + msg);
	
	System.out.println("==============addOrderProductAction.jsp==============");
%>