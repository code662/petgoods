<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 로그인 아이디 유효성 검사
	if(session.getAttribute("loginId") == null
		|| !(session.getAttribute("loginId") instanceof Employees)) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

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
	
	// 
	Question question = qDao.selectQuestionOne(questionNo);
	Answer answer = aDao.selectAnswerOne(questionNo);

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		$('#addAnswerBtn').click(function(){
			if($('#AnswerContent').val() == ''){
				alert('답변을 작성해주세요');
			}else {
				$('#addAnswer').submit();
			}
		});
		
		$('#modifyAnswerBtn').click(function(){
			if($('#AnswerContent').val() == ''){
				alert('답변을 작성해주세요');
			}else {
				$('#modifyAnswer').submit();
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>

	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			
			<a href="<%=request.getContextPath()%>/qna/questionList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				QuestionList
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
					<h4 class="mtext-109 cl2 p-b-30">
						상품 문의 상세
					</h4>
					
					<div class="flex-w flex-t p-b-5">
						<div class="size-208">
							<span class="stext-110 cl2 p-l-10" style="font-weight: bold">
								<%=question.getqStatus() %>
							</span>
						</div>
		
						<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bg0">
							<div class="stext-111 cl8 plh3 size-111 p-lr-15">
							
							</div>
						</div>
					</div>
					
					<div class="flex-w flex-t bor12 p-b-5">
						<div class="size-208">
							<span class="stext-110 cl2 p-l-10">
								<%=question.getId() %>
							</span>
						</div>
		
						<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bg0">
							<div class="stext-111 cl8 plh3 size-111">
								<%=pDao.selectProductOne(question.getProductNo()).getProductName() %>
							</div>
						</div>
					</div>
					
					<div class="flex-w flex-t p-t-15">
						<div class="size-208">
							<span class="stext-110 cl5 p-lr-10">
								<%=question.getqTitle()%>
							</span>
						</div>
						<div class="size-209p-r-18 p-r-0-sm w-full-ssm bg0">
							<span class="stext-109 cl5">
								<%=question.getqCategory()%>
							</span>
						</div>
					</div>
					
					<div class="flex-w flex-t bor12 p-tb-15">
						<div class="stext-111 cl8 plh3 p-t-5 p-l-10">
								<%=question.getqContent()%>
						</div>
					</div>
					<%
						if(answer == null) {
					%>
						<form action="<%=request.getContextPath()%>/qna/addAnswerAction.jsp" method="post" id="addAnswer">
							<div class="flex-w flex-t bor12 p-t-15 p-b-30">
								<div class="size-208 w-full-ssm">
									<span class="stext-110 cl2 p-lr-10">
										답변:
									</span>
								</div>
				
								<div class="size-209 p-r-0-sm w-full-ssm bor8 bg0">
									<input type="hidden" name="questionNo" value="<%=questionNo%>">
									<textarea class="stext-111 cl8 plh3 size-120 p-lr-15" id="AnswerContent" name="AnswerContent" placeholder="답변 내용"></textarea>
								</div>
							</div>
							<div class="flex-w flex-t p-t-27">
								<button type="button" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer" id="addAnswerBtn">
									답변 작성
								</button>
							</div>
						</form>
					<%		
						} else {
					%>
						<form action="<%=request.getContextPath()%>/qna/modifyAnswerAction.jsp" method="post" id="modifyAnswer">
							<div class="flex-w flex-t bor12 p-t-15 p-b-30">
								<div class="size-208 w-full-ssm">
									<span class="stext-110 cl2 p-lr-10">
										답변:
									</span>
								</div>
				
								<div class="size-209 p-r-0-sm w-full-ssm bor8 bg0">
									<input type="hidden" name="answerNo" value="<%=answer.getaNo()%>">
									<input type="hidden" name="questionNo" value="<%=questionNo%>">
									<textarea class="stext-111 cl8 plh3 size-120 p-lr-15" id="AnswerContent" name="AnswerContent"><%=answer.getaContent() %></textarea>
								</div>
							</div>
							<div class="flex-w flex-t p-t-27">
								<button type="button" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer" id="modifyAnswerBtn">
									답변 수정
								</button>
							</div>
						</form>
					<%		
						}
					%>
				</div>
			</div>
	</section>
<jsp:include page="/inc/footer.jsp"></jsp:include>
<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
<jsp:include page="/inc/quickView.jsp"></jsp:include>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>