<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	// 로그인 정보 없는 경우 (세션 정보) 테스트 코드
    ArrayList<Cart> cartList = new ArrayList<>();
    Cart cart = new Cart();
    cart.setProductNo(1); // 임의 상품번호
    cart.setCartCnt(10); // 임의 수량
    cartList.add(cart); // 세션에 추가
    
    // 쿼리문 이용
    CartDao cDao = new CartDao();
    session.setAttribute("cartList", cartList);
 
   	ArrayList<Cart> cList = (ArrayList<Cart>)session.getAttribute("cartList");
   
	// 상품 이름 조회
	String productName1 = cDao.selectProductName(cart.getProductNo());
	// 상품 가격 조회
	int productPrice1 = cDao.selectProductPrice(cart.getProductNo());
	// 상품 이미지 조회
	String productImg1 = cDao.selectImg(cart.getProductNo());
	
  	 for (Cart c : cList) {
  		 System.out.println(c.getProductNo() + " <-- 상품번호 테스트(cartList)");
      	 System.out.println(c.getCartCnt() + " <-- 수량 테스트(cartList)" );
      	 System.out.println(productName1 + " <-- 상품이름 테스트(cartList)");
      	 System.out.println(productPrice1 + " <-- 상품가격 테스트(cartList)");
      	 System.out.println(productImg1 + " <-- 상품이미지명 테스트(cartList)");
      	 System.out.println(productPrice1 * c.getCartCnt() + " <-- 총 금액 테스트(cartList)");
   	}

	// 장바구니 리스트 - 세션 있는 경우, 없는 경우 분기
	// 메인에 inc 추가 (오른쪽 팝업) / 공통
	// 오른쪽 서브메뉴: address 상세 띄우기, 총합계금액 표시
	// 하단 결제하기 버튼 생성 (클릭 시 addOrder.jsp 이동) -> 링크로 처리
	
	// 로그인 전: 세션-장바구니(아이템) -> 세션에 아이템 있을 경우 cart DB에 저장(로그인 후)
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
 	String msg = "";
	String id = "";
 	if (session.getAttribute("loginId") != null) {
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(cartList)");
 	}
	
	// model 
	CartDao cartDao = new CartDao();
	
	// ArrayList<Cart> list 생성 후 값 추가
	ArrayList<Cart> list = new ArrayList<>();
	list = cartDao.selectMyCart(id);
	
	// &cartCnt=$('input[name=cartCnt]').val();"
	System.out.println("==============cartList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cartList</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			// 로그인 상태일 때
			if (session.getAttribute("loginID") != null) {
				$(document).ready(function() {
					$(".modifyLink").click(function(e)) {
						 e.preventDefault();
						 
						 let cartNo = $(this).
					}
			}
				
			});
		</script>
	</head>
	<body>
		<div>
			<h1>장바구니</h1>
		</div>
		
		<%
			// 로그인 상태이면 cart 테이블에서 데이터 조회
			if (session.getAttribute("loginId") != null) {
				// Customer customer = (Customer) session.getAttribute("loginId");
				if (request.getParameter("msg") != null) {
		%>
					<%=request.getParameter("msg")%>
		<%
				}
		%>
				<form action="<%=request.getContextPath()%>/order/addOrder.jsp" method="post" id="cartList">
					<table border="1">
						<tr>
						   <!--  <th>번호</th> -->
							<th>이미지</th>
							<th>상품이름</th>
							<th>가격</th>
							<!-- <th>수량</th> -->
							<th>총 금액</th>
							<th>수량</th>
							<th>삭제</th>
						</tr>
			<%
					int totalPrice = 0;
					for (Cart c : list) {
					// 상품 이름 조회
					String productName = cartDao.selectProductName(c.getProductNo());
					// 상품 가격 조회
					int productPrice = cartDao.selectProductPrice(c.getProductNo());
					// 상품 이미지 조회
					String productImg = cartDao.selectImg(c.getProductNo());
					
					totalPrice += productPrice * c.getCartCnt();
					
					/* int cartCnt = 0;
					if (cartCnt >= 0) {
						cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
					} */
			
			%>
						<tr>
							<%-- <td><%=c.getCartNo()%></td> --%>
							
							<td>
								<input type="hidden" name="cartNo" value="<%=c.getCartNo()%>">
								<input type="hidden" name="productImg" value="<%=productImg%>">
								<img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100">
							</td>
							<td>
								<%=productName%>
							</td>
							<td>
								<input type="hidden" name="productPrice" value="<%=productPrice%>">
								<%=productPrice%>원
							</td>
						<%-- 	<td>
								<input type="hidden" name="orderCnt" value="<%=c.getCartCnt()%>">
								<%=c.getCartCnt()%>
							</td> --%>
							<td>
								<input type="hidden" name="productPrice" value="<%=productPrice * c.getCartCnt()%>">
								<%=productPrice * c.getCartCnt()%>원
							</td>
							<td>
								<input type="number" name="cartCnt" value="<%=c.getCartCnt()%>">
								<!-- ?cartNo=<%=c.getCartNo()%>&cartCnt=   -->
							</td>
							<td><a href="<%=request.getContextPath()%>/order/removeCartAction.jsp?cartNo=<%=c.getCartNo()%>">삭제버튼</a></td>
						</tr>
			<%
			 		// 위 <input> 태그 하드코딩 부분 템플릿 적용 시 수정할 것 
					}
			%>
					</table>
					<div>
						총 합계 금액: <%=totalPrice%>원
					</div>
					<button onclick="$('#cartList').submit()">주문하기</button>
					<button type="submit" formaction="<%=request.getContextPath()%>/order/modifyCartAction.jsp">수량 수정</button> <!-- formaction: <form> 태그 내 액션 파일명과 값과 관계없이 formaction 태그 내에   -->
				</form>
		
		<%
			} else { // 로그인 상태가 아니면 세션에서 데이터 조회
				if (request.getParameter("msg") != null) {
		%>
					<%=request.getParameter("msg")%>
		<% 			
				}
		%>
				<table border="1">
					<tr>
						<th>상품이름</th>
						<th>가격</th>
						<th>수량</th>
						<th>총 금액</th>
						<!-- <th>수량 변경</th> -->
						<th>삭제</th>
					</tr>
		<%
				// 세션에서 장바구니 데이터 가져오기
				ArrayList<Cart> sessionCart = (ArrayList<Cart>) session.getAttribute("sessionCart");
				if (sessionCart != null && !sessionCart.isEmpty()) { // 세션 장바구니에 값이 있으면
					for (Cart c : sessionCart) {
					// 상품 이름 조회
					String productName = cartDao.selectProductName(c.getProductNo());
					// 상품 가격 조회
					int productPrice = cartDao.selectProductPrice(c.getProductNo());
				 	// 상품 이미지 조회
					String productImg = cartDao.selectImg(c.getProductNo());
		%>	
					<tr>
						<td><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"><%=productName%></td>
						<td><%=productPrice%></td>
						<td><%=c.getCartCnt()%></td>
						<td><%=productPrice * c.getCartCnt()%></td>
						<%-- <td><input type="number" id="cartCnt" value=""><a href="<%=request.getContextPath()%>/order/modifyCartAction.jsp?productNo=<%=c.getProductNo()%>&cartCnt=4">수량 수정</a></td> --%>
						<td><a href="<%=request.getContextPath()%>/order/removeCartAction.jsp?productNo=<%=c.getProductNo()%>">삭제버튼</a></td>
					</tr>
		<%
					}
			 	} else { // 세션 장바구니에 값이 없으면 표시할 내용
		%>
					<tr>
						<td colspan="6">세션 장바구니가 비어있습니다.</td>
					</tr>
		<% 
			 	}
			}
		%>
		</table>
	</body>
</html>