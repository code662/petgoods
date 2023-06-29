<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 로그인 아이디 유효성 검사
	if(session.getAttribute("loginId") == null
		|| !(session.getAttribute("loginId") instanceof Customer)) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId();
	
	// 현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	ProductDao pDao = new ProductDao();
	QuestionDao qDao = new QuestionDao();
	
	// 전체 행의 수
	int totalRow = qDao.myQuestionCnt(id);
	// 페이지 당 행의 수
	int rowPerPage = 5;
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	// 마지막 페이지 번호
	int lastPage = totalRow / rowPerPage;
	// 표시하지 못한 행이 있을 경우 페이지 + 1
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	// 페이징 수
	int pagePerPage = 5;
	// 최소 페이지
	int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
	// 최대 페이지
	int maxPage = minPage + pagePerPage - 1;
	// 최대 페이지가 마지막 페이지 보다 크면 최대 페이지 = 마지막 페이지
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	// 현재 페이지에 표시 할 리스트
	ArrayList<Question> list = qDao.selectMyQuestion(id,beginRow, rowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 상품 문의 리스트</title>
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
				MyPage
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				QuestionList
			</span>
		</div>
	</div>
	
	<form class="bg0 p-t-75 p-b-85" action="<%=request.getContextPath()%>/discount/discountList.jsp" method="get">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<div class="flex-w flex-sb-m p-b-17">
							<h4 class="mtext-111 cl2  p-r-20 p-b-30">
								상품 문의 리스트
							</h4>
						</div>
							<!-- 할인상품리스트 -->
							<table class="table-shopping-cart">
								<tr class="table_head" >
									<th class="column-7-25">상품이름</th>
									<th class="column-7-10">문의유형</th>
									<th class="column-7-25">문의제목</th>
									<th class="column-7-15">문의상태</th>
								</tr>
							<%
								for(Question q : list) {
							%>
									<tr class="table_head" style="height: 80px;">
										<td class="column-7-25"><%=pDao.selectProductOne(q.getProductNo()).getProductName() %></td>
										<td class="column-7-10"><%=q.getqCategory() %></td>
										<td class="column-7-25">
											<span class="fs-18 cl11 stext-102 flex-w m-r--5 flex-c">
												<a href="<%=request.getContextPath()%>/qna/myQuestionOne.jsp?questionNo=<%=q.getqNo()%>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
													<%=q.getqTitle() %>
												</a>
											</span>
										</td>
										<td class="column-7-15"><%=q.getqStatus() %></td>
									</tr>
							<%		
								}
							%>
							</table>
							
							<!-- Pagination -->
							<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
							<%
								//이전 페이지 버튼
								if(minPage >1){
							%>
						 				<a href="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=minPage-pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
						 					이전 
						 				</a>
						   	<%
								}
						        for(int i = minPage; i <= maxPage; i++){
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
						    	if(maxPage != lastPage){
						    %>
									<a href="<%=request.getContextPath()%>/discount/discountList.jsp?currentPage=<%=minPage+pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
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