<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// 장바구니 주문 처리 액션
	
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// 세션 유효성 검사
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
	String id = "";
	if (session.getAttribute("loginId") != null) {
		Customer customer = (Customer) session.getAttribute("loginId");
		id = customer.getId();
		System.out.println(id + " <-- id(addOrderCartAction)");
	}
		
	// 요청값 유효성 검사 
	// 카트번호, 상품번호, 주문수량, 가격 중 하나라도 null 값이 있으면 home.jsp로 리다이렉트
	
/* 	System.out.println(request.getParameterValues("cartNo"));
	System.out.println(request.getParameterValues("productNo"));
	System.out.println(request.getParameterValues("productPrice"));
	System.out.println(request.getParameterValues("cartCnt"));
	System.out.println("유효성 검사 확인(addOrderCartAction)");
	if (request.getParameterValues("cartNo") == null
	|| request.getParameterValues("productNo") == null
	|| request.getParameterValues("productPrice") == null
	|| request.getParameterValues("cartCnt") == null) {
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}  */
	
	// 요청값 설정 및 디버깅
	String[] cartNo = request.getParameterValues("cartNo");
	String[] productNo = request.getParameterValues("productNo");
	String[] productImg = request.getParameterValues("productImg");
	String[] productName = request.getParameterValues("productName");
	String[] productPrice = request.getParameterValues("productPrice");
	String[] cartCnt = request.getParameterValues("cartCnt");
	int point = 0; // 공백값 또는 null 입력될 경우 포인트는 0
	if (request.getParameter("point") != null && !request.getParameter("point").equals("")) { 
		point = Integer.parseInt(request.getParameter("point"));
	}
	
	for (int i = 0; i < cartNo.length; i += 1) {
		System.out.println(cartNo[i] + " <-- cartNo(addOrderCartAction)");
		System.out.println(productNo[i] + " <-- productNo(addOrderCartAction)");
		System.out.println(productImg[i] + " <-- productImg(addOrderCartAction)");
		System.out.println(productName[i] + " <-- productName(addOrderCartAction)");
		System.out.println(productPrice[i] + " <-- productPrice(addOrderCartAction)");
		System.out.println(cartCnt[i] + " <-- cartCnt(addOrderCartAction)");
	}
	
	// 세션에 요청값 저장 -> 주문완료 폼에서 해당 정보 출력
	session.setAttribute("productImg", productImg);		
	session.setAttribute("productName", productName);	
	session.setAttribute("productPrice", productPrice);
	session.setAttribute("cartCnt", cartCnt);
	session.setAttribute("point", point);	
	
	// model 
	OrdersDao ordersDao = new OrdersDao();
	CustomerDao customerDao = new CustomerDao();
	CartDao cartDao = new CartDao();
	
	ArrayList<Orders> oList = new ArrayList<>();
	Orders order = null;
	for (int i = 0; i < productNo.length; i += 1) {
		order = new Orders();
		order.setProductNo(Integer.parseInt(productNo[i]));
		order.setId(id);
		order.setOrderCnt(Integer.parseInt(cartCnt[i]));
		order.setOrderPrice(Integer.parseInt(productPrice[i]));
		
		oList.add(order);
	}
	
	String msg = "";
	/*
	// 포인트 처리 (유효값 입력 시 주문할 때 처리) -> addOrderCart에서 javascript로 처리
	// 0보다 작은 수 또는 보유 포인트보다 큰 수를 입력했을 경우 메시지와 함께 유효값을 입력하라는 메시지 리다이렉트 
	// 나의 포인트 조회
	int myPoint = customerDao.selectMyPoint(id);
	System.out.println(myPoint + " <-- myPoint(addOrderCartAction)");
	if (point > myPoint || point < 0) {
		msg = URLEncoder.encode("유효한 포인트(0 ~ " + myPoint + ") 를 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?&msg=" + msg);
		return;
	}
	*/
	
	// 재고량 비교 -> 재고량보다 많은 수량을 주문하면 메시지와 함께 해당 상품 상세 페이지로 리다이렉트
	for (int i = 0; i < productNo.length; i += 1) {
		int stock = ordersDao.selectProductStock(Integer.parseInt(productNo[i]));
		if (stock < Integer.parseInt(cartCnt[i])) {
			msg = URLEncoder.encode((i + 1) + "번째 상품의 재고량 초과: " + stock + "개 이하의 수량만 주문 가능합니다.", "UTF-8");
			response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
			return;
		}
	}
	
	// 주문 처리
	if (point == 0) { // 주문(포인트를 사용하지 않은 경우)
		int row = 0;
		for (Orders o : oList) {
			row += ordersDao.addOrders(o);
		}
		System.out.println(row + " <-- row(addOrderCartAction)");
		if (row >= 1) {
			msg = URLEncoder.encode("주문이 완료되었습니다.", "UTF-8"); 
			System.out.println("주문 처리 완료(" + row + ")");
			
		} else {
			msg = URLEncoder.encode("주문에 실패했습니다.", "UTF-8"); 
			System.out.println("주문 처리 실패");
		}
	} else { // 주문 (포인트를 사용한 경우)
		int count = 0;
		int row = 0;
		for (Orders o : oList) {
			if (count == 0) { // count가 0일 때 -> 장바구니 목록 첫 번째 상품에만 사용 포인트 적용
				row += ordersDao.addOrders(o, point);
				count += 1;
			} else {
				row += ordersDao.addOrders(o);	
			}
		}
		System.out.println(row + " <-- row(addOrderCartAction)");
		if (row >= 1) {
			msg = URLEncoder.encode("주문이 완료되었습니다.", "UTF-8"); 
			System.out.println("주문 처리 완료");
			
		} else {
			msg = URLEncoder.encode("주문에 실패했습니다.", "UTF-8"); 
			System.out.println("주문 처리 실패");
		}
	}
	
	// 주문 완료 시 카트에 해당 목록 비우기 
	int removeCart = 0;
	for (int i = 0; i < cartNo.length; i += 1) {
		// int removeCart = cartDao.removeMyCart(Integer.parseInt(cartNo[i]));
		removeCart += cartDao.removeMyCart(Integer.parseInt(cartNo[i]));
	}
	System.out.println(removeCart + " <-- removeCart(addOrderCartAction)");
	if (removeCart >= 1) {
		System.out.println("주문 완료건 카트에서 삭제 성공(" + removeCart + ")");
	} else {
		System.out.println("주문 완료건 카트에서 삭제 실패");
	}
	
	// 주문 처리 성공 여부 관계없이 메시지와 함께 completeOrder.jsp로 이동
	response.sendRedirect(request.getContextPath() + "/order/completeOrderCart.jsp?msg=" + msg);
	
	System.out.println("==============addOrderCartAction.jsp==============");
%>
