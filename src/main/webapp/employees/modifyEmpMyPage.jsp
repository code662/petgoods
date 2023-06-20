<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<% 
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 로그인 세션 정보 변수에 저장
	Employees e = (Employees)session.getAttribute("loginId");
	int empNo = e.getEmpNo();
	// 디버깅
	System.out.println(PURPLE + empNo + " <--empNo modifyEmpMyPage" + RESET);
	
	
	EmployeesDao ed = new EmployeesDao();
	Employees employees = ed.selectEmployeesOne(empNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 개인정보 변경</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- 개인정보 변경 폼 : 현재 비밀번호 확인 및 변경 비밀번호, 이름 입력 -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/employees/modifyEmpMyPageAction.jsp" method="post">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						사원 개인정보 변경
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
						
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" name="empName" value="<%=employees.getEmpName() %>" style="font-size:16px">
					</div>	
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="password" name="currentPw" required="required" style="font-size:16px" placeholder="현재 비밀번호">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="password" name="changePw" required="required" style="font-size:16px" placeholder="변경 비밀번호">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="password" name="confirmPw" required="required" style="font-size:16px" placeholder="변경 비밀번호 확인">
					</div>
					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/employees/employeeMyPage.jsp" style="color: #333333" class="cen">
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