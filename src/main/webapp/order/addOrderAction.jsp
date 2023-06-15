<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	// 여러 상품 주문 불가능 이슈:
	// 주문 여러 상품 받을 때 requestparameterValues() 로 받음
	// 주문넘버 = {"1", "2", "3", ...} 과 같은 형태
	// for (String s : order) {} ... 배열 생성
	// 배열 내부에 주문 메소드
	// 한 번에 여러 상품 주문이 가능하나 주문코드는 다르게 찍힘



		
	// 주문 액션 파일 -> cartList.jsp 주문 폼에서 넘어오는 값 (주문하기 버튼)
	// productNo, id, orderCnt, orderPrice 확인
	// 재고량보다 많게 주문했을 경우 오류 msg와 함께 cartList.jsp로 리다이렉트
	// 주문하기 버튼 클릭 시 orders에 값 들어감 -> '결제완료' 상태로 -> addOrders() 메소드
	
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");
	
	// 아이디 유효성 확인
/* 	String id = "";
	if (session.getAttribute("loginId") != null) { // 로그인 상태이면
		// 현재 로그인 아이디
		Customer customer = (Customer) session.getAttribute("loginId");
		id = customer.getId();
	}
	
	System.out.println(id + " <-- id(addOrderAction)");
	
	// 요청값 유효성 확인
	// 넘어온 productNo, orderCnt, orderPrice 중 하나라도 유효값이 아니면 CartList.jsp로 리다이렉트
	if (request.getParameter("productNo") == null
	|| request.getParameter("orderCnt") == null
	|| request.getParameter("orderPrice") == null) {
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
		return;
	} */
	
	String msg = "";
	String id = "user1";
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	
	// 디버깅
	System.out.println(productNo + " <-- productNo(addOrderAction)");
	System.out.println(orderCnt + " <-- orderCnt(addOrderAction)");
	System.out.println(orderPrice + " <-- orderPrice(addOrderAction)");
	
	// 모델
	OrdersDao ordersDao = new OrdersDao();
	
	Orders order = new Orders();
	order.setProductNo(productNo);
	order.setOrderCnt(orderCnt);
	
	int stock = ordersDao.selectProductStock(productNo); // 재고량 조회
	if (stock < orderCnt) { // 재고량보다 주문량이 많으면 msg와 함께 cartList.jsp로 리다이렉트 
		msg = URLEncoder.encode("재고량(" + stock + "개) 이하의 수량만 주문 가능합니다.", "UTF-8");
		response.sendRedirect(request.getContextPath());
		return;
	}
	
	int row = ordersDao.addOrders(order); // 주문 처리 // orderNo
	System.out.println(row + " <-- row(addOrderAction)");
	
	if (row == 1) { 
		System.out.println("주문(결제) 성공");
		response.sendRedirect(request.getContextPath() + "/order/completeOrder.jsp");
		return;
	} else {
		System.out.println("주문(결제) 실패");
		msg = URLEncoder.encode("주문이 처리되지 않았습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg" + msg);
		return;
	}
	
	
	
	
	
	// System.out.println("==============addOrderAction.jsp(상단 출력)==============");
%>