<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Header -->
<header class="header-v2">
	<!-- Header desktop -->
	<div class="container-menu-desktop trans-03">
		<div class="wrap-menu-desktop">
			<nav class="limiter-menu-desktop p-l-45">
				
				<!-- Logo desktop -->		
				<a href="#" class="logo">
					<img src="<%=request.getContextPath()%>/temp/images/icons/logo-01.png" alt="IMG-LOGO">
				</a>

				<!-- Menu desktop -->
				<div class="menu-desktop">
					<ul class="main-menu">
						<li class="active-menu">
							<a href="<%=request.getContextPath()%>/temp/index.html">Home</a>
							<ul class="sub-menu">
								<li><a href="<%=request.getContextPath()%>/temp/index.html">Homepage 1</a></li>
								<li><a href="<%=request.getContextPath()%>/temp/home-02.html">Homepage 2</a></li>
								<li><a href="<%=request.getContextPath()%>/temp/home-03.html">Homepage 3</a></li>
							</ul>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/temp/product.html">Shop</a>
						</li>

						<li class="label1" data-label1="hot">
							<a href="<%=request.getContextPath()%>/temp/shoping-cart.html">Features</a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/temp/blog.html">Blog</a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/temp/about.html">About</a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/temp/contact.html">Contact</a>
						</li>
					</ul>
				</div>	

				<!-- Icon header -->
				<div class="wrap-icon-header flex-w flex-r-m h-full">
					<div class="flex-c-m h-full p-r-24">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 js-show-modal-search">
							<i class="zmdi zmdi-search"></i>
						</div>
					</div>
						
					<div class="flex-c-m h-full p-l-18 p-r-25 bor5">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 icon-header-noti js-show-cart" data-notify="2">
							<i class="zmdi zmdi-shopping-cart"></i>
						</div>
					</div>
						
					<div class="flex-c-m h-full p-lr-19">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 js-show-sidebar">
							<i class="zmdi zmdi-menu"></i>
						</div>
					</div>
				</div>
			</nav>
		</div>	
	</div>

	<!-- Header Mobile -->
	<div class="wrap-header-mobile">
		<!-- Logo moblie -->		
		<div class="logo-mobile">
			<a href="index.html"><img src="<%=request.getContextPath()%>/temp/images/icons/logo-01.png" alt="IMG-LOGO"></a>
		</div>

		<!-- Icon header -->
		<div class="wrap-icon-header flex-w flex-r-m h-full m-r-15">
			<div class="flex-c-m h-full p-r-10">
				<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 js-show-modal-search">
					<i class="zmdi zmdi-search"></i>
				</div>
			</div>

			<div class="flex-c-m h-full p-lr-10 bor5">
				<div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 icon-header-noti js-show-cart" data-notify="2">
					<i class="zmdi zmdi-shopping-cart"></i>
				</div>
			</div>
		</div>

		<!-- Button show menu -->
		<div class="btn-show-menu-mobile hamburger hamburger--squeeze">
			<span class="hamburger-box">
				<span class="hamburger-inner"></span>
			</span>
		</div>
	</div>


	<!-- Menu Mobile -->
	<div class="menu-mobile">
		<ul class="main-menu-m">
			<li>
				<a href="<%=request.getContextPath()%>/temp/index.html">Home</a>
				<ul class="sub-menu-m">
					<li><a href="index.html">Homepage 1</a></li>
					<li><a href="home-02.html">Homepage 2</a></li>
					<li><a href="home-03.html">Homepage 3</a></li>
				</ul>
				<span class="arrow-main-menu-m">
					<i class="fa fa-angle-right" aria-hidden="true"></i>
				</span>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/temp/product.html">Shop</a>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/temp/shoping-cart.html" class="label1 rs1" data-label1="hot">Features</a>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/temp/blog.html">Blog</a>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/temp/about.html">About</a>
			</li>

			<li>
				<a href="<%=request.getContextPath()%>/temp/contact.html">Contact</a>
			</li>
		</ul>
	</div>

	<!-- Modal Search -->
	<div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
		<div class="container-search-header">
			<button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
				<img src="<%=request.getContextPath()%>/temp/images/icons/icon-close2.png" alt="CLOSE">
			</button>

			<form class="wrap-search-header flex-w p-l-15">
				<button class="flex-c-m trans-04">
					<i class="zmdi zmdi-search"></i>
				</button>
				<input class="plh3" type="text" name="search" placeholder="Search...">
			</form>
		</div>
	</div>
</header>