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
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- 리다이렉션 메시지 --> 
	<div>
	<%
		if(request.getParameter("msg") != null){
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
	</div>
	
	<!-- 수정 폼 -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/customer/modifyCustomerAction.jsp?cstmNo=<%=customer.getCstmNo() %>" method="post">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						내 정보 수정
					</h4>
					<div class="bor8 m-b-20 how-pos4-parent" style="border:none">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="id" value="<%=customer.getId() %>" style="font-size:16px" readonly="readonly">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="password" name="currentPw" required="required" style="font-size:16px" placeholder="Enter your password">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="cstmName" value="<%=customer.getCstmName()%>" style="font-size:16px">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="cstmEmail" value="<%=customer.getCstmEmail()%>" style="font-size:16px">
					</div>

					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers cen">
						<a href="<%=request.getContextPath()%>/customer/myPage.jsp?cstmNo=<%=customer.getCstmNo()%>" style="color: #333333">
							취소
						</a>
					</div>
					&nbsp;
					<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer cen" >
						<a href="<%=request.getContextPath()%>/customer/removeCustomer.jsp" style="color: #333333">
							회원탈퇴
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