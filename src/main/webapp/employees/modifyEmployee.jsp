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
<title>권한등급 변경</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<script>
	// 입력폼 유효성 검사
	$(document).ready(function(){
		$('#btn').click(function(){
			if($('#empLevel').val() == ''){
				alert('권한 등급을 입력해주세요');
			}else {
				$('#modifyEmployee').submit();
			}
		});
	});
</script>
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
			<a href="<%=request.getContextPath()%>/employees/employeeList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				employeeList
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<a href="<%=request.getContextPath()%>/employees/employeeOne.jsp?empNo=<%=empNo %>" class="stext-109 cl8 hov-cl1 trans-04">
				employeeOne
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				modifyEmployee
			</span>
		</div>
	</div>

	<!-- 사원레벨 변경 폼 -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/employees/modifyEmployeeAction.jsp" method="post" id="modifyEmployee">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						권한등급 변경
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
							<input class="mtext-107 bor8 stext-102 cl2 p-lr-95" type="text" name="empNo" value="<%=employees.getEmpNo() %>" readonly="readonly" style="border:none;"> 
						</span>
					</div>
					<div class="col-12 p-b-5">
						<span class="stext-102 cl3 m-r-16">
							사원이름
						</span>
						<span class="fs-18 cl11 pointer">
							<input class="mtext-107 bor8 stext-102 cl2 p-lr-95" type="text" name="empName" value="<%=employees.getEmpName() %>" readonly="readonly" style="border:none;"> 
						</span>
					</div>
					<div class="col-12 p-b-5">
						<span class="stext-102 cl3 m-r-16">
							권한등급
						</span>
						<span class="fs-18 cl11 pointer">
							<input class="stext-1120 bor8 stext-102 cl2 p-lr-95" type="text" name="empLevel" id="empLevel" value="<%=employees.getEmpLevel() %>"> 
						</span>
					</div>
					<br>
					<button id="btn" type="button" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/employees/employeeOne.jsp?empNo=<%=employees.getEmpNo() %>" class="cen">
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