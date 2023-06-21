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
	String productImg = request.getParameter("productImg");
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int cnt = Integer.parseInt(request.getParameter("cnt"));
	
	// id 확인 및 디버깅
	// 로그인 상태가 아니면 메시지와 함께 로그인 화면으로 이동
	String id = "";
	String msg = "";
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
		<title>addOrder</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
		<script>
			$(document).ready(function(){
				const urlParams  = new URL(location.href).searchParams;
				const msg = urlParams.get('msg');
				if(msg != null){
					alert(msg);
				}
			});
		</script>
<%-- 		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				var minValue = 0;
				var maxValue = <%=myPoint%>;
				
				$('input[type=number]').on('input', function() {
					var value = parseInt($(this).val());
					if (isNaN(value)) {
					      value = minValue;
					} else {
					      value = Math.max(minValue, Math.min(value, maxValue));
				    }
					
					$(this).val(value);
					
					if (value < minValue || value > maxValue) {
					      alert('입력값이 허용된 범위를 벗어납니다.');
					}
				});
			});
		</script> --%>
	</head>
	<body>
		<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>
		
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/order/addOrderProductAction.jsp" method="post" class="bg0 p-t-75 p-b-85">
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
					<th class="column-1">상품이미지</th>
					<th class="column-1">상품이름</th>
					<th class="column-1">상품가격</th>
					<th class="column-1">개수</th>
					<th class="column-1">주문인 이름</th>
					<th class="column-1">배송지</th>
					<th class="column-1">합계금액</th>
				</tr>
				<tr class="table_head">
					<td class="column-1"><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
					<td class="column-1"><%=productName%></td>
					<td class="column-1">
						<input type="hidden" name="productPrice" value="<%=productPrice%>">
						<%=productPrice%>원
					</td>
					<td class="column-1">
						<input type="hidden" name="cnt" value="<%=cnt%>">
						<%=cnt%>
					</td>
					<td class="column-1"><%=myName%></td>
					<td class="column-1"><%=myAdd%>(최근 등록 주소)</td>
					<td class="column-1"><%=productPrice * cnt%>원</td>
				</tr>
		</table>
		<br>
		<div class="flex-w dis-inline-block">
			<input type="number" id="inputValue" placeholder="포인트 입력 : 최대 <%=myPoint%>" name="point" class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5">	
			&nbsp;
			<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
				<button  type="submit" style="color: #333333">
					결제
				</button>
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