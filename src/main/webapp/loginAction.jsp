<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.net.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	//입력값 불러오기
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	//디버깅
	System.out.println(id + "<-- 넘어온 id");
	System.out.println(pw + "<-- 넘어온 pw");
	
	//유효성 검사
	String msg = "";
	if(id == null || id.equals("")){ // 아이디가 입력되지 않았을 경우
		msg = URLEncoder.encode("아이디가 입력되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}
	
	if(pw == null || pw.equals("")){ // 비밀번호가 입력되지 않았을 경우
		msg = URLEncoder.encode("비밀번호가 입력되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}
	
	// model
	LoginDao loginDao = new LoginDao();
	CartDao cartDao = new CartDao();
	CustomerDao customerDao = new CustomerDao();
	
	// map 에 id pw 값 저장
	HashMap<String, Object> map = loginDao.selectLogin(id, pw);
	
	Customer c = null;
	Employees e = null;
	
	// 아이디 비번 체크
	if(map != null){
		if(map.get("login") instanceof Customer) {
			// 아이디가 customer 면 c 에 저장
			c = (Customer)map.get("login");
			session.setAttribute("loginId", c); 
			customerDao.modifyLastLogin(id);
			// 세션에 장바구니에 저장된 값 있으면 addCartAction 처리 -> 추후 테스트
			// 세션에서 장바구니 데이터 가져오기
			ArrayList<Cart> sessionCart = (ArrayList<Cart>) session.getAttribute("sessionCart");
			if (sessionCart != null && !sessionCart.isEmpty()) { // 세션 장바구니에 값이 있으면
				Cart newCart = null;
				// DB에 세션 장바구니 데이터 추가
				for (Cart cart : sessionCart) {
					newCart = new Cart();
					newCart.setProductNo(cart.getProductNo());
					newCart.setId(id);
					
					// 입력 메소드 실행
					int row = cartDao.addMyCart(newCart); 
					System.out.println(row + "row(loginAction)"); // row가 1이면 추가 성공, 아니면 실패
				}
			}
			
			// DB에 데이터 추가 후 세션 장바구니 데이터 삭제
			 session.removeAttribute("sessionCart");
		} else if(map.get("login") instanceof Employees) {
			// 아이디가 employee 면 e 에 저장
			e = (Employees)map.get("login");
			session.setAttribute("loginId", e);
		}
		
		//로그인 성공 시
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		
	}else{
		System.out.println("로그인 실패");
		// 아이디와 비번이 존재하지않을 때 실행되는 메세지
		msg = URLEncoder.encode("로그인 정보를 다시 확인해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}
%>   