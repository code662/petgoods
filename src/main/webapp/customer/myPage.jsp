<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%	
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	// 디버깅
	System.out.println(PURPLE + id + " <--id myPage" + RESET);
	
	CustomerDao cd = new CustomerDao();
	Customer customer = cd.selectMyPage(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

<form class="bg0 p-t-75 p-b-85">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<h4 class="mtext-111 cl2 p-b-30">
							My Page
						</h4>

						<div class="flex-w flex-t bor12 p-b-13">
							<div class="size-208">
								<span class="stext-110 cl2" style="font-size:17px">
									ID :
								</span>
							</div>
							<div class="size-209">
								<span class="stext-112 cl8" style="font-size:17px">
									<%=customer.getId() %>
								</span>
							</div>
						</div>
						
						<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									NAME :
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=customer.getCstmName() %>
								</p>
							</div>
						</div>
						
						<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									GRADE :
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=customer.getCstmRank() %>
								</p>
							</div>
						</div>
						
						<div class="flex-w flex-t  p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									POINT :
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=customer.getCstmPoint() %>
								</p>
							</div>
						</div>
						<br>
						<div class="flex-w dis-inline-block">
							<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
								<a href="<%=request.getContextPath()%>/customer/modifyCustomer.jsp?cstmNo=<%=customer.getCstmNo()%>" style="color: #333333">
									정보 수정
								</a>
							</div>
							&nbsp;
							<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer" >
								<a href="<%=request.getContextPath()%>/customer/modifyPw.jsp" style="color: #333333">
									비밀번호 변경
								</a>
							</div>
							&nbsp;
							<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
								<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp" style="color: #333333">
									주문 조회
								</a>
							</div>
							&nbsp;
							<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
								<a href="<%=request.getContextPath()%>/customer/addressList.jsp" style="color: #333333">
									배송지 관리
								</a>
							</div>
							&nbsp;
							<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
								<a href="<%=request.getContextPath()%>/customer/reviewList.jsp" style="color: #333333">
									리뷰 관리
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