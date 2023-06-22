<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%> 
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 요청값 유효성 검사
	if(request.getParameter("empNo") == null
			|| request.getParameter("empNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/employees/employeeList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	// 디버깅
	System.out.println(PURPLE + empNo + " <--empNo employeeOne" + RESET);
		
	// 로그인 세션 정보 객체에 저장
	Employees e = (Employees)session.getAttribute("loginId");
	
	EmployeesDao ed = new EmployeesDao();
	Employees employees = ed.selectEmployeesOne(empNo);

%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 상세정보</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>
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
		<span class="stext-109 cl4">
			employeeOne
		</span>
	</div>
</div>
	
<!-- 사원 상세정보 리스트 -->
<form class="bg0 p-t-75 p-b-85">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<h4 class="mtext-111 cl2 p-b-30">
							사원 상세정보
						</h4>
						
						<div class="flex-w flex-t bor12 p-b-13">
							<div class="size-208">
								<span class="stext-110 cl2" style="font-size:17px">
									ID :
								</span>
							</div>
							<div class="size-209">
								<span class="stext-112 cl8" style="font-size:17px">
									<%=employees.getId() %>
								</span>
							</div>
						</div>
						
						<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									이름 :
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=employees.getEmpName()%>
								</p>
							</div>
						</div>
						
						<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									권한등급 :
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=employees.getEmpLevel() %>
								</p>
							</div>
						</div>
						
						<div class="flex-w flex-t  p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									입사날짜 :
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=employees.getCreatedate() %>
								</p>
							</div>
						</div>
						<br>
						<div class="flex-w flex-sb-m p-b-17">
							<div class="mtext-111 cl2  p-r-20 flex-w dis-inline-block">
								<a href="<%=request.getContextPath()%>/employees/modifyEmployee.jsp?empNo=<%=employees.getEmpNo()%>" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
										권한등급 변경
									</span>
								</a>
								&nbsp;
								<a href="<%=request.getContextPath()%>/employees/removeEmployeeAction.jsp?empNo=<%=employees.getEmpNo()%>" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
										사원 삭제
									</span>
								</a>
							</div>
							<div class="fs-18 cl11 stext-102 flex-w m-r--5">
								<a href="<%=request.getContextPath()%>/employees/employeeList.jsp" style="color: #333333">
									<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers">
										취소
									</span>	
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
<jsp:include page="/inc/footer.jsp"></jsp:include>
<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
<jsp:include page="/inc/quickView.jsp"></jsp:include>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>