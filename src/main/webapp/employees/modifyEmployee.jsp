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
	
	// post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");
	
	// 요청값 유효성 검사
	if(request.getParameter("empNo") == null
			|| request.getParameter("empNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/employees/employeeOne.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	// 디버깅
	System.out.println(PURPLE + empNo + " <--empNo modifyEmployee" + RESET);
	
	EmployeesDao ed = new EmployeesDao();
	Employees employees = ed.selectEmployeesOne(empNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원레벨 변경</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- 사원레벨 변경 폼 -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/employees/modifyEmployeeAction.jsp" method="post">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						사원레벨 변경
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
						
					<div class="col-12 p-b-5">
						<span class="stext-102 cl3 m-r-16">
							사원번호
						</span>
						<span class="fs-18 cl11 pointer">
							<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="empNo" value="<%=employees.getEmpNo() %>" style="font-size:16px; border:none;"> 
						</span>
					</div>
					<div class="col-12 p-b-5">
						<span class="stext-102 cl3 m-r-16">
							사원이름
						</span>
						<span class="fs-18 cl11 pointer">
							<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="empName" value="<%=employees.getEmpName() %>" style="font-size:16px; border:none;"> 
						</span>
					</div>
					<div class="col-12 p-b-5">
						<span class="stext-102 cl3 m-r-16">
							사원레벨
						</span>
						<span class="fs-18 cl11 pointer">
							<input class="size-111 bor8 stext-102 cl2 p-lr-95" type="text" name="empLevel" value="<%=employees.getEmpLevel() %>" style="font-size:16px;"> 
						</span>
					</div>
					<br>
					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/employees/employeeOne.jsp?empNo=<%=employees.getEmpNo() %>" style="color: #333333" class="cen">
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