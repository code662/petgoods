<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%
	// 장바구니 추가 액션 파일 -> productOne.jsp에서 넘어오는 값
	
	// 로그인 상태인 경우 / 로그인되지 않은 상태인 경우 분기 (DB/세션)
	// 로그인되지 않은 상태에서 장바구니 추가한 뒤 로그인 -> 세션의 데이터를 DB로 이동

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

 	// 입력값 유효성 확인	
	// productOne.jsp에서 productNo 값이 넘어오지 않으면 productList.jsp로 다시 이동
	if (request.getParameter("productNo") == null
	|| request.getParameter("cnt") == null) {
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	} 

	// 넘어온 productNo, cartCnt 값
	String msg = "";
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int cartCnt = Integer.parseInt(request.getParameter("cnt"));
	if (cartCnt == 0) {
		msg = URLEncoder.encode("1개 이상의 수량을 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo+ "&msg=" + msg);
		return;
	}
	
	System.out.println(productNo + " <-- productNo(addCartAction)");
	System.out.println(cartCnt + " <-- cartCnt(addCartAction)");
	
	// model
	CartDao cartDao = new CartDao();
	
	// 로그인 상태이면 cart 테이블에 상품 추가
	String id = "";
	if (session.getAttribute("loginId") != null) {
		// 현재 로그인 id	
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(addCartAction)");
		// 상품명 중복 확인
		int check = cartDao.checkCartDuplicate(productNo, id);
		System.out.println(check + " <-- check(addCartAction)");
		if (check == 0) {
			System.out.println("중복 상품 없음(addCartAction)");
		} else { // 중복값 있을 경우 메시지와 함께 해당 상품 상세 페이지로 이동
			System.out.println("중복 상품 존재(addCartAction)");
			msg = URLEncoder.encode("이미 장바구니에 담았습니다.", "UTF-8");
			response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo + "&msg=" + msg);
			return;
		}
	
		Cart cart = new Cart();
		cart.setProductNo(productNo);
		cart.setId(id);
		cart.setCartCnt(cartCnt);
	
		// 입력 메소드 실행
		int row = cartDao.addMyCart(cart);
		System.out.println(row + " <-- row(addCartAction)");
	
		if (row == 1) {
			System.out.println("장바구니 추가 성공(회원명:" + id + ")");
			msg = URLEncoder.encode("장바구니에 추가되었습니다.", "UTF-8");
		} else {
			System.out.println("장바구니 추가 실패(회원명:" + id + ")");
			msg = URLEncoder.encode("장바구니에 추가되지 않았습니다.", "UTF-8");
		}
	
		// 장바구니 추가 성공 여부 관계없이 해당 상품 상세 페이지로 이동
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo + "&msg=" + msg);
		return;
	
	} else { // 로그인 상태가 아니면 세션에 상품 추가
		ArrayList<Cart> sessionCart = new ArrayList<>();
		// 세션 장바구니에 추가할 상품 정보: productOne.jsp에서 넘어오는 값 -> cart vo 내 productNo, cartCnt
		// 세션에서 장바구니 데이터 가져오기
		if ((ArrayList<Cart>) session.getAttribute("sessionCart") != null) { // 세션 장바구니에 값이 있을 경우
			sessionCart = (ArrayList<Cart>) session.getAttribute("sessionCart");
			int check = 0;
			for (int i = 0; i < sessionCart.size(); i += 1) {
				if (sessionCart.get(i).getProductNo() == productNo) { // 중복 상품 저장 시 수량만 추가
					sessionCart.get(i).setCartCnt(sessionCart.get(i).getCartCnt() + cartCnt);
					check = 1;
					break;
				}
			}
			if (check == 0) {
				Cart cart = new Cart();
				cart.setProductNo(productNo);
				cart.setCartCnt(cartCnt);
				sessionCart.add(cart);
			}
			session.setAttribute("sessionCart", sessionCart);
		} else { // 세션 장바구니가 비어있는 경우 바로 값 저장
			Cart cart = new Cart(); // cart 객체 생성
			cart.setProductNo(productNo);
			cart.setCartCnt(cartCnt);
			sessionCart.add(cart); // sessionCart(ArrayList)에 cart 객체 값 저장 
			session.setAttribute("sessionCart", sessionCart); // "sessionCart"라는 세션에 cart 객체 값이 저장된 sessionCart(ArrayList) 정보 저장
		}	
	}
		
		msg = URLEncoder.encode("장바구니에 추가되었습니다.", "UTF-8");
		
		// 장바구니 추가 성공 메시지와 함께 상품 상세 페이지로 이동
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo + "&msg=" + msg);
		return;
%>