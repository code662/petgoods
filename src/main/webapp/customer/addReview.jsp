<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";	
	
	// 세션 유효성 검사
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	// 요청값 유효성 검사
	if(request.getParameter("orderNo") == null 
			|| request.getParameter("orderNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myOrderList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println(PURPLE + orderNo + " <--id addReview" + RESET);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰등록</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- 리뷰 등록 -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form class="w-full" action="<%=request.getContextPath()%>/customer/addReviewAction.jsp" method="post" enctype="multipart/form-data">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						리뷰 등록
					</h4>
	
					<p class="stext-102 cl6">
						당신의 소중한 리뷰는 다른 고객들이 좋은 상품을 선택하는데 큰 도움이 됩니다.
					</p>
					<br>
					<div class="row p-b-25">
						<div class="col-sm-3 p-b-5">
							<label class="stext-102 cl3" style="margin-bottom: 0">Order No.</label>
							<input class="size-111 bor8 stext-103 cl2 p-lr-20" type="text" name="orderNo" value="<%=orderNo %>" readonly="readonly" style="border:none; font-size:16px;">
						</div>
						<div class="col-sm-9 p-b-5">
							<label class="stext-102 cl3">File</label>
							<input class="size-111 bor8 stext-102 cl2 p-lr-20" type="file" name="reviewImg" required="required" style="border:none;">
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								Review Title
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="reviewTitle"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<label class="stext-102 cl3">Your review</label>
							<textarea class="size-110 bor8 stext-102 cl2 p-lr-20 p-tb-10" name="reviewContent"></textarea>
						</div>
					</div>
	
					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers cen">
						<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp" style="color: #333333">
							취소
						</a>
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