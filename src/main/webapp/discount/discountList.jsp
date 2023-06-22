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

	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			
			<span class="stext-109 cl4">
				discountList
			</span>
		</div>
	</div>
	
	<form class="bg0 p-t-75 p-b-85" action="<%=request.getContextPath()%>/discount/discountList.jsp" method="get">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<div class="flex-w flex-sb-m p-b-17">
							<h4 class="mtext-111 cl2  p-r-20">
								할인 상품 리스트
							</h4>
							
							
							<div class="fs-18 cl11 stext-102 flex-w m-r--5">
								<div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
									<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
									<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
									Search
								</div>
								<a href="<%=request.getContextPath()%>/discount/addDiscount.jsp" class="flex-c-m stext-106 cl6 size-102 bor4 pointer hov-btn3 trans-04 m-tb-4 m-l-8">
									<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-plus"></i>
									할인 상품 추가
								</a>
							</div>
						</div>
						
						<!-- Search product -->
						<div class="dis-none panel-search w-full p-t-10 p-b-15">
							<div class="bor8 dis-flex p-l-15">
								<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
									<i class="zmdi zmdi-search"></i>
								</button>
		
								<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="searchProductNo" placeholder="상품 번호 입력">
							</div>	
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
						
						<!-- 할인상품리스트 -->
						<table class="table-shopping-cart">
							<tr class="table_head" >
								<th class="column-1" style="width: 10%">상품번호</th>
								<th class="column-1" style="width: 20%">상품이름</th>
								<th class="column-1" style="width: 14%">할인 시작일</th>
								<th class="column-1" style="width: 14%">할인 종료일</th>
								<th class="column-1" style="width: 9%">할인율</th>
								<th class="column-1" style="width: 14%">등록일</th>
								<th class="column-1">&nbsp;</th>
							</tr>
						<%
							for(Discount d : list) {
						%>
								<tr class="table_head" style="height: 100px;">
									<td class="column-1" style="width: 10%"><%=d.getProductNo() %></td>
									<td class="column-1" style="width: 20%" ><%=d.getProductName() %></td>
									<td class="column-1" style="width: 14%"><%=d.getDiscountStart().substring(0,10) %></td>
									<td class="column-1" style="width: 14%"><%=d.getDiscountEnd().substring(0,10) %></td>
									<td class="column-1" style="width: 9%"><%=(int)Math.floor(d.getDiscountRate()*100) %>%</td>
									<td class="column-1" style="width: 14%"><%=d.getCreatedate().substring(0,10) %></td>
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