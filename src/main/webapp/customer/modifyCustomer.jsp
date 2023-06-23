<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Ansi코드 // 콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 요청값 유효성 검사
	if(request.getParameter("cstmNo") == null 
			|| request.getParameter("cstmNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myPage.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId();	
	// 디버깅
	System.out.println(PURPLE + id + " <--id modifyCustomer" + RESET);
	
	CustomerDao cd = new CustomerDao();
	Customer customer = cd.selectMyPage(id);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<script>
	// 입력폼 유효성 검사
	$(document).ready(function(){
		$('#btn').click(function(){
			if($('#currentPw').val() == ''){
				alert('비밀번호를 입력해주세요');
			}else if($('#cstmName').val() == ''){
				alert('이름을 입력해주세요');
			}else if($('#cstmEmail').val() == ''){
				alert('이메일 주소를 입력해주세요');
			}else {
				$('#modifyCustomer').submit();
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
			<span class="stext-109 cl4">
				modifyCustomer
			</span>
		</div>
	</div>
	
	<!-- 수정 폼 -->
	<section class="bg0 p-t-75 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/customer/modifyCustomerAction.jsp?cstmNo=<%=customer.getCstmNo() %>" method="post" id="modifyCustomer">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						내 정보 수정
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
						
					<div class="bor8 m-b-20 how-pos4-parent" style="border:none">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="id" value="<%=customer.getId() %>" readonly="readonly">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="password" name="currentPw" id="currentPw" placeholder="Enter your password">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="cstmName" id="cstmName" value="<%=customer.getCstmName()%>">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="cstmEmail" id="cstmEmail" value="<%=customer.getCstmEmail()%>">
					</div>

					<button id="btn" type="button" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/customer/myPage.jsp?cstmNo=<%=customer.getCstmNo()%>" class="cen">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers">
							취소
						</span>
					</a>
					<a href="<%=request.getContextPath()%>/customer/removeCustomer.jsp" class="cen">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer" >
							회원탈퇴
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