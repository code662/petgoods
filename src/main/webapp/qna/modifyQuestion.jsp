<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 세션 유효성 검사
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	// 디버깅
	System.out.println(id + " <--id modifyQuestion");
	
	// 요청값 유효성 검사
	if(request.getParameter("questionNo") == null 
			|| request.getParameter("questionNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/qna/myQustionList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	// 디버깅
	System.out.println(questionNo + " <--questionNo modifyQuestion");
	
	// 문의 상세 정보 조회
	QuestionDao qd = new QuestionDao();
	Question question = qd.selectQuestionOne(questionNo);
	
	ProductDao pDao = new ProductDao();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의수정</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
<script>
	// 입력폼 유효성 검사
	$(document).ready(function(){
		$('#btn').click(function(){
			if($('#questionCategory').val() == ''){
				alert('문의 카테고리를 선택해주세요');
			}else if($('#questionTitle').val() == ''){
				alert('문의 제목을 입력해주세요');
			}else if($('#questionContent').val() == ''){
				alert('문의 내용을 입력해주세요');
			}else {
				$('#modifyQuestion').submit();
			}
		});
	});
</script>
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
			<a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				mypage
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<a href="<%=request.getContextPath()%>/customer/reviewList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				QuestionList
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				ModifyQuestion
			</span>
		</div>
	</div>

	<!-- 리뷰 수정 -->
	<section class="bg0 p-t-75 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form class="w-full" action="<%=request.getContextPath()%>/qna/modifyQuestionAction.jsp" method="post" id="modifyQuestion">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						문의 수정
					</h4>
					
					<div>
					<div class="flex-w flex-sb-m p-b-30 p-l-20">	
					<div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6">
						<img src="<%=request.getContextPath()%>/pimg/<%= pDao.productImgName(question.getProductNo()) %>" style="width:80px; height:80px;">
					</div>
	
					<div class="size-207">
						<div class="flex-w flex-sb-m p-b-17 cen">
							<%=pDao.selectProductOne(question.getProductNo()).getProductName() %>
						</div>
					</div>
					</div>
					</div>
					<!-- 문의수정 폼 -->
					<input type="hidden" name="questionNo" value="<%=question.getqNo() %>">
					<br>
					<div class="row p-b-25">
						<div class="col-sm-6 p-b-5">
							<div class="p-b-25"></div>
							<div class="rs1-select2 rs2-select2 bor8 bg0">
							<%
								if(question.getqCategory().equals("상품")){
							%>
								<select class="js-select2" id="questionCategory" name="questionCategory">
									<option value="">===문의 카테고리===</option>
									<option value="상품" selected="selected">상품</option>
									<option value="교환/환불">교환/환불</option>
									<option value="배송">배송</option>
									<option value="기타">기타</option>
								</select>
							<%		
								} else if(question.getqCategory().equals("교환/환불")){
							%>
								<select class="js-select2" id="questionCategory" name="questionCategory">
									<option value="">===문의 카테고리===</option>
									<option value="상품">상품</option>
									<option value="교환/환불" selected="selected">교환/환불</option>
									<option value="배송">배송</option>
									<option value="기타">기타</option>
								</select>
							<%		
								} else if(question.getqCategory().equals("배송")){
							%>
								<select class="js-select2" id="questionCategory" name="questionCategory">
									<option value="">===문의 카테고리===</option>
									<option value="상품">상품</option>
									<option value="교환/환불">교환/환불</option>
									<option value="배송" selected="selected">배송</option>
									<option value="기타">기타</option>
								</select>
							<%		
								} else if(question.getqCategory().equals("기타")){
							%>
								<select class="js-select2" id="questionCategory" name="questionCategory">
									<option value="">===문의 카테고리===</option>
									<option value="상품">상품</option>
									<option value="교환/환불">교환/환불</option>
									<option value="배송">배송</option>
									<option value="기타" selected="selected">기타</option>
								</select>
							<%		
								}
							%>
								<div class="dropDownSelect2"></div>
							</div>
						</div>
						<div class="col-12 p-b-5">
							<span class="stext-102 cl3 m-r-16">
								Question Title
							</span>
							<span class="fs-18 cl11 pointer">
								<input class="size-111 bor8 mtext-107 cl2 p-lr-30" type="text" name="questionTitle" id="questionTitle" value="<%=question.getqTitle() %>"> 
							</span>
						</div>
						<div class="col-12 p-b-5">
							<label class="stext-102 cl3">Your Question</label>
							<textarea class="size-110 bor8 mtext-107 cl2 p-lr-30 p-tb-10" name="questionContent" id="questionContent"><%=question.getqContent() %></textarea>
						</div>
					</div>
	
					<button id="btn" type="button" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<!-- 이전페이지 버튼 -->
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/customer/questionList.jsp" class="cen">
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