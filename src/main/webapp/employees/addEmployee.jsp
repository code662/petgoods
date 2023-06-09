<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<script>
	// 입력폼 유효성 검사
	$(document).ready(function(){
		$('#btn').click(function(){
			if($('#id').val() == ''){
				alert('아이디를 입력해주세요');
			}else if($('#pw').val() == ''){
				alert('비밀번호를 입력해주세요');
			}else if($('#empName').val() == ''){
				alert('이름을 입력해주세요');
			}else if($('#empLevel').val() == ''){
				alert('권한 등급을 입력해주세요');
			}else {
				$('#addEmployee').submit();
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
			<span class="stext-109 cl4">
				addEmployee
			</span>
		</div>
	</div>
	
	<!-- 사원 등록 폼 -->
	<section class="bg0 p-t-75 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/employees/addEmployeeAction.jsp" method="post" id="addEmployee">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						사원 등록
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
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="id" id="id" placeholder="Enter ID">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="password" name="pw" id="pw" placeholder="Enter password">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="empName" id="empName" placeholder="Enter name">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30" type="text" name="empLevel" id="empLevel" placeholder="Enter level">
					</div>

					<button id="btn" type="button" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/employees/employeeList.jsp" class="cen">
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