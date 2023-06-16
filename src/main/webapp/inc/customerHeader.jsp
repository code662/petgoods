<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 고객용 헤더 -->
<header class="header-v2">
	<!-- Header 데스크탑(전체화면) -->
	<div class="container-menu-desktop trans-03">
		<div class="wrap-menu-desktop">
			<nav class="limiter-menu-desktop p-l-45">
				
				<!-- 로고 데스크탑 -->		
				<a href="<%=request.getContextPath()%>/home.jsp" class="logo">
					<img src="<%=request.getContextPath()%>/img/logo.png" alt="IMG-LOGO">
				</a>

				<!-- 메뉴 데스크탑 -->
				<div class="menu-desktop">
					<ul class="main-menu">
						<li>
							<a href="<%=request.getContextPath()%>/home.jsp">Home</a>
						</li>

						<li class="label1" data-label1="hot">
							<a href="<%=request.getContextPath()%>/product/productList.jsp">Shop</a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/order/cartList.jsp">Cart</a>
						</li>
						
						<li>
							<a href="<%=request.getContextPath()%>/about.jsp">About</a>
						</li>
					</ul>
				</div>	

				<!-- 메뉴 옆 아이콘 -->
				<div class="wrap-icon-header flex-w flex-r-m h-full">
					<!-- 카트 아이콘 -->	
					<div class="flex-c-m h-full p-l-18 p-r-25">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 icon-header-noti js-show-cart" data-notify="2">
							<i class="zmdi zmdi-shopping-cart"></i>
						</div>
					</div>
					<!-- 사이드바 아이콘 -->	
					<div class="flex-c-m h-full p-lr-19">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 js-show-sidebar">
							<i class="zmdi zmdi-menu"></i>
						</div>
					</div>
				</div>
			</nav>
		</div>	
	</div>

	<!-- Header 모바일(브라우저 화면 줄였을 때) -->
	<div class="wrap-header-mobile">
		<!-- 로고 모바일 -->		
		<div class="logo-mobile">
			<a href="<%=request.getContextPath()%>/home.jsp"><img src="<%=request.getContextPath()%>/img/logo.png" alt="IMG-LOGO"></a>
		</div>

		<!-- 아이콘 -->
		<div class="wrap-icon-header flex-w flex-r-m h-full m-r-15">
			<!-- 카트 아이콘 -->
			<div class="flex-c-m h-full p-lr-10">
				<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 icon-header-noti js-show-cart" data-notify="2">
					<i class="zmdi zmdi-shopping-cart"></i>
				</div>
			</div>
		</div>

		<!-- 메뉴 버튼 -->
		<div class="btn-show-menu-mobile hamburger hamburger--squeeze">
			<span class="hamburger-box">
				<span class="hamburger-inner"></span>
			</span>
		</div>
	</div>


	<!-- 메뉴 모바일 -->
	<div class="menu-mobile">
		<ul class="main-menu-m">
			<li>
				<a href="<%=request.getContextPath()%>/home.jsp">Home</a>
			</li>

			<li class="label1" data-label1="hot">
				<a href="<%=request.getContextPath()%>/product/productList.jsp">Shop</a>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/order/cartList.jsp">Cart</a>
			</li>
			
			<li>
				<a href="<%=request.getContextPath()%>/about.jsp">About</a>
			</li>
		</ul>
	</div>
</header>