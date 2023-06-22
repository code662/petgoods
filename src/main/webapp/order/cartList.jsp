<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	// 로그인 정보 없는 경우 (세션 정보) 테스트 코드
/*     ArrayList<Cart> cartList = new ArrayList<>();
    Cart cart = new Cart();
    cart.setProductNo(1); // 임의 상품번호
    cart.setCartCnt(10); // 임의 수량
    cartList.add(cart); // 세션에 추가
     */
    // 쿼리문 이용
    // CartDao cDao = new CartDao();
    // session.setAttribute("cartList", cartList);
 
   	
   
	/* // 상품 이름 조회
	String productName1 = cDao.selectProductName(cart.getProductNo());
	// 상품 가격 조회
	int productPrice1 = cDao.selectProductPrice(cart.getProductNo());
	// 상품 이미지 조회
	String productImg1 = cDao.selectImg(cart.getProductNo());
	 */
	 
  	/*  for (Cart c : cList) {
  		 System.out.println(c.getProductNo() + " <-- 상품번호 테스트(cartList)");
      	 System.out.println(c.getCartCnt() + " <-- 수량 테스트(cartList)" );
      	 System.out.println(productName1 + " <-- 상품이름 테스트(cartList)");
      	 System.out.println(productPrice1 + " <-- 상품가격 테스트(cartList)");
      	 System.out.println(productImg1 + " <-- 상품이미지명 테스트(cartList)");
      	 System.out.println(productPrice1 * c.getCartCnt() + " <-- 총 금액 테스트(cartList)");
   	} */

	// 장바구니 리스트 - 세션 있는 경우, 없는 경우 분기
	// 메인에 inc 추가 (오른쪽 팝업) / 공통
	// 오른쪽 서브메뉴: address 상세 띄우기, 총합계금액 표시
	// 하단 결제하기 버튼 생성 (클릭 시 addOrder.jsp 이동) -> 링크로 처리
	
	// 로그인 전: 세션-장바구니(아이템) -> 세션에 아이템 있을 경우 cart DB에 저장(로그인 후)
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	ArrayList<Cart> list = null;
	
	// model 
	CartDao cartDao = new CartDao();
	
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
 	String msg = "";
	String id = "";
 	if (session.getAttribute("loginId") != null) {
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(cartList)");
 		list = cartDao.selectMyCart(id);
 	} else { // 비로그인 상태
 		if ((ArrayList<Cart>) session.getAttribute("sessionCart") == null) {
 			list = new ArrayList<>();
 		} else {
 			list = (ArrayList<Cart>) session.getAttribute("sessionCart");
 		}
 		
 	}
 	
	System.out.println("==============cartList.jsp==============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cartList</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				const urlParams  = new URL(location.href).searchParams;
				const msg = urlParams.get('msg');
				if(msg != null){
					alert(msg);
				}
			});
		</script>
	</head>
	<body>
		<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>

		<!-- breadcrumb -->
		<div class="container">
			<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
				<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<span class="stext-109 cl4">
					cartList
				</span>
			</div>
		</div>
		
		<%
			// 로그인 상태이면 cart 테이블에서 데이터 조회
			if (session.getAttribute("loginId") != null) {
				// Customer customer = (Customer) session.getAttribute("loginId");
				// if (request.getParameter("msg") != null) {
		%>
				<%-- 	<%=request.getParameter("msg")%> --%>
		<%
			//	}
		%>
				<form action="<%=request.getContextPath()%>/order/addOrderCart.jsp" method="post" id="cartList" class="bg0 p-t-75 p-b-85">
					<div class="container">
						<div class="row">
							<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
								<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
									<div class="flex-w flex-sb-m p-b-17">
										<h4 class="mtext-111 cl2  p-r-20">
											장바구니
										</h4>	
										<br>
									</div>	
					<table class="table-shopping-cart">
						<tr class="table_head">
						   <!--  <th>번호</th> -->
							<th class="column-3">상품이미지</th>
							<th class="column-1">상품이름</th>
							<th class="column-1">가격</th>
							<!-- <th>수량</th> -->
							<th class="column-1">총 금액</th>
							<th class="column-1">수량</th>
							<th class="column-1">선택</th>
							<th class="column-1"></th>
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
			%>
						<tr class="table_head">
							<%-- <td><%=c.getCartNo()%></td> --%>
							<td class="column-3">
								<input type="hidden" id="productNo" name="productNo" value="<%=c.getProductNo()%>">
								<input type="hidden" id="cartNo" name="cartNo" value="<%=c.getCartNo()%>">
								<input type="hidden" id="productImg" name="productImg" value="<%=productImg%>">
								<img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100">
							</td>
							<td class="column-1">
								<input type="hidden" id="productName" name="productName" value="<%=productName%>">
								<%=productName%>
							</td>
							<td class="column-1">
								<input type="hidden" id="productPrice" name="productPrice" value="<%=productPrice%>">
								<%=productPrice%>원
							</td>
						<%-- 	<td>
								<input type="hidden" name="orderCnt" value="<%=c.getCartCnt()%>">
								<%=c.getCartCnt()%>
							</td> --%>
							<td class="column-1">
								<input type="hidden" id="totalPrice" name="totalPrice" value="<%=productPrice * c.getCartCnt()%>">
								<%=productPrice * c.getCartCnt()%>원
							</td>
							<td class="column-3">
								<div class="wrap-num-product flex-w m-l-auto m-r-0">
									<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
										<i class="fs-16 zmdi zmdi-minus"></i>
									</div>
									<input class="mtext-104 cl3 txt-center num-product" type="number" name="cartCnt" value="<%=c.getCartCnt()%>">
									<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
										<i class="fs-16 zmdi zmdi-plus"></i>
									</div>
								</div>
							
							<%-- 	<input type="number" id="cartCnt" name="cartCnt" value="<%=c.getCartCnt()%>"> --%>
								<!-- ?cartNo=<%=c.getCartNo()%>&cartCnt=   -->
							</td> 	
							<td class="column-1">
								<input type="checkbox" class="selCart" name="selCart" value="<%=c.getCartNo()%>">
							</td>
							<td class="column-1">
								<a href="<%=request.getContextPath()%>/order/removeCartAction.jsp?cartNo=<%=c.getCartNo()%>" style="color: #747474; width:100px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
									삭제
								</a>
							</td>
						</tr>
			<%
					}
			%>
					</table>
					<br>
					<div>
						총 합계 금액: <%=totalPrice%>원
					</div>
					<br>
					
					<div class="flex-w dis-inline-block">
						<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							<button onclick="$('#cartList').submit()" style="color: #333333">
								주문하기
							</button>
						</div>
						&nbsp;
						<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							<button  type="submit" formaction="<%=request.getContextPath()%>/order/modifyCartAction.jsp" style="color: #333333">
								수량 변경
							</button>
						</div>
					</div>
				
						
				
					<%-- <button type="submit" formaction="<%=request.getContextPath()%>/order/modifyCartAction.jsp">수량 수정</button> --%> <!-- formaction: <form> 태그 내 액션 파일명과 값과 관계없이 formaction 태그 내 링크로 이동-->
								</div>
							</div>
						</div>
					</div>
				</form>
		
		<%
			} else { // 로그인 상태가 아니면 세션에서 데이터 조회
		%>
				<form class="bg0 p-t-75 p-b-85">
					<div class="container">
						<div class="row">
							<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
								<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
									<div class="flex-w flex-sb-m p-b-17">
										<h4 class="mtext-111 cl2  p-r-20">
											장바구니
										</h4>	
										<br>
									</div>		
						<table class="table-shopping-cart">
							<tr class="table_head">
								<th class="column-3">상품이미지</th>
								<th class="column-1">상품이름</th>
								<th class="column-1">가격</th>
								<th class="column-1">총 금액</th>
								<th class="column-1">수량</th>
								<th class="column-1"></th>
							</tr>
		
			<%
				for (Cart c : list) {
					// 상품 이름 조회
					String productName = cartDao.selectProductName(c.getProductNo());
					// 상품 가격 조회
					int productPrice = cartDao.selectProductPrice(c.getProductNo());
					// 상품 이미지 조회
					String productImg = cartDao.selectImg(c.getProductNo());	
			%>
					
					<tr class="table_head">
						<td class="column-3"><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
						<td class="column-1"><%=productName%></td>
						<td class="column-1"><%=productPrice%></td>
						<td class="column-1"><%=c.getCartCnt()%></td>
						<td class="column-1"><%=productPrice * c.getCartCnt()%></td>
						<td class="column-1">
							<a href="<%=request.getContextPath()%>/order/removeCartAction.jsp?productNo=<%=c.getProductNo()%>" style="color: #747474; width:100px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
								삭제
							</a>
						</td>
					</tr>
				
			<%
				}
			%>
				</table>
							</div>
						</div>
					</div>
				</div>
			</form>
		
		<%
			}
		%>	
			<jsp:include page="/inc/footer.jsp"></jsp:include>
			<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
			<jsp:include page="/inc/quickView.jsp"></jsp:include>
			<jsp:include page="/inc/script.jsp"></jsp:include>
	</body>
</html>