<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>

<%
	// 장바구니 삭제 액션 파일 -> cartList.jsp에서 넘어오는 값 (삭제버튼 눌렀을 때)
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 입력값 유효성 확인
	// cartList.jsp에서 cartNo 값이 넘어오지 않으면 carList.jsp로 다시 이동
	if (request.getParameter("cartNo") == null) {
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
		return;
	}
	
	// 넘어온 cartNo 값
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	System.out.println(cartNo + " <-- cartNo(removeCartAction)");
	
	// model
	CartDao cartDao = new CartDao();
	
	// 로그인 상태이면 cart 테이블에 있는 상품 삭제
	String msg = "";
	if (session.getAttribute("loginId") != null) {	
		// 현재 로그인 id	
 		Customer customer = (Customer) session.getAttribute("loginId");
 		String id = customer.getId();
 		System.out.println(id + " <-- id(removeCartAction)");

		int row = cartDao.removeMyCart(cartNo);
		System.out.println(row + " <-- removeCartAction");
		
		if (row == 1) {
			System.out.println("상품 삭제 성공");
			msg = URLEncoder.encode("상품을 삭제했습니다.", "UTF-8");
		} else {
			System.out.println("상품 삭제 실패");
			msg = URLEncoder.encode("상품을 삭제하지 못했습니다.", "UTF-8");
		}
		
		// 상품 삭제 여부 관계없이 cartList.jsp로 이동
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
		return;
		
		
	} else { // 로그인 상태가 아니면 세션에 저장된 상품 삭제
		
	}
	
	System.out.println("==============removeCartAction.jsp==============");
%>