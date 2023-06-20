<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 

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
	if (request.getParameter("productImg") == null
	|| request.getParameter("productName") == null
	|| request.getParameter("productPrice") == null
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
	String id = "";
	if (session.getAttribute("loginId") != null) {
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(addOrder)");
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
		</script>
	</head>
	<body>
		<h1>주문하기</h1>
		<form action="<%=request.getContextPath()%>/order/addOrderProductAction.jsp" method="post">
			<input type="hidden" name="productNo" value="<%=productNo%>">
			<table border="1">
				<tr>
					<th>상품이미지</th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>개수</th>
					<th>주문인 이름</th>
					<th>배송지</th>
					<th>합계금액</th>
				</tr>
				<tr>
					<td><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
					<td><%=productName%></td>
					<td>
						<input type="hidden" name="productPrice" value="<%=productPrice%>">
						<%=productPrice%>원
					</td>
					<td>
						<input type="hidden" name="cnt" value="<%=cnt%>">
						<%=cnt%>
					</td>
					<td><%=myName%></td>
					<td><%=myAdd%>(최근 등록 주소)</td>
					<td><%=productPrice * cnt%>원</td>
				
				</tr>
		</table>
		
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%		
			}
		%>
		
		사용할 포인트 입력: <input type="number" id="inputValue" placeholder="보유 포인트: <%=myPoint%>" name="point">	
		<button type="button" id="submitButton">입력</button>
		<div>
			<button type="submit">결제</button> 
		</div>
	</form>
	</body>
</html>