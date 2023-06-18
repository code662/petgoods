<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 

<%
	// 내가 주문한 리스트 (주문날짜 최신순) 
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
 	
 	// id = "user1";
	
	/*
	// 요청값(id) 유효성 검사 
	if (request.getParameter("id") == null
	|| request.getParameter("id").equals("")) {
		// 이전 페이지로 이동
		return;
	}
	
	// 마이페이지에서 id값 넘어와야 함 -> 추후 수정할 것 (임시로 id = user1 설정)
	// String id = "user1";
	
	
	*/
	
	// OrdersDao 클래스 객체 생성 -> SQL 메소드 이용
	OrdersDao ordersDao = new OrdersDao();
	
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
	int totalRow = ordersDao.selectMyOrdersCnt(id); // id값 추후 수정
	
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
		
		 <form class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-11 col-xl-11 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<h4 class="mtext-111 cl2 p-b-30">
								나의 주문 리스트
							</h4>

		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<table>
 			<colgroup>
		     	<col width="*">
		     	<col width="10%">
		     	<col width="15%">
		     	<col width="15%">
		     	<col width="5%">
		     	<col width="15%">
		     	<col width="10%">
		     	<col width="10%">
	   		 </colgroup>
			<tr class="bor12">
				<th>주문코드</th>
				<th>상품이름</th>
				<th>주문상태</th>
				<th>가격</th>
				<th>수량</th>
				<th>주문일자</th>
				<th>이미지</th>
				<th>기타옵션</th>
			</tr>
		<%
			for (Orders o : list) {
			// DB 내 주문번호 (orderNo)	
			int orderNo = o.getOrderNo();
				
			// 주문코드 조회
			String ordersCode = ordersDao.selectOrdersCode(o.getOrderNo());
			
			// 상품이름 조회
			String productName = ordersDao.selectProductName(o.getProductNo());
			
			// 상품 이미지 조회
			String productImg = ordersDao.selectImg(o.getProductNo());
		%>
			<tr class="bor12">
				<td><%=ordersCode%></td>
				<td><%=productName%></td>
				<td><%=o.getOrderStatus()%></td>
				<td><%=o.getOrderPrice()%></td>
				<td><%=o.getOrderCnt()%></td>
				<td><%=o.getCreatedate()%></td>
				<td><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
				
			<%
				
				if (o.getOrderStatus().equals("결제완료")) { // 결제완료일 때 주문취소 버튼 노출
			%>
					<td><a href="<%=request.getContextPath()%>/order/removeMyOrder.jsp?orderNo=<%=orderNo%>">주문취소</a></td>
			<%		
				} else if (o.getOrderStatus().equals("구매확정")) { // 구매확정일 때 리뷰작성 버튼 노출
			%>
					<td><a href="<%=request.getContextPath()%>/customer/addReview.jsp?orderNo=<%=orderNo%>">리뷰작성</a></td>
			<% 	
				} else if (o.getOrderStatus().equals("배송완료")) { // 배송완료일때 구매확정 버튼 노출	
			%>
					<td><a href="<%=request.getContextPath()%>/order/purchaseAction.jsp?orderNo=<%=orderNo%>&orderStatus=<%=o.getOrderStatus()%>&createdate=<%=o.getCreatedate()%>&orderPrice=<%=o.getOrderPrice()%>&orderCnt=<%=o.getOrderCnt()%>">구매확정</a></td>
			<%
				} else {
			%>
					<td>없음</td>
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
			<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
				<a href="<%=request.getContextPath()%>/customer/myPage.jsp" style="color: #333333">
					뒤로가기
				</a>
			</div>
		</div>
	
		
		
		<%
			// minPage가 1보다 클 때만 [이전] 탭 출력
			if (minPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp?currentPage=<%=minPage - pagePerPage%>">이전</a>
		<%
			}
		
			// [이전] [다음] 탭 내에서 반복
			for (int i = minPage; i <= maxPage; i += 1) {
				if (currentPage == i) { // 현재 페이지 번호에는 링크 없이 표시
		%>
					<span><%=i%></span>
		<%
				} else { // 현재 페이지가 아닌 나머지 페이지에는 번호를 링크로 표시 (클릭 시 해당 번호 페이지로 이동)
		%>
					<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%			
				}
			}
		
			if (maxPage < lastPage) {	
		%>
				<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp?currentPage=<%=minPage + pagePerPage%>"></a>
		<% 
			}
		%>
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