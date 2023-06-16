<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

 <%
 	// 장바구니 수정(상품 수량) 액션 파일 -> cartList.jsp에서 넘어오는 값 (수량 선택하고 update 버튼 눌렀을 때)
 	// 수량이 1개일 때만 변경 가능 이슈 -> getParameterValues()로 받을 것
 
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
	 	// cartList.jsp에서 넘어온 cartCnt[], cartNo[] 의 값이 null 이면 cartLlist.jsp로 이동
	 	if (request.getParameterValues("cartCnt") == null 
		|| request.getParameterValues("cartNo") == null) {
	 		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
	 		return;
	 	}
	 	
	 	// 넘어온 cartCnt, cartNo 배열
	 	String[] cartCnt = request.getParameterValues("cartCnt");
	 	String[] cartNo = request.getParameterValues("cartNo");
	 	
	 	// 배열 형변환을 위한 빈 배열 생성
	 	int[] intCartCnt = null;
	 	int[] intCartNo = null;
	 	
	 	// String 배열을 int 타입으로 형변환
	 	if (cartCnt != null) {
	 		intCartCnt = new int[cartCnt.length];
	 		for (int i = 0; i < intCartCnt.length; i++) {
	 			intCartCnt[i] = Integer.parseInt(cartCnt[i]);
	 		}
	 	}
	 	
	 	if (cartNo != null) {
	 		intCartNo = new int[cartNo.length];
	 		for (int i = 0; i < intCartNo.length; i++) {
	 			intCartNo[i] = Integer.parseInt(cartNo[i]);
	 		}
	 	}
	 	
	 	
	 	// 디버깅
	 	for (int i = 0; i < intCartCnt.length; i++) {
	 		if (intCartCnt[i] <= 0) {
	 			System.out.println("유효하지 않은 값");
	 			msg = URLEncoder.encode("1 이상의 수량을 입력하세요.", "UTF-8");
	 			response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
	 			return;
	 			
	 		}
	 		System.out.println(intCartCnt[i] + " <-- 입력된 수량(modifyCartAction)");
	 	}
	 	
	 	for (int i = 0; i < intCartNo.length; i++) {
	 		System.out.println(intCartNo[i] + " <-- 카트번호(modifyCartAction)");
	 	}
	 	
		ArrayList<Cart> cList = new ArrayList<>();
		for (int i = 0; i < intCartNo.length; i += 1) {
			Cart cart = new Cart(); // for문 밖에서 선언하면 마지막 값으로 중복되는 문제 등 발생
			cart.setId(id);
			cart.setCartNo(intCartNo[i]);
			cart.setCartCnt(intCartCnt[i]);
			cList.add(cart);
		}
		
		for (Cart c : cList) {
			System.out.println(c.getId());
			System.out.println(c.getCartCnt());
			System.out.println(c.getCartNo());
			
			int row = cartDao.modifyMyCart(c); // cart 아닌 c 사용
			System.out.println(row + " <-- row(modifyCartAction)");
			if (row == 1) {
				System.out.println("수량 변경 성공");
				msg = URLEncoder.encode("수량이 변경되었습니다.", "UTF-8");
				
			} else {
				System.out.println("수량 변경 실패");
				msg = URLEncoder.encode("수량이 변경되지 않았습니다.", "UTF-8");
			}
		}
	
		// 수량 변경 성공 여부 관계없이 장바구니 목록으로 이동
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
	
 	} else { // 로그인 상태가 아니면 -> 로그인 상태가 아닐 시 수량 변경 기능 사용하지 않음
	 	// 입력값 유효성 확인
	 	// cartList.jsp에서 넘어온 cartCnt[], cartNo[] 의 값이 null 이면 cartLlist.jsp로 이동
	 	if (request.getParameterValues("cartCnt") == null 
		|| request.getParameterValues("productNo") == null) {
	 		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
	 		return;
	 	}
	 	
	 	// 넘어온 cartCnt, cartNo 배열
	 	String[] cartCnt = request.getParameterValues("cartCnt");
	 	String[] productNo = request.getParameterValues("productNo");
	 	
	 	// 배열 형변환을 위한 빈 배열 생성
	 	int[] intCartCnt = null;
	 	int[] intProductNo = null;
	 	
	 	// String 배열을 int 타입으로 형변환
	 	if (cartCnt != null) {
	 		intCartCnt = new int[cartCnt.length];
	 		for (int i = 0; i < intCartCnt.length; i++) {
	 			intCartCnt[i] = Integer.parseInt(cartCnt[i]);
	 		}
	 	}
	 	
	 	if (productNo != null) {
	 		intProductNo = new int[productNo.length];
	 		for (int i = 0; i < intProductNo.length; i++) {
	 			intProductNo[i] = Integer.parseInt(productNo[i]);
	 		}
	 	}
	 	
	 	// 디버깅
	 	for (int i = 0; i < intCartCnt.length; i++) {
	 		System.out.println(intCartCnt[i] + " <-- 수량(modifyCartAction)");
	 	}
	 	
	 	for (int i = 0; i < intProductNo.length; i++) {
	 		System.out.println(intProductNo[i] + " <-- 카트번호(modifyCartAction)");
	 	}
	 	
 		
 		// 장바구니 수정(상품 수량) 액션 파일 -> cartList.jsp에서 넘어오는 값 (수량 선택하고 update 버튼 눌렀을 때)
 		// 세션에서 장바구니 데이터 가져오기
 		ArrayList<Cart> sessionCart = (ArrayList<Cart>) session.getAttribute("sessionCart");
 		
 		// 장바구니 데이터(상품 수량) 수정
 	/* 	for (Cart c : sessionCart) {
 			if (c.getProductNo() == productNo) {
 				c.setCartCnt(cartCnt);
 				break; 
 			}
 		} */
 	
 		for (int i = 0; i < sessionCart.size(); i += 1) {
 			Cart c = sessionCart.get(i);
 			if (c.getProductNo() == intProductNo[i]) {
 				c.setCartCnt(intCartCnt[i]);
 				break;
 			}
 		}
 	}

 	/*
 	// 변경 전 코드
		else { // 로그인 상태가 아니면 세션 상품 정보(수량) 변경?
 		// 입력값 유효성 확인
 	 	// cartList.jsp에서 넘어온 cartCnt, cartNo 값이 null 이면 cartList.jsp로 이동
 	 	if (request.getParameter("cartCnt") == null
 	 	|| request.getParameter("productNo") == null) {
 	 		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp");
 	 		return;
 	 	}
 	 		
 	 	// 넘어온 cartCnt, productNo 값
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
 	*/
 	
 	System.out.println("==============modifyCartAction.jsp==============");
 %>