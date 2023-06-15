<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

 <%
 	// 장바구니 수정(상품 수량) 액션 파일 -> cartList.jsp에서 넘어오는 값 (수량 선택하고 update 버튼 눌렀을 때)
 
 	// post 방식 인코딩 설정
 	request.setCharacterEncoding("UTF-8");

 	// model
 	CartDao cartDao = new CartDao();
 	
 	// 로그인 상태이면 cart 테이블에 있는 상품 수량 변경
 	String msg = "";
 	if (session.getAttribute("loginId") != null) {
 		// 현재 로그인 id	
 		Customer customer = (Customer) session.getAttribute("loginId");
 		String id = customer.getId();
 		System.out.println(id + " <-- id(modifyCartAction)");
 		
 	 	// 입력값 유효성 확인
 	 	// cartList.jsp에서 넘어온 cartCnt, cartNo 값이 null 이면 cartList.jsp로 이동
 	 	if (request.getParameter("cartCnt") == null
 	 	|| request.getParameter("cartNo") == null) {
 	 		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
 	 		return;
 	 	}
 	 		
 	 	// 넘어온 cartCnt, cartNo 값
 	 	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
 	 	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
 	 	
 		System.out.println(cartCnt + " <-- cartCnt(modifyCartAction)");
 	 	System.out.println(cartNo + " <-- cartNo(modifyCartAction)");
 	 
 		Cart cart = new Cart();
 		cart.setCartCnt(cartCnt);
 		cart.setId(id);
 		cart.setCartNo(cartNo);
 		
 		// 수정 메소드 실행
 		int row = cartDao.modifyMyCart(cart);
 		System.out.println(row + " <-- row(modifyCartAction)");
 		
 		if (row == 1) {
 			System.out.println("상품 수량 변경 성공(회원명:" + id + ")");
 			msg = URLEncoder.encode("수량이 변경되었습니다.", "UTF-8");
 		} else {
 			System.out.println("상품 수량 변경 실패(회원명:" + id + ")");
 			msg = URLEncoder.encode("수량이 변경되지 않았습니다.", "UTF-8");
 		}
 		
 		// 수량 변경 성공 여부 관계없이 장바구니 목록으로 이동
 		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
 		
 		
 	} else { // 로그인 상태가 아니면 세션 상품 정보(수량) 변경
 		// 입력값 유효성 확인
 	 	// cartList.jsp에서 넘어온 cartCnt, cartNo 값이 null 이면 cartList.jsp로 이동
 	 	if (request.getParameter("cartCnt") == null
 	 	|| request.getParameter("productNo") == null) {
 	 		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
 	 		return;
 	 	}
 	 		
 	 	// 넘어온 cartCnt, cartNo 값
 	 	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
 	 	int productNo = Integer.parseInt(request.getParameter("productNo"));
 	 	
 	 	System.out.println(cartCnt + " <-- cartCnt(modifyCartAction)");
 	 	System.out.println(productNo + " <-- cartNo(modifyCartAction)");
 		
 		// 장바구니 수정(상품 수량) 액션 파일 -> cartList.jsp에서 넘어오는 값 (수량 선택하고 update 버튼 눌렀을 때)
 		// 세션에서 장바구니 데이터 가져오기
 		ArrayList<Cart> sessionCart = (ArrayList<Cart>) session.getAttribute("sessionCart");
 		
 		// 장바구니 데이터(상품 수량) 수정
 		for (Cart c : sessionCart) {
 			if (c.getProductNo() == productNo) {
 				c.setCartCnt(cartCnt);
 				break; 
 			}
 		}
 	}
 	
 	System.out.println("==============modifyCartAction.jsp==============");
 %>