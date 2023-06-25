<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 결제완료 메시지 출력
	// 주문내역 테이블 출력 (상품이미지, 상품이름, 가격, 수량, 합계금액 / 총 금액, 사용 포인트)
	// 쇼핑계속하기 / 주문내역확인
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// addOrderCartAction.jsp에서 넘어온 값
	String[] productImg = (String[]) session.getAttribute("productImg");
	String[] productName = (String[]) session.getAttribute("productName");
	String[] productPrice = (String[]) session.getAttribute("productPrice");
	String[] cartCnt = (String[]) session.getAttribute("cartCnt");
	int point = 0;
	if (session.getAttribute("point") != null) {
		point = (int) session.getAttribute("point");
	}
	
	System.out.println(productName + " <-- productName(completeOrderCart)");
	System.out.println(productImg + " <-- productImg(completeOrderCart)");
	System.out.println(productPrice + " <-- productPrice(completeOrderCart)");
	System.out.println(cartCnt + " <-- cnt(completeOrderCart)");
	System.out.println(point + " <-- point(completeOrderCart)");
	
	System.out.println("==============completeOrderCart.jsp==============");	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>completeOrderCart</title>
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
						addOrderCart
						<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
					</span>
					<span class="stext-109 cl4">
						completeOrderCart
					</span>
				</div>
			</div>
			
			<form class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<div class="flex-w flex-sb-m p-b-17">
								<h4 class="mtext-111 cl2  p-r-20 txt-center">
									결제완료
								</h4>
							</div>
							<br>
							<table class="table-shopping-cart">
									<tr class="table_head">
										<th class="text-center">상품이미지</th>
										<th class="text-center">상품이름</th>
										<th class="text-center">가격</th>
										<th class="text-center">수량</th>
										<th class="text-center">합계금액</th>
									</tr>
							<%
								int totalPrice = 0;
								for (int i = 0; i < productName.length; i += 1) {
									totalPrice += Integer.parseInt(productPrice[i]) * Integer.parseInt(cartCnt[i]);
							%>
									<tr class="table_head">
										<td class="text-center">
											<img src="<%=request.getContextPath()%>/pimg/<%=productImg[i]%>" width="100" height="100">	
										</td>
										<td class="text-center"><%=productName[i]%></td>
										<td class="text-center"><%=productPrice[i]%></td>
										<td class="text-center"><%=cartCnt[i]%></td>
										<td class="text-center"><%=Integer.parseInt(productPrice[i]) * Integer.parseInt(cartCnt[i])%></td>
									</tr>
							<%
								}
							%>
							</table>
							<br>
							<div style="text-align: right;">
								총 합계 금액: <%=totalPrice%>원<br>
								사용 포인트: <%=point%>
							</div>
							<br>
							<div class="flex-w dis-inline-block cen">
								<a href="<%=request.getContextPath()%>/product/productList.jsp" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
									 	쇼핑계속하기
									</span>
								</a>
								&nbsp;
								<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
										주문내역 확인
									</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
		<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
		<jsp:include page="/inc/quickView.jsp"></jsp:include>
		<jsp:include page="/inc/script.jsp"></jsp:include>
	</body>
</html>