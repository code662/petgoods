<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	if(request.getParameter("productNo") == null 
		|| request.getParameter("productNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
	}

	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	ProductDao pDao = new ProductDao();
	ReviewDao rDao = new ReviewDao();
	QuestionDao qDao = new QuestionDao();
	AnswerDao aDao = new AnswerDao();
	
	Product product = pDao.selectProductOne(productNo);
	
	// 리뷰 페이징
	// 리뷰 현재페이지
	int reviewCurrentPage = 1;
	if(request.getParameter("reviewCurrentPage") != null) {
		reviewCurrentPage = Integer.parseInt(request.getParameter("reviewCurrentPage"));
	}
	// 상품의 전체 리뷰 행의 수
	int reviewTotalRow = rDao.reviewCnt(productNo);
	// 리뷰 페이지 당 행의 수
	int reviewRowPerPage = 5;
	// 리뷰 시작 행 번호
	int reviewBeginRow = (reviewCurrentPage-1) * reviewRowPerPage;
	// 리뷰 마지막 페이지 번호
	int reviewLastPage = reviewTotalRow / reviewRowPerPage;
	// 표시하지 못한 행이 있을 경우 페이지 + 1
	if(reviewTotalRow % reviewRowPerPage != 0) {
		reviewLastPage = reviewLastPage + 1;
	}
	// 상품의 리뷰 리스트
	ArrayList<HashMap<String,Object>> reviewList = rDao.selectReview(productNo, reviewBeginRow, reviewRowPerPage);
	
	// 상품 문의 페이징
	// 문의 현재페이지
	int questionCurrentPage = 1;
	if(request.getParameter("questionCurrentPage") != null) {
		questionCurrentPage = Integer.parseInt(request.getParameter("questionCurrentPage"));
	}
	// 전체 문의 행의 수
	int questionTotalRow = qDao.selectQuestionCnt(product.getProductNo());
	// 문의 페이지 당 행의 수
	int questionRowPerPage = 5;
	// 문의 시작 행 번호
	int questionBeginRow = (questionCurrentPage-1) * questionRowPerPage;
	// 문의 마지막 페이지 번호
	int questionLastPage = questionTotalRow / questionRowPerPage;
	// 표시하지 못한 행이 있을 경우 페이지 + 1
	if(questionTotalRow % questionRowPerPage != 0) {
		questionLastPage = questionLastPage + 1;
	}
	// 상품의 문의 리스트
	ArrayList<Question> questionList = qDao.selectQuestion(product.getProductNo(), questionBeginRow, questionRowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=product.getProductName()%></title>
<jsp:include page="/inc/link.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		const urlParams  = new URL(location.href).searchParams;
		const msg = urlParams.get('msg');
		if(msg != null){
			alert(msg);
		}
		
		$('#addQuestionBtn').click(function(){
			if($('#questionTitle').val() == ''){
				alert('문의 제목을 작성해주세요');
			}else if($('#questionCategory').val() == ''){
				alert('카테고리를 선택해주세요');
			}else if($('#questionContent').val() == ''){
				alert('문의 내용을 작성해주세요');
			}else {
				$('#addQuestion').submit();
			}
		});
	});
</script>
</head>
<body>
	<%
		// 사원이 로그인 중일 때 사원용 헤더 표시
		if(session.getAttribute("loginId") instanceof Employees) {
	%>
			<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
			<jsp:include page="/inc/sidebar.jsp"></jsp:include>

	<%	
		// 아니면 고객용 헤더 표시
		} else {
	%>
			<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
			<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>
	<%		
		}
	%>
	
	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			
			<a href="<%=request.getContextPath()%>/product/productList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Shop
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=<%=product.getCategoryMainname()%>" class="stext-109 cl8 hov-cl1 trans-04">
				<%=product.getCategoryMainname()%>
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			
			<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=<%=product.getCategorySubname()%>&subCategory=<%=product.getCategorySubname()%>" class="stext-109 cl8 hov-cl1 trans-04">
				<%=product.getCategorySubname()%>
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				<%=product.getProductName()%>
			</span>
		</div>
	</div>
		

	<!-- Product Detail -->
	
	<section class="sec-product-detail bg0 p-t-65 p-b-60">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-lg-7 p-b-30">
					<div class="p-l-25 p-r-30 p-lr-0-lg">
						<div class="wrap-slick3 flex-sb flex-w">
							<div class="wrap-slick3"></div>
							<div class="slick3 gallery-lb">
								<div class="item-slick3" data-thumb="<%=request.getContextPath()%>/pimg/<%=pDao.selectProductImg(product.getProductNo()).getProductSaveFilename()%>">
									<div class="wrap-pic-w pos-relative">
										<img src="<%=request.getContextPath()%>/pimg/<%=pDao.selectProductImg(product.getProductNo()).getProductSaveFilename()%>" alt="IMG-PRODUCT">
										<a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="<%=request.getContextPath()%>/pimg/<%=pDao.selectProductImg(product.getProductNo()).getProductSaveFilename()%>">
											<i class="fa fa-expand"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
					
				<div class="col-md-6 col-lg-5 p-b-30">
					<div class="p-r-50 p-t-5 p-lr-0-lg">
						<h4 class="mtext-105 cl2 js-name-detail p-b-14">
							<%=product.getProductName()%>
						</h4>
