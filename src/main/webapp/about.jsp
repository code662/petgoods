<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
	<%
		// 사원이 로그인 중일 때 사원용 헤더 표시
		if(session.getAttribute("loginId") instanceof Employees) {
	%>
			<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
	<%	
		// 아니면 고객용 헤더 표시
		} else {
			%>
			<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
	<%		
		}
	%>
	<jsp:include page="/inc/sidebar.jsp"></jsp:include>
	<jsp:include page="/inc/cart.jsp"></jsp:include>
	
	<!-- 제목 -->
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('<%=request.getContextPath()%>/img/bg-02.jpg');">
		<h2 class="ltext-105 cl0 txt-center">
			About
		</h2>
	</section>	


	<!-- 내용 -->
	<section class="bg0 p-t-75 p-b-120">
		<div class="container">
			<div class="row p-b-148">
				<!-- 프로젝트 설명 -->
				<div class="col-md-7 col-lg-8">
					<div class="p-t-7 p-r-85 p-r-15-lg p-r-0-md">
						<h3 class="mtext-111 cl2 p-b-16">
							프로젝트 설명
						</h3>
						<div class="bor16 p-l-29 p-b-9 m-t-22">
							<p class="stext-114 cl6 p-r-40 p-b-11">
								View와 Controller를 모두 구현하는 JSP와 Model을 구현하는 JavaBeans(Dao)를 분리하는 Model1 구조를 이용하여 만드는 세미 팀 프로젝트로, 모바일 사이트만 있는 펫프렌즈를 참고하여 쇼핑몰 웹사이트로 만들었습니다.<br>
								고객과 관리자가 분리되어 있으며, DB에 저장하여 고객, 관리자, 상품, 문의, 할인율, 리뷰 정보를 저장하여 사용합니다.&nbsp;
								장바구니 이용시 로그인을 하지 않았을 경우 세션에 정보를 저장하며 로그인하면 DB에 장바구니 정보를 저장합니다.&nbsp;
								관리자는 Level 1, 2가 있으며 Level 2가 상위 Level이고 사원관리는 Level 2 관리자만 할 수 있습니다.&nbsp;
								비밀번호 이력을 관리하여 비밀번호 변경시 3개의 이전 비밀번호로를 저장하고 저장된 비밀번호로 변경 할 수 없게 합니다.&nbsp;
								고객과 관리자의 통합된 아이디 리스트를 저장하여 사원과 관리자는 아이디가 중복될 수 없고 회원탈퇴한 아이디로는 가입할 수 없게 합니다.
							</p>
						</div>
					</div>
				</div>

				<div class="col-11 col-md-5 col-lg-4 m-lr-auto">
					<div class="how-bor1 ">
						<div class="hov-img0">
							<img src="<%=request.getContextPath()%>/img/about-01.jpg" alt="IMG">
						</div>
					</div>
				</div>
			</div>
			<!-- 개발 환경 -->
			<div class="row">
				<div class="order-md-2 col-md-7 col-lg-8 p-b-30">
					<div class="p-t-7 p-l-85 p-l-15-lg p-l-0-md">
						<h3 class="mtext-111 cl2 p-b-16">
							개발 환경
						</h3>
						<div class="bor16 p-l-29 p-b-9 m-t-22">
							<p class="stext-114 cl6 p-r-40 p-b-11">
								OS : Window11<br>
								Library : Servlet(4.0), BootStrap5, jQuery(3.7.0)<br>
								Language : HTML5, CSS , Java(JavaSE-17), JavaScript<br>
								사용 프로그램 : Eclipse IDE(2022-12 R), HeidiSQL(12.3.0)<br>
								Database : MariaDB(10.5.21)<br>
								server : Tomcat 9.0.75
							</p>
						</div>
					</div>
				</div>

				<div class="order-md-1 col-11 col-md-5 col-lg-4 m-lr-auto p-b-30">
					<div class="how-bor2">
						<div class="hov-img0">
							<img src="<%=request.getContextPath()%>/img/about-02.jpg" alt="IMG">
						</div>
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