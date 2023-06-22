<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	ArrayList<Cart> list = null;
	
	// model
	CartDao cartDao = new CartDao();
	
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
	String msg = "";
	String id = "";
	if (session.getAttribute("loginId") != null) { // 로그인 상태
		Customer customer = (Customer) session.getAttribute("loginId");
		id = customer.getId();
		System.out.println(id + " <-- id(cart)");
		list = cartDao.selectMyCart(id);
	} else { // 비로그인 상태
		if ((ArrayList<Cart>) session.getAttribute("sessionCart") == null) { // null이면 임시 값 생성
			list = new ArrayList<>();
		} else {
			list = (ArrayList<Cart>) session.getAttribute("sessionCart");
		}
	}

	System.out.println("==============cart.jsp==============");
%>

<!DOCTYPE html>
<!-- Cart -->
<div class="wrap-header-cart js-panel-cart">
	<div class="s-full js-hide-cart"></div>

	<div class="header-cart flex-col-l p-l-65 p-r-25">
		<div class="header-cart-title flex-w flex-sb-m p-b-8">
			<span class="mtext-103 cl2">
				Your Cart
			</span>

		<div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
			<i class="zmdi zmdi-close"></i>
		</div>
	</div>
	
	
	
		<form action="<%=request.getContextPath()%>/order/addOrderCart.jsp" method="post">
	<%
		int totalPrice = 0;
		// 로그인 상태이면 cart 테이블에서 데이터 조회
		if (session.getAttribute("loginId") != null) {
	%>
			
			<div class="header-cart-content flex-w js-pscroll">
			<ul class="header-cart-wrapitem w-full">
	<% 
			for (Cart c : list) {
				// 상품 이름 조회
				String productName = cartDao.selectProductName(c.getProductNo());
				// 상품 가격 조회
				int productPrice = cartDao.selectProductPrice(c.getProductNo());
				// 상품 이미지 조회
				String productImg = cartDao.selectImg(c.getProductNo());
				// 총 금액
				totalPrice += productPrice * c.getCartCnt();
	%>			
				<li class="header-cart-item flex-w flex-t m-b-12">	
					<a href="<%=request.getContextPath()%>/order/removeCartAction.jsp?cartNo=<%=c.getCartNo()%>">
						<div class="header-cart-item-img">
							<img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" alt="IMG">
						</div>
					</a>
					
					<div class="fs-35 lh-10 cl2 p-lr-6 hov-cl1 trans-04">
						<input type="hidden" id="productNo" name="productNo" value="<%=c.getProductNo()%>">
						<input type="hidden" id="cartCnt" name="cartCnt" value="<%=c.getCartCnt()%>">
						<input type="hidden" id="productImg" name="productImg" value="<%=productImg%>">
						<input type="hidden" id="productName" name="productName" value="<%=productName%>">
						<input type="hidden" id="productPrice" name="productPrice" value="<%=productPrice%>">
						<input type="hidden" id="totalPrice" name="totalPrice" value="<%=productPrice * c.getCartCnt()%>">
						<input type="hidden" id="cartNo" name="cartNo" value="<%=c.getCartNo()%>">
						<input type="checkbox" class="selCart" name="selCart" value="<%=c.getCartNo()%>">	
					</div>
					

					<div class="header-cart-item-txt p-t-8">
						<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=c.getProductNo()%>" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
							<%=productName%>
						</a>

						<span class="header-cart-item-info">
							 <%=productPrice%> x <%=c.getCartCnt()%> 
							
						</span>
						<br>
					</div>
				
				</li>
	<%
			}
		}
	%>
	</ul>
			<div class="w-full">
				<div class="header-cart-total w-full p-tb-40">
					Total: <%=totalPrice%>원
				</div>

				<div class="header-cart-buttons flex-w w-full">
					<a href="<%=request.getContextPath()%>/order/cartList.jsp" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
						View Cart
					</a>

					<button type="submit" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
						Check Out
					</button>
				</div>
			</div>
		</div>
		</form>
	</div>
</div>