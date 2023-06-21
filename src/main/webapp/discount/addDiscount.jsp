<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 추가</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form class="w-full" action="<%=request.getContextPath()%>/discount/addDiscountAction.jsp" method="post">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						할인 상품 추가
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
					
					<!-- 할인 상품 추가 폼 -->
					<div class="row p-b-25">
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								상품 번호
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="productNo"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								할인 시작일
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="date" name="discountStart"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								할인 종료일
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="date" name="discountEnd"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								할인율 
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="discountRate"> 
							</span>
						</div>
					</div>
					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/discount/discountList.jsp" style="color: #333333" class="cen">
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