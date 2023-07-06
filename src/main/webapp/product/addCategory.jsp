<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %> 
<%@ page import="vo.*" %>
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 세션 유효성 검사: 로그인 상태가 아니거나 고객 계정으로 로그인된 경우 home으로 리다이렉션
	if (session.getAttribute("loginId") == null
	|| session.getAttribute("loginId") instanceof Customer) {
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 나의 주문 리스트 (주문날짜 최신순) 
	// 결제완료일 때 주문취소 버튼 노출 
	// 구매확정일 때 리뷰작성 버튼 노출 
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 세션 유효성 검사 추가
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
 	String msg = "";
	String id = "";
 	if (session.getAttribute("loginId") != null) {
 		Employees employee = (Employees) session.getAttribute("loginId");
 		id = employee.getId();
 		System.out.println(id + " <-- id(addCategory)");

 		
 	}
 	
 	System.out.println("==============addCategory.jsp==============");
%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addCategory</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
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
				<a href="<%=request.getContextPath()%>/product/mainCategoryList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
					mainCategoryList
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<span class="stext-109 cl4">
					addCategory
				</span>
			</div>
		</div>
		
		<form action="<%=request.getContextPath()%>/product/addCategoryAction.jsp" method="post"  class="bg0 p-t-75 p-b-85" action="<%=request.getContextPath()%>/product/modifyCategoryAction.jsp" method="post">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">	 	
						<h4 class="mtext-111 cl2 p-b-30">
							새 카테고리 입력
						</h4>
		<% 
			if (request.getParameter("msg") != null) {
		%>
				<p style="color: #F24182; font-weight:bolder;"><%=request.getParameter("msg") %></p>
		<%
			}
		%>
				<div class="flex-w flex-t bor12 p-b-13">
					<div class="size-208">
						<span class="stext-110 cl2" style="font-size:17px">
							메인 카테고리명
						</span>
					</div>
						<div class="size-209">
							<span class="stext-112 cl8" style="font-size:17px">
								<input type="text" name="categoryMainName" placeholder="메인 카테고리명 입력">
							</span>
						</div>
				</div>
				
				<div class="flex-w flex-t bor12 p-b-13">
					<div class="size-208">
						<span class="stext-110 cl2" style="font-size:17px">
							서브 카테고리명
						</span>
					</div>
					<div class="size-209">
						<span class="stext-112 cl8" style="font-size:17px">
							<input type="text" name="categorySubName" placeholder="서브 카테고리명 입력">
						</span>
					</div>
				</div>
				
				<br>
				<div class="flex-w dis-inline-block">
					<button type="submit" style="color: #333333">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							입력
						</span>
					</button>
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