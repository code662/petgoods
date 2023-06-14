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
	CategoryDao cDao = new CategoryDao();
	Product product = pDao.selectProductOne(productNo);
	Category category = cDao.selectCategoryOne(product.getCategoryNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=product.getProductName()%></title>
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
			
			<a href="<%=request.getContextPath()%>/product/productList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Shop
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=<%=category.getCategoryMainName()%>" class="stext-109 cl8 hov-cl1 trans-04">
				<%=category.getCategoryMainName()%>
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			
			<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=<%=category.getCategoryMainName()%>&subCategory=<%=category.getCategorySubName()%>" class="stext-109 cl8 hov-cl1 trans-04">
				<%=category.getCategorySubName()%>
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
								<div class="item-slick3" data-thumb="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(product.getProductNo())%>">
									<div class="wrap-pic-w pos-relative">
										<img src="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(product.getProductNo())%>" alt="IMG-PRODUCT">
										<a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(product.getProductNo())%>">
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

						<span class="mtext-106 cl2">
							<%=product.getProductPrice()%>원
						</span>

						<p class="stext-102 cl3 p-t-23">
							<%=product.getProductName()%>
						</p>
						
						<!--  -->
						<div class="p-t-33">
							<br>
							<br>
							<div class="flex-w flex-r-m p-b-10">
								<div class="size-204 flex-w flex-m respon6-next">
									<div class="wrap-num-product flex-w m-l-10 m-tb-10">
										<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
											<i class="fs-16 zmdi zmdi-minus"></i>
										</div>

										<input class="mtext-104 cl3 txt-center num-product" type="number" name="num-product" value="1">

										<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
											<i class="fs-16 zmdi zmdi-plus"></i>
										</div>
									</div>
								</div>
								<div class="size-204 flex-w respon6-next">
									<button class="flex-c-m stext-101 m-r-20 cl0 size-101 bg1 bor1 hov-btn1 m-tb-10 p-lr-15 trans-04 js-addcart-detail">
											장바구니 담기
									</button>
								</div>
								<div class="size-204 flex-w respon6-next">
									<button class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 m-tb-10 trans-04 js-addcart-detail">
											바로구매
									</button>
								</div>
							</div>	
						</div>

						<!--  -->
						<div class="flex-w flex-m p-l-100 p-t-40 respon7">
						
							
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
										<div class="flex-w flex-t p-b-68">
											<div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6">
												<img src="images/avatar-01.jpg" alt="AVATAR">
											</div>

											<div class="size-207">
												<div class="flex-w flex-sb-m p-b-17">
													<span class="mtext-107 cl2 p-r-20">
														ID
													</span>
												</div>
												
												<div class="flex-w flex-sb-m p-b-17">
													<span class="mtext-107 cl2 p-r-20">
														리뷰제목
													</span>
													
													<span class="stext-102 cl6">
														작성시간
													</span>
												</div>

												<p class="stext-102 cl6">
													리뷰 내용
												</p>
											</div>
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
										<!-- Add review -->
										<form class="w-full">
											<h5 class="mtext-108 cl2 p-b-7">
												문의하기
											</h5>

											<div class="row p-b-25">
												<div class="col-sm-6 p-b-5">
													<label class="stext-102 cl3" for="name">ID</label>
													<input class="size-111 bor8 stext-102 cl2 p-lr-20" id="name" type="text" name="name">
												</div>

												
												<div class="col-12 p-b-5">
													<label class="stext-102 cl3" for="review">문의 내용</label>
													<textarea class="size-110 bor8 stext-102 cl2 p-lr-20 p-tb-10" id="review" name="review"></textarea>
												</div>
											</div>

											<button class="flex-c-m stext-101 cl0 size-112 bg7 bor11 hov-btn3 p-lr-15 trans-04 m-b-10">
												등록
											</button>
										</form>	
										<!-- Review -->
										<div class="flex-w flex-t p-b-68">
											<div class="size-109 flex-w flex-sb-m p-b-17">
												<span class="mtext-104 cl2 p-r-20">
														답변대기
													</span>
											</div>

											<div class="size-207">
												<div class="flex-w flex-sb-m p-b-17">
													<span class="mtext-107 cl2 p-r-20">
														ID
													</span>
												</div>
												<div class="flex-w flex-sb-m p-b-17">
													<span class="mtext-107 cl2 p-r-20">
														문의 제목
													</span>

													<span class="stext-102 cl6">
														작성 시간
													</span>
												</div>
												<p class="stext-102 cl6">
													 문의 내용
												</p>
											</div>
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