<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>   
<%@ page import="java.net.*"%> 
<%
	// css 이슈
	// 전체 고객 주문 리스트 (관리자 로그인 상태에서 볼 수 있는 리스트)
	// 필터 : 아이디, 상태, 날짜 (기본정렬 주문일자 최신순)
	// 아이디 검색 / 주문상태 선택 / 날짜 범위 선택
	
	// 주문상태 수정 -> 옵션 : 결제완료 / 취소 / 배송완료 / 구매확정 -> modifyOrderStatusAction.jsp 파일에서 실행

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 요청값 디버깅
	// 체크박스 선택된 월값
	// request.getParamterValues(): 여러 값을 받아옴
	String[] ckMonth = request.getParameterValues("ckMonth");
	System.out.println(request.getParameterValues("ckMonth") + " <-- ckMonth");
	
	int[] intCkMonth = null;
	if (ckMonth != null) { // 넘어온 값이 있으면
		intCkMonth = new int[ckMonth.length]; // String 배열의 길이와 같은 길이의 배열 생성
		for (int i = 0; i < intCkMonth.length; i += 1) { // String 배열 길이만큼 값을 추가
			intCkMonth[i] = Integer.parseInt(ckMonth[i]);
		}
	}
	
	// 검색한 id
	String searchId = "";
	if (request.getParameter("searchId") != null) {
		searchId = request.getParameter("searchId");
	}
	
	
	// 주문상태 선택 
	String orderStatus = "";
	if (request.getParameter("orderStatus") != null) {
		orderStatus = request.getParameter("orderStatus");
	}
	
	System.out.println(searchId + " <-- searchId(orderList)");
	System.out.println(orderStatus + " <-- orderStatus(orderList)");
	
	// OrdersDao 클래스 객체 생성 -> SQL 메소드 이용
	OrdersDao ordersDao = new OrdersDao();

	// 현재 페이지 번호
	// currentPage가 null값이 아니면서 공백값이 아닌 경우 (유효값이 있는 경우)가 아닐 시 기본 1페이지 설정
	int currentPage = 1;
	if (request.getParameter("currentPage") != null
	&& !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(orderList)");
	
	// 페이징 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호(beginRow) - 0, 10, 20, ...
	// ... LIMIT (beginRow, rowPerPage)
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행 수 
	int totalRow = ordersDao.selectOrdersCnt();
	
	// 마지막 페이지 번호
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	
	System.out.println(totalRow + " <-- totalRow(orderList)");
	System.out.println(lastPage + " <-- lastPage(orderList)");
	
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
	list = ordersDao.selectOrdersByIdStatus(intCkMonth, searchId, orderStatus, beginRow, rowPerPage);
	
	System.out.println("==============orderList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>orderList</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>
		
		<form action="<%=request.getContextPath()%>/order/orderList.jsp" method="get" class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-11 col-xl-11 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<h4 class="mtext-111 cl2 p-b-30">
								전체 고객 주문 리스트
							</h4>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
			<label>ID 검색 : </label>
			<input type="text" name="searchId" value="<%=searchId%>" placeholder="id 검색">
			
			<label>주문상태 : </label>
			<select name="orderStatus">
				<option value="" <%if(orderStatus.equals("")){ %>selected<%}%>>선택</option>
				<option value="결제완료" <%if(orderStatus.equals("결제완료")){ %>selected<%}%>>결제완료</option>
				<option value="주문취소" <%if(orderStatus.equals("주문취소")){ %>selected<%}%>>주문취소</option>
				<option value="배송완료" <%if(orderStatus.equals("배송완료")){ %>selected<%}%>>배송완료</option>
				<option value="구매확정" <%if(orderStatus.equals("구매확정")){ %>selected<%}%>>구매확정</option>
			</select>	
			<%
				//체크검사
				boolean[] checked = {false, false, false, false, false, false, false, false, false, false, false, false};
				//for 문 보다는 foreach문을 활용
				int[] months = {1,2,3,4,5,6,7,8,9,10,11,12};
				for(int m : months) {
					if(intCkMonth != null) {
						// 체크한 월이면 true 대입
						for(int i : intCkMonth) {
							if(i == m) {
								checked[i-1] = true;
							}
						}
					}
					// ture이면 체크
					if (checked[m-1] == true) {
				%> 
					<input type="checkbox" name="ckMonth" value="<%=m%>" checked="checked"><%=m%>월
				<%	
					} else {
				%>
					<input type="checkbox" name="ckMonth" value="<%=m%>"> <%=m%>월
				<%			
						}		
					}
				%>
			<button type="submit">검색</button>
			
		<table class="center">
			<colgroup>
		     	<col width="8%">
		     	<col width="8%">
		     	<col width="10%">
		     	<col width="10%">
		     	<col width="8%">
		     	<col width="10%">
		     	<col width="10%">
		     	<col width="*%">
		     	<col width="*%">
	   		 </colgroup>
			<tr class="bor12">
				<th>주문번호</th>
				<th>상품번호</th>
				<th>ID</th>
				<th>주문상태</th>
				<th>주문수량</th>
				<th>가격</th>
				<th>합계금액</th>
				<th>주문일자</th>
				<th>수정일자</th>
			</tr>
		<%
			for (Orders o : list) {
		%>
			<tr class="bor12">
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getOrderNo()%></td>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getProductNo()%></td>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getId()%></td>
				
		<%
			if (o.getOrderStatus().equals("결제완료")) { // 주문상태가 결제완료인 경우 링크 클릭하면 배송완료로 상태 변경
		%>	
		  		<td class="stext-112 cl8" style="font-size:17px;"><a href="<%=request.getContextPath()%>/order/modifyOrderStatusAction.jsp?orderNo=<%=o.getOrderNo()%>&createdate=<%=o.getCreatedate()%>">결제완료</a></td>
		<%
			} else {
		
		%>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getOrderStatus()%></td>
		<%
			}
		%>		
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getOrderCnt()%></td>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getOrderPrice()%>원</td>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getOrderPrice() * o.getOrderCnt()%>원</td>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getCreatedate()%></td>
				<td class="stext-112 cl8" style="font-size:17px;"><%=o.getUpdatedate()%></td>
			</tr>
		<%
			}
		%>
		</table>
		
		<%
			// minPage가 1보다 클 때만 [이전] 탭 출력
			if (minPage > 1) {
		%>	
				<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=minPage - pagePerPage%>">이전</a>
		<%
			}
		%>
		
		<%
			// [이전] [다음] 탭 내에서 반복
			for (int i = minPage; i <= maxPage; i++) {
				if (currentPage == i) { // 해당 페이지는 링크 없이 표시 (css 적용 전)
		%>
					<span><%=i%></span>
		<% 			
				} else { // 현재 페이지가 아닌 나머지 페이지에는 번호를 링크로 표시 (클릭 시 해당 번호 페이지로 이동)
		%>
					<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				}
			}
		
			if (maxPage < lastPage) { // [이전] [다음] 탭 사이 가장 큰 숫자가 마지막 페이지보다 작을 때만 [다음] 버튼 생성	
		%>
				<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=minPage + pagePerPage%>">다음</a>
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