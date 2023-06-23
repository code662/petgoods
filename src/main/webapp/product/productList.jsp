<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 시작 번호
	int beginRow = 0;
	// 페이지 당 상품 개수
	int rowPerPage = 16;
	// 카테고리 변수
	String mainCategory = "전체";
	String subCategory = "전체";
	
	// 유효성 검사 
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	if(request.getParameter("mainCategory") != null) {
		mainCategory = request.getParameter("mainCategory");
	}
	
	if(request.getParameter("subCategory") != null) {
		subCategory = request.getParameter("subCategory");
	}
	
	// Dao 객체 생성
	CategoryDao cDao = new CategoryDao();
	ProductDao pDao = new ProductDao();
	DiscountDao dDao = new DiscountDao();
	// 상품 개수
	int productCnt = pDao.productCnt(mainCategory, subCategory);
	// 카테고리 리스트
	ArrayList<Category> categoryMainList = cDao.selectMainCategory();
	// 상품 리스트
	ArrayList<Product> productList = pDao.selectProductList(beginRow, rowPerPage, mainCategory, subCategory);
	
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
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
	
	<!-- Product -->
	<div class="bg0 m-t-23 p-b-140">
		<div class="container">
			<div class="flex-w flex-sb-m p-b-52">
				<div class="flex-w flex-l-m filter-tope-group m-tb-10">
				<form action="<%=request.getContextPath()%>/product/productList.jsp?rowPerPage=<%=rowPerPage%>" id="전체">
					<input name="mainCategory" type="hidden" value="전체">
					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter="*" onclick="$('#전체').submit()">
						전체
					</button>
				</form>
				<%
					if(mainCategory.equals("전체")){
						for(Category c : categoryMainList) {
				%>
							<form action="<%=request.getContextPath()%>/product/productList.jsp?rowPerPage=<%=rowPerPage%>" id="<%=c.getCategoryMainName()%>">
								<input name="mainCategory" type="hidden" value="<%=c.getCategoryMainName()%>">
								<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".<%=c.getCategoryMainName()%>" onclick="$('<%=c.getCategoryMainName()%>').submit()">
									<%=c.getCategoryMainName()%>
								</button>
							</form>
				<%		
						}		
					} else {
						ArrayList<Category> categorySubList = cDao.selectSubCategory(mainCategory);
						for(Category c : categorySubList) {
				%>
							<form action="<%=request.getContextPath()%>/product/productList.jsp?rowPerPage=<%=rowPerPage%>">
								<input name="mainCategory" type="hidden" value="<%=mainCategory%>">
								<input name="subCategory" type="hidden" value="<%=c.getCategorySubName()%>">
								<button id="<%=c.getCategorySubName()%>" class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".<%=c.getCategorySubName()%>" onclick="$('<%=c.getCategorySubName()%>').submit()">
									<%=c.getCategorySubName()%>
								</button>
							</form>
				<%		
						}
					}
				%>	
				</div>
				<div class="flex-w flex-c-m m-tb-10">
					<div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
						<i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
						<i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
						 Filter
					</div>

					<div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
						<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
						<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
						Search
					</div>
					
					
					<%
						// 사원이 로그인 중일 때 사원용 헤더 표시
						if(session.getAttribute("loginId") instanceof Employees) {
					%>
							<a href="<%=request.getContextPath()%>/product/addProduct.jsp" class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 m-l-8">
								<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-plus"></i>
								상품추가
							</a>
					<%	
						}
					%>
					
				</div>
				
				<!-- Search product -->
				<div class="dis-none panel-search w-full p-t-10 p-b-15">
					<div class="bor8 dis-flex p-l-15">
						<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
							<i class="zmdi zmdi-search"></i>
						</button>

						<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="search-product" placeholder="Search">
					</div>	
				</div>

				<!-- Filter -->
				<div class="dis-none panel-filter w-full p-t-10">
					<div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
						<div class="filter-col1 p-r-15 p-b-27">
							<div class="mtext-102 cl2 p-b-15">
								Sort By
							</div>

							<ul>
								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										Default
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										Popularity
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										Average rating
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04 filter-link-active">
										Newness
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										Price: Low to High
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										Price: High to Low
									</a>
								</li>
							</ul>
						</div>

						<div class="filter-col2 p-r-15 p-b-27">
							<div class="mtext-102 cl2 p-b-15">
								Price
							</div>

							<ul>
								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04 filter-link-active">
										All
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										$0.00 - $50.00
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										$50.00 - $100.00
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										$100.00 - $150.00
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										$150.00 - $200.00
									</a>
								</li>

								<li class="p-b-6">
									<a href="#" class="filter-link stext-106 trans-04">
										$200.00+
									</a>
								</li>
							</ul>
						</div>

						<div class="filter-col3 p-r-15 p-b-27">
							<div class="mtext-102 cl2 p-b-15">
								Color
							</div>

							<ul>
								<li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #222;">
										<i class="zmdi zmdi-circle"></i>
									</span>

									<a href="#" class="filter-link stext-106 trans-04">
										Black
									</a>
								</li>

								<li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #4272d7;">
										<i class="zmdi zmdi-circle"></i>
									</span>

									<a href="#" class="filter-link stext-106 trans-04 filter-link-active">
										Blue
									</a>
								</li>

								<li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #b3b3b3;">
										<i class="zmdi zmdi-circle"></i>
									</span>

									<a href="#" class="filter-link stext-106 trans-04">
										Grey
									</a>
								</li>

								<li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #00ad5f;">
										<i class="zmdi zmdi-circle"></i>
									</span>

									<a href="#" class="filter-link stext-106 trans-04">
										Green
									</a>
								</li>

								<li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #fa4251;">
										<i class="zmdi zmdi-circle"></i>
									</span>

									<a href="#" class="filter-link stext-106 trans-04">
										Red
									</a>
								</li>

								<li class="p-b-6">
									<span class="fs-15 lh-12 m-r-6" style="color: #aaa;">
										<i class="zmdi zmdi-circle-o"></i>
									</span>

									<a href="#" class="filter-link stext-106 trans-04">
										White
									</a>
								</li>
							</ul>
						</div>

						<div class="filter-col4 p-b-27">
							<div class="mtext-102 cl2 p-b-15">
								Tags
							</div>

							<div class="flex-w p-t-4 m-r--5">
								<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
									Fashion
								</a>

								<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
									Lifestyle
								</a>

								<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
									Denim
								</a>

								<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
									Streetstyle
								</a>

								<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
									Crafts
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row isotope-grid">
			<%
				for(Product p : productList){
					if(session.getAttribute("loginId") instanceof Employees) {
			%>
						<div id="p<%=p.getProductNo()%>" class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item <%=cDao.selectCategoryOne(p.getCategoryNo()).getCategoryMainName()%> <%=cDao.selectCategoryOne(p.getCategoryNo()).getCategorySubName()%>">
							<!-- Block2 -->
							<div class="block2">
								<div class="block2-pic hov-img0">
			<%
								if(p.getProductStatus().equals("품절")){
			%>
									<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6" style="filter: grayscale(100%);">
										<img src="<%=request.getContextPath()%>/pimg/<%=pDao.selectProductImg(p.getProductNo()).getProductSaveFilename()%>" alt="IMG-PRODUCT" width="270px" height="270">
									</a>
			<%						
								} else {
			%>
									<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
										<img src="<%=request.getContextPath()%>/pimg/<%=pDao.selectProductImg(p.getProductNo()).getProductSaveFilename()%>" alt="IMG-PRODUCT" width="270px" height="270">
									</a>
			<%						
								}
			%>
								</div>

								<div class="block2-txt flex-w flex-t p-t-14">
			<%
											Discount discount = dDao.selectDiscountOneNow(p.getProductNo());
											if(discount == null) {
			%>
												<div class="block2-txt-child1 flex-col-l">
													<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														<%=p.getProductName()%>
													</a>
													
													<span class="stext-105 cl3">
														<%=p.getProductPrice()%>원
													</span>
												</div>
			<%		
											} else {
			%>
												<div class="block2-txt-child1 flex-col-l label1" data-label1="할인">
													<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														<%=p.getProductName()%>
													</a>
													
													
													<span class="stext-105 cl3">
														<span class="stext-109 cl7" style="text-decoration:line-through">
															<%=p.getProductPrice()%>원
														</span>	
														 &nbsp;&nbsp;<%=(int)(p.getProductPrice() * (1-discount.getDiscountRate()))%>원
													</span>	
												</div>
			<%		
											}
			%>
								</div>
							</div>
						</div>
			<%			
					} else {
						if(p.getProductStatus().equals("판매중")){
			%>
							<div id="p<%=p.getProductNo()%>" class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item <%=cDao.selectCategoryOne(p.getCategoryNo()).getCategoryMainName()%> <%=cDao.selectCategoryOne(p.getCategoryNo()).getCategorySubName()%>">
								<!-- Block2 -->
								<div class="block2">
									<div class="block2-pic hov-img0">
										<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
											<img src="<%=request.getContextPath()%>/pimg/<%=pDao.selectProductImg(p.getProductNo()).getProductSaveFilename()%>" alt="IMG-PRODUCT" width="270px" height="270">
										</a>
									</div>

									<div class="block2-txt flex-w flex-t p-t-14">
			<%
												Discount discount = dDao.selectDiscountOneNow(p.getProductNo());
												if(discount == null) {
			%>
													<div class="block2-txt-child1 flex-col-l">
														<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
															<%=p.getProductName()%>
														</a>
														
														<span class="stext-105 cl3">
															<%=p.getProductPrice()%>원
														</span>
													</div>
			<%		
												} else {
			%>
													<div class="block2-txt-child1 flex-col-l label1" data-label1="할인">
														<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
															<%=p.getProductName()%>
														</a>
														
														
														<span class="stext-105 cl3">
															<span style="font-size: 15px; color: red;">
																<%=(int)(discount.getDiscountRate() * 100)%>%
															</span>
															<span class="stext-109 cl7" style="text-decoration:line-through"><%=p.getProductPrice()%>원</span>	
															<%=(int)(p.getProductPrice() * discount.getDiscountRate())%>원
														</span>	
													</div>
			<%		
												}
			%>
									</div>
								</div>
							</div>
			<%		
						}			
					}
				}
			%>
			</div>
				<!-- Load more -->
				<div class="flex-c-m flex-w w-full p-t-45" id="loadMore">
			<%
				if (rowPerPage < productCnt) {
			%>
					<a href="<%=request.getContextPath()%>/product/productList.jsp?rowPerPage=<%=rowPerPage+8%>&mainCategory=<%=mainCategory%>&subCategory=<%=subCategory%>&loadMore=true" class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04" onclick="$('html, body').animate({scrollTop: $('#loadMore').offset().top}, 500)">
						Load More
					</a>
			<%		
				}
			%>
				</div>
			<%
				if(request.getParameter("loadMore") != null) {
			%> 
					<script>
						const scrollTop = $('#p<%=rowPerPage-8%>').offset().top-100;
						$('html, body').animate({ scrollTop: scrollTop }, 800);
					</script>
			<%		
				}
			%>
		</div>
	</div>
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
	<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>