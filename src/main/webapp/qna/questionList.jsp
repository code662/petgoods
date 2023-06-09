<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int productNo = 1;
	// sql 메서드들이 있는 클래스의 객체 생성
	QuestionDao qDao = new QuestionDao();
	// 전체 행의 수
	int totalRow = qDao.selectQuestionCnt(productNo);
	// 페이지 당 행의 수
	int rowPerPage = 1;
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	// 마지막 페이지 번호
	int lastPage = totalRow / rowPerPage;
	// 표시하지 못한 행이 있을 경우 페이지 + 1
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	// 현재 페이지에 표시 할 리스트
	ArrayList<Question> list = qDao.selectQuestion(productNo, beginRow, rowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 상품 문의 리스트</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
	<jsp:include page="/inc/sidebar.jsp"></jsp:include>
	<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="index.html" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				QuestionList
			</span>
		</div>
	</div>
	
	<!-- Shoping Cart -->
	<form class="bg0 p-t-75 p-b-85">
		<div class="container">
			<div class="row">
				<div class="col-lg-10 col-xl m-lr-auto m-b-50">
					<div class="m-l-25 m-r--38 m-lr-0-xl">
						<div class="wrap-table-shopping-cart">
							<table class="table-shopping-cart">
								<tr class="table_head">
									<th class="column-1">이름</th>
									<th class="column-2"></th>
									<th class="column-3">시수</th>
								</tr>
								<%
									for(Question q : list) {
								%>
										<tr class="table_row">
											<td class="column-1" cols="2">
												<a href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=q.getId()%>">
													<%=q.getId()%>
												</a>
											</td>
											<td class="column-2"></td>
											<td class="column-3"><%=q.getqContent()%></td>
										</tr>
								<%		
									}
								%>
							</table>
						</div>

						<div class="flex-w flex-sb-m bor15 p-t-18 p-b-15 p-lr-40 p-lr-15-sm">
							<div class="flex-w flex-m m-r-20 m-tb-5">
								<input class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5" type="text" name="coupon" placeholder="Coupon Code">
									
								<div class="flex-c-m stext-101 cl2 size-118 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-5">
									Apply coupon
								</div>
							</div>

							<div class="flex-c-m stext-101 cl2 size-119 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-10">
								Update Cart
							</div>
						</div>
					<%
						// 페이징 수
						int pagePerPage = 10;
						// 최소 페이지
						int minPage = (currentPage-1) / pagePerPage * pagePerPage + 1;
						// 최대 페이지
						int maxPage = minPage + pagePerPage - 1;
						// 최대 페이지가 마지막 페이지 보다 크면 최대 페이지 = 마지막 페이지
						if(maxPage > lastPage) {
							maxPage = lastPage;
						}
						// 이전 페이지
						// 최소 페이지가 1보타 클 경우 이전 페이지 표시
						if(minPage>1) {
					%>
							<a href="<%=request.getContextPath()%>/qna/questionList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>
					<%			
						}
						// 최소 페이지부터 최대 페이지까지 표시
						for(int i = minPage; i<=maxPage; i=i+1) {
							if(i == currentPage) {	// 현재페이지는 링크 비활성화
					%>	
							<%=i%>
					<%			
							}else {					// 현재페이지가 아닌 페이지는 링크 활성화
					%>	
								<a href="<%=request.getContextPath()%>/qna/questionList.jsp?currentPage=<%=i%>"><%=i%></a>
					<%				
							}
						}
						// 다음 페이지
						// 최대 페이지가 마지막 페이지와 다를 경우 다음 페이지 표시
						if(maxPage != lastPage) {
					%>
							<a href="<%=request.getContextPath()%>/qna/questionList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
					<%	
						}
					%>
					</div>
				</div>
			</div>
		</div>
	</form>
	<br>
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
	<jsp:include page="/inc/quickView.jsp"></jsp:include>
	<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>   