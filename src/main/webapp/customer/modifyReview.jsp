<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";	
	
	// 세션 유효성 검사
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	// 디버깅
	System.out.println(PURPLE + id + " <--id modifyReview" + RESET);
	
	// 요청값 유효성 검사
	if(request.getParameter("reviewNo") == null 
			|| request.getParameter("reviewNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myPage.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	// 디버깅
	System.out.println(PURPLE + reviewNo + " <--reviewNo modifyReview" + RESET);
	
	// 리뷰상세정보 조회
	ReviewDao rd = new ReviewDao();
	Review review = rd.selectReviewOne(reviewNo);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰수정</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<script>
	// 입력폼 유효성 검사
	$(document).ready(function(){
		let extension = $('#productImg').val().substr($('#productImg').val().lastIndexOf(".")+1);
		$('#btn').click(function(){
			if($('#reviewImg').val() == ''){
				alert('리뷰 이미지를 추가해주세요');
			}else if(extension != 'png' && extension != 'jpg' && extension != 'jpeg'){
				alert('이미지 파일을 올려주세요');
			}else if($('#reviewTitle').val() == ''){
				alert('리뷰 제목을 입력해주세요');
			}else if($('#reviewContent').val() == ''){
				alert('리뷰 내용을 입력해주세요');
			}else {
				$('#modifyReview').submit();
			}
		});
	});
</script>
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
			<a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				mypage
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<a href="<%=request.getContextPath()%>/customer/reviewList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				reviewList
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				modifyReview
			</span>
		</div>
	</div>

	<!-- 리뷰 수정 -->
	<section class="bg0 p-t-75 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form class="w-full" action="<%=request.getContextPath()%>/customer/modifyReviewAction.jsp" method="post" enctype="multipart/form-data" id="modifyReview">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						리뷰 수정
					</h4>
					
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
					<!-- 리뷰수정 폼 -->
					<input type="hidden" name="reviewNo" value="<%=review.getReviewNo() %>">
					<p class="stext-102 cl6">
						당신의 소중한 리뷰는 다른 고객들이 좋은 상품을 선택하는데 큰 도움이 됩니다.
					</p>
					<br>
					<div class="row p-b-25">
						<div class="col-sm-3 p-b-5">
							<label class="stext-102 cl3 cen">Order No.</label>
							<input class="size-111 bor8 mtext-107 cl2 p-lr-20" type="text" name="orderNo" value="<%=review.getOrderNo() %>" readonly="readonly" style="border:none;">
						</div>
						<div class="col-sm-9 p-b-5">
							<label class="stext-102 cl3" >File</label>
							<input class="size-111 bor8 stext-102 cl2 p-lr-20" type="file" name="reviewImg" id="reviewImg" accept=".jpeg,.jpg,.png" style="border:none;">
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								Review Title
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 mtext-107 cl2 p-lr-30" type="text" name="reviewTitle" id="reviewTitle" value="<%=review.getReviewTitle() %>"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<label class="stext-102 cl3">Your review</label>
							<textarea class="size-110 bor8 mtext-107 cl2 p-lr-30 p-tb-10" name="reviewContent" id="reviewContent"><%=review.getReviewContent() %></textarea>
						</div>
					</div>
	
					<button id="btn" type="button" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<!-- 이전페이지 버튼 -->
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/customer/reviewList.jsp" class="cen">
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