<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
   //세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
   if(session.getAttribute("loginId") == null){
      response.sendRedirect(request.getContextPath()+"/home.jsp");
      return;
   }

   // 로그인 세션 정보 변수에 저장
   Customer c = (Customer)session.getAttribute("loginId");
   String id = c.getId(); 
   
   // 배송지 목록 조회
   AddressDao ad = new AddressDao();
   ArrayList<Address> list = ad.selectAddress(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 관리</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

    <!-- 배송지 리스트 -->
    <form class="bg0 p-t-75 p-b-85">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-11 col-xl-11 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<h4 class="mtext-111 cl2 p-b-30">
							배송지 관리
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
						
						<%
							for(Address a : list) {
					    %>
						<div class="flex-w flex-t bor12 p-b-13">
							<div class="size-209">
								<span class="stext-112 cl8" style="font-size:17px;">
									<%=a.getAddress()%>
								</span>
							</div>
							<div class="size-208">
								<div align="center">
									<div class="stext-112 cl8">
										<span class="fs-18 cl11 stext-102 flex-w m-r--5">
											<a href="<%=request.getContextPath()%>/customer/modifyAddress.jsp?addressNo=<%=a.getAddressNo() %>" style="color: #A6A6A6" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
												수정
											</a>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<a href="<%=request.getContextPath()%>/customer/removeAddressAction.jsp?addressNo=<%=a.getAddressNo() %>" style="color: #A6A6A6" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
												삭제
											</a>
										</span>
									</div>
								</div>
							</div>
						</div>
						<br>
						<%
					         }
					    %>
						<br>
						<div class="flex-w dis-inline-block">
							<a class="btn" href="<%=request.getContextPath()%>/customer/addAddress.jsp" style="color: #333333">
								<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
									새 배송지 추가
								</span>
							</a>
							<a class="btn" href="<%=request.getContextPath()%>/customer/myPage.jsp" style="color: #333333">
								<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
									취소
								</span>
							</a>
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