<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%

// Dao 객체 생성
ProductDao pDao = new ProductDao();
// 상품 리스트
ArrayList<Product> productList = pDao.selectProductList(0, 8, "전체", "전체");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
	<%
		// 사원이 로그인 중일 때 사원용 헤더 표시
		if(session.getAttribute("loginId") instanceof Employees) {
	%>
			<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
	<%	
		// 아니면 고객용 헤더 표시
		} else {
			%>
			<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
	<%		
		}
	%>
	<jsp:include page="/inc/sidebar.jsp"></jsp:include>
	<jsp:include page="/inc/cart.jsp"></jsp:include>
	
	<!-- Slider -->
	<section class="section-slide">
		<div class="wrap-slick1 rs1-slick1">
			<div class="slick1">
				<div class="item-slick1" style="background-image: url(<%=request.getContextPath()%>/img/slide01.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30">
							<div class="layer-slick1 animated visible-false" data-appear="fadeInDown" data-delay="0">
								<span class="ltext-202 cl2 respon2">
									Pet Food 2023
								</span>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="800">
								<h2 class="ltext-104 cl2 p-t-19 p-b-43 respon1">
									New arrivals
								</h2>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="zoomIn" data-delay="1600">
								<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="item-slick1" style="background-image: url(<%=request.getContextPath()%>/img/slide02.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30">
							<div class="layer-slick1 animated visible-false" data-appear="rollIn" data-delay="0">
								<span class="ltext-202 cl5 respon2">
									Pet Treats 2023
								</span>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="lightSpeedIn" data-delay="800">
								<h2 class="ltext-104 cl5 p-t-19 p-b-43 respon1">
									New arrivals
								</h2>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="slideInUp" data-delay="1600">
								<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="item-slick1" style="background-image: url(<%=request.getContextPath()%>/img/slide03.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30">
							<div class="layer-slick1 animated visible-false" data-appear="rotateInDownLeft" data-delay="0">
								<span class="ltext-202 cl0 respon2">
									Pet Goods 2023
								</span>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="rotateInUpRight" data-delay="800">
								<h2 class="ltext-104 cl0 p-t-19 p-b-43 respon1">
									New arrivals
								</h2>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="rotateIn" data-delay="1600">
								<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품
								" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<!-- Banner -->
	<div class="sec-banner bg0">
		<div class="flex-w flex-c-m">
			<div class="size-202 m-lr-auto respon4">
				<!-- Block1 -->
				<div class="block1 wrap-pic-w">
					<img src="<%=request.getContextPath()%>/img/banner01.jpg" alt="IMG-BANNER">

					<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료" class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
						<div class="block1-txt-child1 flex-col-l">
							<span class="block1-name ltext-102 trans-04 p-b-8">
								Food
							</span>

							<span class="block1-info stext-102 trans-04">
								New Trend
							</span>
						</div>

						<div class="block1-txt-child2 p-b-4 trans-05">
							<div class="block1-link stext-101 cl0 trans-09">
								Shop Now
							</div>
						</div>
					</a>
				</div>
			</div>

			<div class="size-202 m-lr-auto respon4">
				<!-- Block1 -->
				<div class="block1 wrap-pic-w">
					<img src="<%=request.getContextPath()%>/img/banner02.jpg" alt="IMG-BANNER">

					<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식" class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
						<div class="block1-txt-child1 flex-col-l">
							<span class="block1-name ltext-102 trans-04 p-b-8">
								Treats
							</span>

							<span class="block1-info stext-102 trans-04">
								New Trend
							</span>
						</div>

						<div class="block1-txt-child2 p-b-4 trans-05">
							<div class="block1-link stext-101 cl0 trans-09">
								Shop Now
							</div>
						</div>
					</a>
				</div>
			</div>

			<div class="size-202 m-lr-auto respon4">
				<!-- Block1 -->
				<div class="block1 wrap-pic-w">
					<img src="<%=request.getContextPath()%>/img/banner03.jpg" alt="IMG-BANNER">

					<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품" class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
						<div class="block1-txt-child1 flex-col-l">
							<span class="block1-name ltext-102 trans-04 p-b-8">
								Goods
							</span>

							<span class="block1-info stext-102 trans-04">
								New Trend
							</span>
						</div>

						<div class="block1-txt-child2 p-b-4 trans-05">
							<div class="block1-link stext-101 cl0 trans-09">
								Shop Now
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>


	<!-- Product -->
	<section class="sec-product bg0 p-t-100 p-b-50">
		<div class="container">
			<div class="p-b-32">
				<h3 class="ltext-105 cl5 txt-center respon1">
					Store Overview
				</h3>
			</div>

			<!-- Tab01 -->
			<div class="tab01">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item p-b-10">
						<a class="nav-link active" data-toggle="tab" href="#best-seller" role="tab">Best Seller</a>
					</li>

					<li class="nav-item p-b-10">
						<a class="nav-link" data-toggle="tab" href="#featured" role="tab">Featured</a>
					</li>

					<li class="nav-item p-b-10">
						<a class="nav-link" data-toggle="tab" href="#sale" role="tab">Sale</a>
					</li>

					<li class="nav-item p-b-10">
						<a class="nav-link" data-toggle="tab" href="#top-rate" role="tab">Top Rate</a>
					</li>
				</ul>

				<!-- Tab panes -->
				<div class="tab-content p-t-50">
					<!-- - -->
					<div class="tab-pane fade show active" id="best-seller" role="tabpanel">
						<!-- Slide2 -->
						<div class="wrap-slick2">
							<div class="slick2">
							<%
								for(Product p : productList) {
							%>
									<div class="item-slick2 p-l-15 p-r-15 p-t-15 p-b-15">
										<!-- Block2 -->
										<div class="block2">
											<div class="block2-pic hov-img0">
												<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
													<img src="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(p.getProductNo())%>" alt="IMG-PRODUCT">
												</a>
											</div>
	
											<div class="block2-txt flex-w flex-t p-t-14">
												<div class="block2-txt-child1 flex-col-l ">
													<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														<%=p.getProductName()%>
													</a>
	
													<span class="stext-105 cl3">
														<%=p.getProductPrice()%>원
													</span>
												</div>
											</div>
										</div>
									</div>
							<%		
								}
							%>
							</div>
						</div>
					</div>

					<!-- - -->
					<div class="tab-pane fade" id="featured" role="tabpanel">
						<!-- Slide2 -->
						<div class="wrap-slick2">
							<div class="slick2">
								<%
									for(Product p : productList) {
								%>
										<div class="item-slick2 p-l-15 p-r-15 p-t-15 p-b-15">
											<!-- Block2 -->
											<div class="block2">
												<div class="block2-pic hov-img0">
													<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														<img src="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(p.getProductNo())%>" alt="IMG-PRODUCT">
													</a>
												</div>
		
												<div class="block2-txt flex-w flex-t p-t-14">
													<div class="block2-txt-child1 flex-col-l ">
														<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
															<%=p.getProductName()%>
														</a>
		
														<span class="stext-105 cl3">
															<%=p.getProductPrice()%>원
														</span>
													</div>
												</div>
											</div>
										</div>
								<%		
									}
								%>
							</div>
						</div>
					</div>

					<!-- - -->
					<div class="tab-pane fade" id="sale" role="tabpanel">
						<!-- Slide2 -->
						<div class="wrap-slick2">
							<div class="slick2">
								<%
									for(Product p : productList) {
								%>
										<div class="item-slick2 p-l-15 p-r-15 p-t-15 p-b-15">
											<!-- Block2 -->
											<div class="block2">
												<div class="block2-pic hov-img0">
													<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														<img src="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(p.getProductNo())%>" alt="IMG-PRODUCT">
													</a>
												</div>
		
												<div class="block2-txt flex-w flex-t p-t-14">
													<div class="block2-txt-child1 flex-col-l ">
														<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
															<%=p.getProductName()%>
														</a>
		
														<span class="stext-105 cl3">
															<%=p.getProductPrice()%>원
														</span>
													</div>
												</div>
											</div>
										</div>
								<%		
									}
								%>
							</div>
						</div>
					</div>
					<!-- - -->
					<div class="tab-pane fade" id="top-rate" role="tabpanel">
						<!-- Slide2 -->
						<div class="wrap-slick2">
							<div class="slick2">
								<%
									for(Product p : productList) {
								%>
										<div class="item-slick2 p-l-15 p-r-15 p-t-15 p-b-15">
											<!-- Block2 -->
											<div class="block2">
												<div class="block2-pic hov-img0">
													<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														<img src="<%=request.getContextPath()%>/pimg/<%=pDao.productImgName(p.getProductNo())%>" alt="IMG-PRODUCT">
													</a>
												</div>
		
												<div class="block2-txt flex-w flex-t p-t-14">
													<div class="block2-txt-child1 flex-col-l ">
														<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
															<%=p.getProductName()%>
														</a>
		
														<span class="stext-105 cl3">
															<%=p.getProductPrice()%>원
														</span>
													</div>
												</div>
											</div>
										</div>
								<%		
									}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
	<jsp:include page="/inc/quickView.jsp"></jsp:include>
	<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>