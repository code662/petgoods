<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 로그인 아이디 유효성 검사
	if(session.getAttribute("loginId") == null
		|| !(session.getAttribute("loginId") instanceof Customer)) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	Customer c = (Customer)session.getAttribute("loginId");

	// 파라미터 유효성 검사
	if(request.getParameter("questionNo") == null
		|| request.getParameter("questionNo").equals("")) {
		 
		response.sendRedirect(request.getContextPath()+"/qna/qustionList.jsp");
		return;
	}
	 
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));

	// Dao 객체 생성
	QuestionDao qDao = new QuestionDao();
	ProductDao pDao = new ProductDao();
	AnswerDao aDao = new AnswerDao();
	
	Question question = qDao.selectQuestionOne(questionNo);
	Answer answer = aDao.selectAnswerOne(questionNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의 상세</title>
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
			
			<a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				MyPage
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			
			<a href="<%=request.getContextPath()%>/qna/myQuestionList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				MyQuestionList
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				QuestionOne
			</span>
		</div>
	</div>
	
	<section class="bg0 p-t-65 p-b-60">
		<div class="col-sm-10 col-lg-7 col-xl-7 m-lr-auto m-b-50">
			<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
				<div class="flex-w flex-sb-m p-b-50">
					<h4 class="mtext-111 cl2  p-r-20">
						상품 문의 상세
					</h4>
					
					<div class="fs-18 cl11 stext-102 flex-w m-r--5">
						<span class="stext-110 cl2 flex-c-m size-104 bor4 trans-04 m-tb-4 m-l-8 cen">
							<%=question.getqStatus() %>
						</span>
					</div>
				</div>
				<%
					if(question.getqStatus().equals("답변대기")){
				%>
					<div class="flex-w flex-sb-m p-b-17">
						<span class="mtext-107 cl2 p-r-20">
							&nbsp;
						</span>
						<span class="fs-18 cl11 stext-102 flex-w m-r--5">
							<a href="<%=request.getContextPath()%>/qna/modifyQuestion.jsp?questionNo=<%=question.getqNo() %>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
								수정
							</a>
							<a href="<%=request.getContextPath()%>/qna/removeQuestionAction.jsp?questionNo=<%=question.getqNo() %>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
								삭제
							</a>
						</span>
					</div>
				<%		
					}
				%>
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
				
				<div class="flex-w flex-t p-t-15">
					<span class="mtext-103 cl5 p-lr-10">
						<%=question.getqTitle()%>
					</span>
					<span class="stext-109 flex-c-m size-304 cl6 bor7 p-lr-10">
						<%=question.getqCategory()%>
					</span>
				</div>
				
				<div class="flex-w flex-t bor12 p-tb-15">
					<div class="stext-117 cl8 plh3 p-t-5 p-l-15">
							<%=question.getqContent()%>
					</div>
				</div>
				
				<%
					if(question.getqStatus().equals("답변완료")) { // 답변이 완료상태일때만 출력
				%>
						<div class=" w-full-ssm p-t-15 p-b-20">
							<span class="mtext-102 cl3 p-lr-10">
								답변 펫프렌즈 담당자
							</span>
						</div>
		
						<div class=" ">
							<span class="stext-117 cl8 plh3 size-120 p-lr-15" id="AnswerContent" name="AnswerContent"><%=answer.getaContent() %></span>
						</div>
				<%		
					} 
				%>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/qna/myQuestionList.jsp" class="cen">
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