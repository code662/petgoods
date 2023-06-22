<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 결제가 완료(실패)되었다는 폼만 생성
	// 쇼핑계속하기 / 주문내역확인
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	System.out.println("==============completeOrder.jsp==============");	
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>completeOrder</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				const urlParams  = new URL(location.href).searchParams;
				const msg = urlParams.get('msg');
				if(msg != null){
					alert(msg);
				}
			});
		</script>
	</head>
	<body>
		<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>
		
		<!-- breadcrumb -->
			<div class="container">
				<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
					<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
						Home
						<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
					</a>
					<span class="stext-109 cl4">
						addOrder
						<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
					</span>
					<span class="stext-109 cl4">
						completeOrder
					</span>
				</div>
			</div>
		
			<section class="bg0 p-t-104 p-b-116">
				<div class="container">
					<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
						<h4 class="mtext-111 cl2 txt-center p-b-30">
							결제 완료	
						</h4>
						<div class="flex-w dis-inline-block cen">
						<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							<a href="<%=request.getContextPath()%>/product/productList.jsp" style="color: #333333">
								쇼핑 계속하기
							</a>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							<a href="<%=request.getContextPath()%>/customer/myOrderList.jsp" style="color: #333333">
								주문내역 확인
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