<%
						if(product.getDiscountRate() == 0) {
%>
							<span class="mtext-106 cl2">
								<%=product.getProductPrice()%>원
							</span>
<%	
						} else {
%>
							<span class="mtext-106 cl2">
								<span style="font-size: 20px; color: red;">
									<%=(int)(product.getDiscountRate() * 100)%>%&nbsp;
								</span>
								<span class="stext-105 cl7" style="text-decoration:line-through"><%=product.getProductPrice()%>원</span>	
								<%=product.getProductDiscountPrice()%>원
							</span>
<%								
						}
%>
					
						
				
						
						<p class="stext-102 cl3 p-t-23">
							<%=product.getProductName()%>
						</p>
						
						<!--  -->
						<div class="p-t-33">
							<br>
							<br>
							<form action="" method="post" id="product">
								<input type="hidden" name="productNo" value="<%=product.getProductNo()%>">
								<input type="hidden" name="productImg" value="<%=pDao.selectProductImg(product.getProductNo()).getProductSaveFilename()%>">
								<input type="hidden" name="productName" value="<%=product.getProductName()%>">
								<input type="hidden" name="productPrice" value="<%=product.getProductDiscountPrice()%>">
								<div class="flex-w flex-r-m p-b-10">
									<%
										// 사원이 로그인 중일 때 사원용 헤더 표시
										if(session.getAttribute("loginId") instanceof Employees) {
									%>
											<div class="size-204 flex-w respon6-next">
												<button class="flex-c-m stext-101 m-r-20 cl0 size-101 bg1 bor1 hov-btn1 m-tb-10 p-lr-15 trans-04 js-addcart-detail" onclick="$('#product').attr('action','<%=request.getContextPath()%>/product/modifyProduct.jsp').submit();">
														상품 정보 수정
												</button>
											</div>
											<div class="size-204 flex-w respon6-next">
												<button class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 m-tb-10 trans-04 js-addcart-detail" onclick="$('#product').attr('action','<%=request.getContextPath()%>/product/removeProductAction.jsp').submit();">
														상품 삭제
												</button>
											</div>
									<%	
										// 아니면 고객용 헤더 표시
										} else {
									%>
											<div class="size-204 flex-w flex-m respon6-next">
												<div class="wrap-num-product flex-w m-l-10 m-tb-10">
													<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
														<i class="fs-16 zmdi zmdi-minus"></i>
													</div>
			
													<input class="mtext-104 cl3 txt-center num-product" type="number" name="cnt" value="1">
			
													<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
														<i class="fs-16 zmdi zmdi-plus"></i>
													</div>
												</div>
											</div>
											
											<div class="size-204 flex-w respon6-next">
												<button class="flex-c-m stext-101 m-r-20 cl0 size-101 bg1 bor1 hov-btn1 m-tb-10 p-lr-15 trans-04 js-addcart-detail" onclick="$('#product').attr('action','<%=request.getContextPath()%>/order/addCartAction.jsp').submit();">
														장바구니 담기
												</button>
											</div>
											<div class="size-204 flex-w respon6-next">
												<button class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 m-tb-10 trans-04 js-addcart-detail" onclick="$('#product').attr('action','<%=request.getContextPath()%>/order/addOrderProduct.jsp').submit();">
														바로구매
												</button>
											</div>
									<%		
										}
									%>
								</div>	
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div class="bor10 m-t-50 p-t-43 p-b-40">
				<!-- Tab01 -->
				<div class="tab01">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item p-b-10">
							<a class="nav-link active" data-toggle="tab" href="#information" role="tab">상품정보</a>
						</li>

						<li class="nav-item p-b-10">
							<a class="nav-link" data-toggle="tab" href="#reviews" role="tab">구매후기</a>
						</li>
						
						<li class="nav-item p-b-10">
							<a class="nav-link" data-toggle="tab" href="#questions" role="tab">상품문의</a>
						</li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content p-t-43">
						<!-- - -->
						<div class="tab-pane fade show active" id="information" role="tabpanel">
							<div class="row">
								<div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
									<ul class="p-lr-28 p-lr-15-sm">
									<% 
										String[] info = product.getProductInfo().split("[|] ");
										for(int i=0; i<info.length; i+=1){
											if(i%2 == 0) {
									%>
											<li class="flex-w flex-t p-b-7">
												<span class="stext-102 cl3 size-205">
													<%=info[i] %>
												</span>
									<%			
											} else {
									%>
												<span class="stext-102 cl6 size-206">
													<%=info[i] %>
												</span>
											</li>
									<%			
											}
										}
									%>
									</ul>
								</div>
							</div>
						</div>

						<!-- - -->
						<div class="tab-pane fade" id="reviews" role="tabpanel">
							<div class="row">
								<div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
									<div class="p-b-30 m-lr-15-sm">
										<!-- Review -->
										<%
											for(HashMap<String, Object> r : reviewList) {
												int reviewNo = (Integer) r.get("reviewNo");
										%>
												<div class="flex-w flex-t p-b-10 bor12">
													<div class="wrap-pic-s size-208">
														<img src="<%=request.getContextPath()%>/rimg/<%=rDao.selectReviewImgSaveFilename(reviewNo) %>" alt="AVATAR">
													</div>
		
													<div class="size-209">
														<div class="flex-w flex-sb-m p-b-17">
															<span class="mtext-107 cl2 p-r-20">
																<%=r.get("id") %>
															</span>
															
															<span class="stext-102 cl6">
																<%=((String)r.get("createdate")).substring(0, 16) %>
															</span>
														</div>
														
														<div class="flex-w flex-sb-m p-b-17">
															<span class="mtext-107 cl2 p-r-20">
																<%=r.get("reviewTitle") %>
															</span>					
														</div>
		
														<p class="stext-102 cl6">
															<%=r.get("reviewContent") %>
														</p>
													</div>
												</div>
										<%		
											}
										%>
										
										
										<!-- Pagination -->
										<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
										<%
											// 페이징 수
											int reviewPagePerPage = 5;
											// 최소 페이지
											int reviewMinPage = ((questionCurrentPage-1) / reviewPagePerPage) * reviewPagePerPage + 1;
											// 최대 페이지
											int reviewMaxPage = reviewMinPage + reviewPagePerPage - 1;
											// 최대 페이지가 마지막 페이지 보다 크면 최대 페이지 = 마지막 페이지
											if(reviewMaxPage > reviewLastPage) {
												reviewMaxPage = reviewLastPage;
											}
											// 이전 페이지
											// 최소 페이지가 1보타 클 경우 이전 페이지 표시
											//이전 페이지 버튼
											if(reviewMinPage >1){
										%>
									 				<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&reviewCurrentPage=<%=reviewMinPage-reviewPagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
									 					이전 
									 				</a>
									   	<%
											}
									        for(int i = reviewMinPage; i <= reviewMaxPage; i++){
									        	if(i == reviewCurrentPage){
									    %>
									    			<a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
									       				<%=i %>
									       			</a>
									    <%
									        	}else{
									   	%>
									       			<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&reviewCurrentPage=<%=i %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
									       				<%=i %>
									       			</a>
									    <%
									       		}
									        }
									    	//다음 페이지 버튼
									    	if(reviewMaxPage != reviewLastPage){
									    %>
												<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&reviewCurrentPage=<%=reviewMinPage+reviewPagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
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
						
						<!-- - -->
						<div class="tab-pane fade" id="questions" role="tabpanel">
							<div class="row">
								<div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
									<div class="p-b-30 m-lr-15-sm">
									<%
										if(session.getAttribute("loginId") instanceof Customer){
											Customer c = (Customer)session.getAttribute("loginId");
											
									%>
											<!-- 상품 문의 추가 -->
											<form action="<%=request.getContextPath()%>/qna/addQuestionAction.jsp" method="post" class="w-full bor12" id="addQuestion">
												<div class="row p-b-25">
													<div class="col-sm-6 p-b-5">
														<input type="hidden" name="productNo" value="<%=productNo%>">
														<span class="mtext-108 cl2 p-b-7"><%=c.getId() %></span>
														<input class="size-111 bor8 stext-102 cl2 p-lr-20" id="questionTitle" type="text" name="questionTitle" placeholder="문의 제목">
													</div>
													<div class="col-sm-6 p-b-5">
														<div class="p-b-25"></div>
														<div class="rs1-select2 rs2-select2 bor8 bg0">
															<select class="js-select2" id="questionCategory" name="questionCategory">
																<option value="">===문의 카테고리===</option>
																<option value="상품">상품</option>
																<option value="'교환/환불">교환/환불</option>
																<option value="배송">배송</option>
																<option value="기타">기타</option>
															</select>
															<div class="dropDownSelect2"></div>
														</div>
													</div>
													
													<div class="col-12 p-b-5">
														<textarea class="size-110 bor8 stext-102 cl2 p-lr-20 p-tb-10" id="questionContent" name="questionContent" placeholder="문의 내용"></textarea>
													</div>
												</div>
	
												<button id="addQuestionBtn" class="flex-c-m stext-101 cl0 size-112 bg7 bor11 hov-btn3 p-lr-15 trans-04 m-b-10">
													문의하기
												</button>
											</form>	
									<%		
										} 
									%>
										
											<%
												for(Question q : questionList) {
													Answer answer = aDao.selectAnswerOne(q.getqNo());
											%>
											<!-- 상품 문의 내역 -->
											<div class="flex-w flex-t p-b-5 p-t-20 bor12">
													<div class="size-109 flex-w flex-sb-m p-b-7">
														<span class="stext-109 cl11 p-r-10">
																<%=q.getqStatus()%>
														</span>
													</div>
		
													<div class="size-207">
														<div class="flex-w flex-sb-m p-b-7">
															<span class="mtext-107 cl2 p-r-20">
																<%=q.getId()%>
															</span>
															<span class="stext-102 cl6">
																<%=q.getCreatedate().substring(0, 16) %>
															</span>
														</div>
														<div class="flex-w flex-sb-m p-b-7">
															<span class="mtext-107 cl2 p-r-20">
																<%=q.getqTitle() %>
															</span>
														</div>
														<p class="stext-102 cl6 p-b-7">
															<%=q.getqContent() %>
														</p>
													</div>
											<%
													if(answer != null){
											%>
													<div class="size-109 flex-w flex-sb-m p-b-7">
														<span class="stext-109 cl11 p-r-10">
															답변내용	
														</span>
													</div>
		
													<div class="size-207">
														<div class="flex-w flex-sb-m p-b-7">
															<span class="mtext-107 cl2 p-r-20">
																관리자
															</span>
														</div>
														<p class="stext-102 cl6 p-b-7">
															<%=answer.getaContent() %>
														</p>
													</div>
												
											<%		
													}
											%>
												</div>
											<%
												}
											%>
										
										<!-- Pagination -->
										<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
										<%
											// 페이징 수
											int questionPagePerPage = 5;
											// 최소 페이지
											int questionMinPage = ((questionCurrentPage-1) / questionPagePerPage) * questionPagePerPage + 1;
											// 최대 페이지
											int questionMaxPage = questionMinPage + questionPagePerPage - 1;
											// 최대 페이지가 마지막 페이지 보다 크면 최대 페이지 = 마지막 페이지
											if(questionMaxPage > questionLastPage) {
												questionMaxPage = questionLastPage;
											}
											// 이전 페이지
											// 최소 페이지가 1보타 클 경우 이전 페이지 표시
											//이전 페이지 버튼
											if(questionMinPage >1){
										%>
									 				<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&questionCurrentPage=<%=questionMinPage-questionPagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
									 					이전 
									 				</a>
									   	<%
											}
									        for(int i = questionMinPage; i <= questionMaxPage; i++){
									        	if(i == questionCurrentPage){
									    %>
									    			<a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
									       				<%=i %>
									       			</a>
									    <%
									        	}else{
									   	%>
									       			<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&questionCurrentPage=<%=i %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
									       				<%=i %>
									       			</a>
									    <%
									       		}
									        }
									    	//다음 페이지 버튼
									    	if(questionMaxPage != questionLastPage){
									    %>
												<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=productNo%>&questionCurrentPage=<%=questionMinPage+questionPagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
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
					</div>
				</div>
			</div>
		</div>
	</section>
<jsp:include page="/inc/footer.jsp"></jsp:include>
<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>