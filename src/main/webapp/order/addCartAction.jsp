<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%
	// 장바구니 추가 액션 파일 -> productOne.jsp에서 넘어오는 값
	
	// 로그인 상태인 경우 / 로그인되지 않은 상태인 경우 분기 (DB/세션)
	// 로그인되지 않은 상태에서 장바구니 추가한 뒤 로그인 -> 세션의 데이터 DB로 이동

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값 유효성 확인	
	// productOne.jsp에서 productNo 값이 넘어오지 않으면 productOne.jsp로 다시 이동
	if (request.getParameter("productNo") == null) {
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp");
		// productList.jsp로 가야할 것 같은데 나중에 보고 수정
		return;
	}
	
	// 넘어온 productNo 값
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo + " <-- productNo(addCartAction)");
	
	// model
	CartDao cartDao = new CartDao();
	
	// 로그인 상태이면 cart 테이블에 상품 추가
	String msg = "";
	if (session.getAttribute("loginId") != null) {
		// 현재 로그인 id	
 		Customer customer = (Customer) session.getAttribute("loginId");
 		String id = customer.getId();
 		System.out.println(id + " <-- id(addCartAction)");
		// 상품명 중복 확인
		int check = cartDao.checkCartDuplicate(productNo);
		System.out.println(check + " <-- ckeck(addCartAction)");
		if (check == 0) {
			System.out.println("중복 상품 없음");
		} else { // 중복값 있을 경우 메시지와 함께 해당 상품 상세 페이지로 이동
			System.out.println("중복 상품 존재");
			msg = URLEncoder.encode("이미 장바구니에 담았습니다.", "UTF-8");
			response.sendRedirect(
			request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo + "&msg=" + msg);
			return;
		}
	
		Cart cart = new Cart();
		cart.setProductNo(productNo);
		cart.setId(id);
	
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
		// 세션 객체 생성
		
	}

	System.out.println("==============addCartAction.jsp==============");
%>