<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 

<%
	// 세션 유효성 검사: 로그인 상태가 아니거나 관리자 계정으로 로그인된 경우 home으로 리다이렉션
	if (session.getAttribute("loginId") == null
	|| session.getAttribute("loginId") instanceof Employees) {
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 나의 주문 리스트 (주문날짜 최신순) 
	// 결제완료일 때 주문취소 버튼 노출 
	// 구매확정일 때 리뷰작성 버튼 노출 
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 세션 유효성 검사 추가
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
 	String msg = "";
	String id = "";
 	if (session.getAttribute("loginId") != null) {
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(myOrderList)");
 	}
	
	// model
	OrdersDao ordersDao = new OrdersDao();
	CustomerDao customerDao = new CustomerDao();
	
	// 현재 페이지 번호
	// currentPage가 null값이 아니면서 공백값이 아닌 경우 (유효값이 있는 경우)가 아닐 시 기본 1페이지 설정
	int currentPage = 1;
	if (request.getParameter("currentPage") != null
	&& !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(myOrderList)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 5;
	
	// 시작 행 번호(beginRow) - 0, 5, 10, ....
	// LIMIT (beginRow, rowPerPage)
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행 수 
	int totalRow = ordersDao.selectMyOrdersCnt(id); 
	
	// 마지막 페이지 번호
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	
	System.out.println(totalRow + " <-- totalRow(myOrderList)");
	System.out.println(lastPage + " <-- lastPage(myOrderList)");
	
	// [이전] [다음] 탭 사이 출력 행 수 
	int pagePerPage = 5;
	
	// [이전] 1 2 3 4 5 [다음]
	// [이전] 6 7 8 9 10 [다음]
	// [이전] 11 12 13 14 15 [다음]
			
	// [이전] [다음] 탭 사이 최소, 최대값
	int minPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage - 1);
	
	// maxPage가 lastPage보다 클 수 없음
	if (maxPage > lastPage) {
		maxPage = lastPage;
	}	
	
	// ArrayList<Orders> list 생성 후 값 추가
	ArrayList<Orders> list = new ArrayList<>();
	list = ordersDao.selectMyOrders(id, beginRow, rowPerPage);
	
	System.out.println("==============myOrderList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>myOrderList</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
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
				<a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="stext-109 cl8 hov-cl1 trans-04">
					mypage
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<span class="stext-109 cl4">
					myOrderList
				</span>
			</div>
		</div>
		
		 <form class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<div class="flex-w flex-sb-m p-b-17">
								<h4 class="mtext-111 cl2  p-r-20">
									나의 주문 리스트
								</h4>
							</div>
					<%
						if (request.getParameter("msg") != null) {
					%>
							<p style="color: #F24182; font-weight:bolder;"><%=request.getParameter("msg")%></p>
					<%
						}
					%>
							<br>
							<table class="table-shopping-cart">
								<tr class="table_head">
									<th class="text-center">주문코드</th>
									<th class="text-center">상품이름</th>
									<th class="text-center">주문상태</th> <!--p-r-10  -->
									<th class="text-center">가격</th>
									<th class="text-center">수량</th>
									<th class="text-center">사용포인트</th>
									<th class="text-center">적립</th>
									<th class="text-center">주문일자</th> <!-- p-l-40 -->
									<th class="text-center">상품이미지</th> <!-- p-l-20 -->
									<th class="p-l-35">기타옵션</th> <!-- p-l-20  -->
								</tr>
							<%
								for (Orders o : list) {
								// DB 내 주문번호 (orderNo)	
								int orderNo = o.getOrderNo();
									
								// 주문코드 조회
								String ordersCode = ordersDao.selectOrdersCode(o.getOrderNo());
								
								// 상품이름 조회
								String productName = ordersDao.selectProductName(o.getProductNo());
								
								// 사용 포인트 조회
								int point = customerDao.usedPoint(o.getOrderNo());
								
								// 적립 예정 포인트 조회
								int plusPoint = customerDao.plusPoint(o);
								
								// 상품 이미지 조회
								String productImg = ordersDao.selectImg(o.getProductNo());
							%>
								<tr class="table_head">
									<td class="text-center"><%=ordersCode%></td>
									<td class="text-center header-cart-item-txt p-t-8">
										<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=o.getProductNo()%>" class="header-cart-item-name m-b-18 hov-cl1 trans-04">	
											<%=productName%>
										</a>
									</td>
									<td class="text-center"><%=o.getOrderStatus()%></td> <!-- p-r-10  -->
									<td class="text-center"><%=o.getOrderPrice()%></td>
									<td class="text-center"><%=o.getOrderCnt()%></td> <!-- p-l-10 -->
									<td class="text-center"><%=point%></td>
									<td class="text-center"><%=plusPoint%></td>
									<td class="text-center"><%=o.getCreatedate().substring(0, 16)%></td>
									<td class="text-center"><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
									
								<%
									
									if (o.getOrderStatus().equals("결제완료")) { // 결제완료일 때 주문취소 버튼 노출
								%>
										<td class="p-l-20">
											<a href="<%=request.getContextPath()%>/order/removeMyOrder.jsp?orderNo=<%=orderNo%>" style="color: #747474; width:100px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
												주문취소
											</a>
										</td>
								<%		
									} else if (o.getOrderStatus().equals("구매확정")) { // 구매확정일 때 리뷰작성 버튼 노출
										if (customerDao.orderChkReview(orderNo) == 0) { // 작성한 리뷰가 없을 경우에만 리뷰작성 버튼 노출
								%>
											<td class="p-l-20">
												<a href="<%=request.getContextPath()%>/customer/addReview.jsp?orderNo=<%=orderNo%>" style="color: #747474; width:100px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
													리뷰작성
												</a>
											</td>
								<% 
										}
									} else if (o.getOrderStatus().equals("배송완료")) { // 배송완료일때 구매확정 버튼 노출	
								%>
										<td class="p-l-20">
											<a href="<%=request.getContextPath()%>/order/purchaseAction.jsp?orderNo=<%=orderNo%>&orderStatus=<%=o.getOrderStatus()%>&createdate=<%=o.getCreatedate()%>&orderPrice=<%=o.getOrderPrice()%>&orderCnt=<%=o.getOrderCnt()%>" style="color: #747474; 	width:100px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
												구매확정
											</a>
										</td>
								<%
									} else {
								%>
										<td>&nbsp;</td>
								<% 		
									}
								%>	
								</tr>
							<%
								}
							%>
							</table>
							
							<br>
							<div class="flex-w dis-inline-block">
								<a href="<%=request.getContextPath()%>/customer/myPage.jsp" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
										취소
									</span>
								</a>
							</div>
							
							<!-- Pagination -->
							<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
							<%
								// minPage가 1보다 클 때만 [이전] 탭 출력
								if (minPage > 1) {
							%>
									<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp?currentPage=<%=minPage - pagePerPage%>" class="flex-c-m how-pagination1 trans-04 m-all-7">
										이전
									</a>
							<%
								}
							
								// [이전] [다음] 탭 내에서 반복
								for (int i = minPage; i <= maxPage; i += 1) {
									if (currentPage == i) { // 현재 페이지 번호에는 링크 없이 표시
							%>
										<a href="" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
											<%=i%>
										</a>
							<%
									} else { // 현재 페이지가 아닌 나머지 페이지에는 번호를 링크로 표시 (클릭 시 해당 번호 페이지로 이동)
							%>
										<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp?currentPage=<%=i%>" class="flex-c-m how-pagination1 trans-04 m-all-7">
											<%=i%>
										</a>
										
							<%			
									}
								}
							
								if (maxPage < lastPage) { // 마지막 페이지보다 maxPage가 작을 때만 다음 버튼 출력
							%>
									<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp?currentPage=<%=minPage + pagePerPage%>" class="flex-c-m how-pagination1 trans-04 m-all-7">
										다음
									</a>
							<% 
								}
							%>
							
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