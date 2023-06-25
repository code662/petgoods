<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 
<%@ page import="java.net.*" %>

<%
	// productOne에서 넘어온 단일 상품 주문 폼
	
	// 상품 이름, 상품이미지, 상품 가격, 상품 개수, 총 주문금액, 주문인 이름, 배송지(가장 최근에 등록한 배송지), 
	// 버튼: 포인트 (사용가능 포인트 표시, 사용할 포인트 입력), 결제
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 파일 바로 실행 시 상품 리스트로 이동
	if (request.getParameter("productNo") == null) {
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
		return;
	}

	// 상품번호(productNo) 요청값 디버깅
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	System.out.println(productNo + " <-- productNo(addOrder)");
	
	// 상품이미지, 상품이름, 상품가격, 담은 개수(cnt) -> 총 가격은 따로 구하기
	if (request.getParameter("productPrice") == null
	|| request.getParameter("cnt") == null) {
		System.out.println("유효성 검사 확인-단일 상품(addOrder)");
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
		return;
	}
	
	// 요청값 설정 및 디버깅
	String msg = "";
	String productImg = request.getParameter("productImg");
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int cnt = Integer.parseInt(request.getParameter("cnt"));
	if (cnt == 0) {
		msg = URLEncoder.encode("1개 이상의 수량을 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo + "&msg=" + msg);
		return;
	}
	
	// id 확인 및 디버깅
	// 로그인 상태가 아니면 메시지와 함께 로그인 화면으로 이동
	String id = "";
	if (session.getAttribute("loginId") != null) {
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(addOrder)");
 	} else {
		msg = URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/login.jsp?msg=" + msg);
		return;
	}
	
	// model
	// 내 포인트 조회, 주문인 이름, 배송지 조회를 위한 CustomerDao -> selectMyPoint(String id), selectMyName(String id), selectMyAdd(String id)
	CustomerDao customerDao = new CustomerDao();

	// 나의 포인트 조회
	int myPoint = customerDao.selectMyPoint(id);
	System.out.println(myPoint + " <-- myPoint(addOrder)");
	
	// 이름 조회
	String myName = customerDao.selectMyName(id);
	System.out.println(myName + " <-- myName(addOrder)");
	
	// 주소 조회
	String myAdd = customerDao.selectMyAdd(id);
	System.out.println(myAdd + " <-- myAdd(addOrder)"); 
	
	System.out.println("==============addOrderProduct.jsp==============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addOrderProduct</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				  const urlParams = new URL(location.href).searchParams;
				  const msg = urlParams.get('msg');
				  if (msg != null) {
				    alert(msg);
				  }
	
				  const myPoint = <%=myPoint%>;
				  $('#btn').click(function() {
				    validateForm();
				  });
	
				  $('#inputValue').keydown(function() {
					  if (event.keyCode === 13) { // 엔터키 눌렀을 때
					    event.preventDefault(); // 기본 동작 방지
					  };
				  });
	
				  function validateForm() {
				    if ($('#inputValue').val() > myPoint || $('#inputValue').val() < 0) {
				      alert('유효값(0 ~ ' + myPoint + ')을 입력해주세요.');
				    } else {
				      $('#addOrderProduct').submit();
				    }
				  }
			});
	<%-- 		$(document).ready(function(){
				const urlParams  = new URL(location.href).searchParams;
				const msg = urlParams.get('msg');
				if(msg != null){
					alert(msg);
				}
			
				const myPoint = <%=myPoint%>;
				$('#btn').click(function() {
					if ($('#inputValue').val() > myPoint || $('#inputValue').val() < 0) {
						alert('유효값(0 ~ ' + myPoint + ')을 입력해주세요.');
					} else {
						$('#addOrderProduct').submit();
					}
				});
			}); --%>
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
					productList
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</span>
				<span class="stext-109 cl4">
					productOne
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</span>
				<span class="stext-109 cl4">
					addOrderProduct
				</span>
			</div>
		</div>
		
<%-- 		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%		
			}
		%> --%>
		<form action="<%=request.getContextPath()%>/order/addOrderProductAction.jsp" method="post" class="bg0 p-t-75 p-b-85" id="addOrderProduct">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<div class="flex-w flex-sb-m p-b-17">
								<h4 class="mtext-111 cl2  p-r-20">
									주문하기
								</h4>
								<br>	
							</div>
							<input type="hidden" name="productNo" value="<%=productNo%>">
							<table class="table-shopping-cart">
								<tr class="table_head">
									<th class="text-center">상품이미지</th>
									<th class="text-center">상품이름</th>
									<th class="text-center">상품가격</th>
									<th class="text-center">수량</th>
									<th class="text-center">주문인 이름</th>
									<th class="text-center">배송지</th>
									<th class="text-center">합계금액</th>
								</tr>
								<tr class="table_head">
									<td class="text-center"><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
									<td class="text-center"><%=productName%></td>
									<td class="text-center">
										<input type="hidden" name="productPrice" value="<%=productPrice%>">
										<%=productPrice%>원
									</td>
									<td class="text-center">
										<input type="hidden" name="cnt" value="<%=cnt%>">
										<%=cnt%>
									</td>
									<td class="text-center"><%=myName%></td>
									<td class="text-center" ><%=myAdd%></td>
									<td class="text-center"><%=productPrice * cnt%>원</td>
								</tr>
						</table>
						<br>
						<div class="flex-w dis-inline-block">
							<input type="number" id="inputValue" placeholder="포인트 입력 : 최대 <%=myPoint%>" name="point" class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5">	
							&nbsp;
							<button id="btn" type="button" style="color: #333333">
								<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
									결제
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