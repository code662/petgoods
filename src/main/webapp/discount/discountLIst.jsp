<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 
<%@ page import="java.util.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	DiscountDao dd = new DiscountDao();
	
	// 페이징 
	int currentPage = 1; // 시작 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5; // 한페이지에 출력할 게시물 수
	int beginRow = (currentPage -1)*rowPerPage; // 한페이지에 출력될 첫번째 행 번호
	
	ReviewDao rd = new ReviewDao(); // Dao 객체 생성
	int totalRow = dd.discountCnt(); // 전체 행 수

	int lastPage = totalRow / rowPerPage; // 마지막페이지
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	if(totalRow < currentPage){
		currentPage = lastPage;
	}
	
	int pagePerPage = 5; // 한번에 출력될 페이징 버튼 수
	int startPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1; // 페이징 버튼 시작 값
	int endPage = startPage + pagePerPage - 1; // 페이징 버튼 종료 값
	if(endPage > lastPage){
		endPage = lastPage;
	}

	
	ArrayList<Discount> list = new ArrayList<>();
	if(request.getParameter("searchProductNo") == null
			|| request.getParameter("searchProductNo").equals("")){ //검색값이 없을 경우 : 전체리스트
		list = dd.selectDiscount(beginRow, rowPerPage);
	}else{ // 검색값이 있을 경우 : product_no별로 리스트
		int searchProductNo = Integer.parseInt(request.getParameter("searchProductNo"));
		list = dd.searchProducNo(searchProductNo, beginRow, rowPerPage);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 리스트</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<form class="bg0 p-t-75 p-b-85" action="<%=request.getContextPath()%>/discount/discountList.jsp" method="get">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<div class="flex-w flex-sb-m p-b-17">
							<h4 class="mtext-111 cl2  p-r-20">
								할인 상품 리스트
							</h4>
							<span class="fs-18 cl11 stext-102 flex-w m-r--5">
								<a href="<%=request.getContextPath()%>/discount/addDiscount.jsp" style="color: #333333" class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
									할인 상품 추가
								</a>
							</span>
						</div>
						
						<!-- 리다이렉션 메시지 -->
						<div>
						<%
						   if(request.getParameter("msg") != null){
						%>
								<p style="color: #F24182; font-weight:bolder;"><%=request.getParameter("msg") %></p>
						<%
						   }
						%>
						<br>
						</div>
						
						<!-- 검색입력창 -->
						<div class="flex-w flex-sb-m p-b-17">
							<span class="mtext-107 cl2 p-r-20">
								&nbsp;
							</span>
							<span class="fs-18 cl11 stext-102 flex-w m-r--5">
								<input type="text" class="bor8 stext-103" name="searchProductNo" placeholder="상품 번호 입력" style="text-align: center;">
								&nbsp;
								<span class="fs-18 cl11 stext-102 flex-w m-r--5">
									<button type="submit" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">검색</button>			
								</span>
							</span>
						</div>
						
						<!-- 할인상품리스트 -->
						<table class="table-shopping-cart">
							<tr class="table_head" >
								<th class="column-1" style="width: 10%">상품 번호</th>
								<th class="column-1" style="width: 20%">상품 이름</th>
								<th class="column-1" style="width: 13%">할인 시작일</th>
								<th class="column-1" style="width: 13%">할인 종료일</th>
								<th class="column-1" style="width: 10%">할인율</th>
								<th class="column-1" style="width: 13%">등록일</th>
								<th class="column-1">&nbsp;</th>
							</tr>
						<%
							for(Discount d : list) {
						%>
								<tr class="table_head" style="height: 100px">
									<td class="column-1" style="width: 10%"><%=d.getProductNo() %></td>
									<td class="column-1" style="width: 20%" ><%=d.getProductName() %></td>
									<td class="column-1" style="width: 13%"><%=d.getDiscountStart().substring(0,10) %></td>
									<td class="column-1" style="width: 13%"><%=d.getDiscountEnd().substring(0,10) %></td>
									<td class="column-1" style="width: 10%"><%=(int)Math.floor(d.getDiscountRate()*100) %>%</td>
									<td class="column-1" style="width: 13%"><%=d.getCreatedate().substring(0,10) %></td>
									<td class="column-1">
										<span class="flex-w dis-inline-block">
										<a href="<%=request.getContextPath()%>/discount/modifyDiscount.jsp?discountNo=<%=d.getDiscountNo() %>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
											수정
										</a>
										<a href="<%=request.getContextPath()%>/discount/removeDiscountAction.jsp?discountNo=<%=d.getDiscountNo() %>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
											삭제
										</a>
										</span>
									</td>
								</tr>
						<%		
							}
						%>
						</table>
						
						<!-- Pagination -->
						<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
						<%
							//이전 페이지 버튼
							if(startPage >1){
						%>
					 				<a href="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=startPage-pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
					 					이전 
					 				</a>
					   	<%
							}
					        for(int i = startPage; i <= endPage; i++){
					        	if(i==currentPage){
					    %>
					    			<a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
					       				<%=i %>
					       			</a>
					    <%
					        	}else{
					   	%>
					       			<a href="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=i %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
					       				<%=i %>
					       			</a>
					    <%
					       		}
					        }
					    	//다음 페이지 버튼
					    	if(endPage != lastPage){
					    %>
								<a href="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=startPage+pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
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