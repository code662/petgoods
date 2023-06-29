<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
    
<%
	// 주문취소 폼 
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값	(OrdersDao 내 상세 정보 메소드 요청값 -> order_no) 유효성 확인
	// order_no 값 없을 시 내 주문 목록으로 이동 
	if (request.getParameter("orderNo") == null
	|| request.getParameter("orderNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/customer/myOrderList.jsp");
		return;
	}
	
	// 요청값 디버깅
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo + " <-- orderNo(removeMyOrder)");
	
	// OrdersDao 클래스 객체 생성 -> 메소드 내 쿼리 이용
	OrdersDao ordersDao = new OrdersDao();
	Orders order = new Orders();
	order = ordersDao.selectOrderOne(orderNo); // 해당 주문번호를 가진 상품 상세 정보 조회
	
	// 주문코드 조회
	String orderCode = ordersDao.selectOrdersCode(orderNo);
	
	// 상품이름 조회
	String productName = ordersDao.selectProductName(order.getProductNo());
	
	// 함께 주문한 상품들의 목록
	ArrayList<Orders> list = new ArrayList<>();
	list = ordersDao.selectStatusNew(order);
	
	// 함께 주문한 상품의 개수 (선택한 상품 포함)
	int cnt = list.size();

	System.out.println("==============removeMyOrder.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeMyOrder</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>

		<form action="<%=request.getContextPath()%>/order/removeMyOrderAction.jsp" method="post" class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">	 	
							<h4 class="mtext-111 cl2 p-b-30">
								주문취소
							</h4>
								<h6 style="color: #F24182; font-weight:bolder;">주문을 취소하시겠습니까?</h6>
								<br>
								<input type="hidden" name="orderNo" value="<%=order.getOrderNo()%>">
								<input type="hidden" name="orderId" value="<%=order.getId()%>">
								<input type="hidden" name="createdate" value="<%=order.getCreatedate()%>">
								<div class="flex-w flex-t bor12 p-b-13">
									<div class="size-208">
										<span class="stext-110 cl2" style="font-size:17px">
											주문코드
										</span>
									</div>
									<div class="size-209">
										<span class="stext-112 cl8" style="font-size:17px">
											<%=orderCode%>
										</span>
									</div>
								</div>
								<div class="flex-w flex-t bor12 p-t-15 p-b-30">
								<div class="size-208 w-full-ssm">
									<span class="stext-110 cl2" style="font-size:17px">
										상품이름
									</span>
								</div>
								<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
									<p class="stext-112 cl8 p-t-2" style="font-size:17px">
								<%
									if (cnt == 1) {
								%>
										<%=productName%>
								<%
									} else {
								%>
										<%=productName%> 외 <%=cnt - 1%> 개 상품
								<%
									}
								%>
									</p>
								</div>
							</div>
							<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									가격
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=order.getOrderPrice()%>
								</p>
							</div>
							</div>
							<div class="flex-w flex-t bor12  p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									수량
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=order.getOrderCnt()%>
								</p>
							</div>
							</div>
							<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									주문일자
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=order.getCreatedate()%>
								</p>
							</div>
							</div>
							<br>
							<div class="flex-w dis-inline-block">
								<button type="submit" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
										주문취소
									</span>
								</button>
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