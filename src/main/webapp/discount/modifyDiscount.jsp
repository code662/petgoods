<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	// 요청값 유효성 검사
	if(request.getParameter("discountNo") == null
			|| request.getParameter("discountNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	// 디버깅
	System.out.println(PURPLE + discountNo + " <--discountNo modifyDiscount" + RESET);
	
	DiscountDao dd = new DiscountDao();
	Discount discount = dd.selectDiscountOne(discountNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 수정</title>
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
			<a href="<%=request.getContextPath()%>/discount/discountList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				discountList
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				modifyDiscount
			</span>
		</div>
	</div>
	
	<section class="bg0 p-t-75 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form class="w-full" action="<%=request.getContextPath()%>/discount/modifyDiscountAction.jsp?discountNo=<%=discountNo %>" method="post">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						할인 상품 수정
					</h4>
					<br>
					
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
					
					<!-- 할인 상품 수정 폼 -->
					<div class="row p-b-25">
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								상품 번호
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="productNo" value="<%=discount.getProductNo()%>"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								할인 시작일
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="date" name="discountStart" value="<%=discount.getDiscountStart().substring(0,10)%>"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								할인 종료일
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="date" name="discountEnd" value="<%=discount.getDiscountEnd().substring(0,10)%>"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								할인율 
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="discountRate" value="<%=(int)Math.floor(discount.getDiscountRate()*100)%>"> 
							</span>
						</div>
					</div>
					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/discount/discountList.jsp" class="cen">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers">
							취소
						</span>
					</a>
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