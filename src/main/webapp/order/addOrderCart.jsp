<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 
<%@ page import="java.net.*" %>
    
<% 
	// 장바구니에서 넘어온 주문 폼

	// 주문하기 폼 (shopping cart.html 파일에서 분리 예정)
	// 상품 이름, 상품이미지, 상품 가격, 상품 개수, 총 주문금액, 주문인 이름, 배송지(가장 최근에 등록한 배송지), 
	// 버튼: 포인트 (사용가능 포인트 표시, 사용할 포인트 입력), 결제

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 검사 (상품이미지, 상품이름, 상품 가격, 상품 개수, 전체 가격, 선택된 번호)
	// 하나라도 null 값이 있다면 홈으로 리다이렉트
 	
	if (request.getParameterValues("cartNo") == null
	|| request.getParameterValues("productNo") == null
	|| request.getParameterValues("productImg") == null
	|| request.getParameterValues("productName") == null
	|| request.getParameterValues("productPrice") == null
	|| request.getParameterValues("cartCnt") == null
	|| request.getParameterValues("totalPrice") == null
	|| request.getParameterValues("selCart") == null) {
		System.out.println("유효성 검사 확인(addOrderCart)");
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
		
	// request.getParameterValues();
	// 모든 값이 cartList.jsp에서 넘어옴
	// selCart 가 체크된 값이 있는 경우에만 넘어오게 하는 방법? -> 체크박스 value에 cartNo 사용
			
	String[] selectedValues = request.getParameterValues("selCart");
		if (selectedValues != null) { 
  			for (String value : selectedValues) {
    			System.out.println("선택된 장바구니 번호: " + value);
  		}
	}
		
	String[] cartNo = request.getParameterValues("cartNo");
	String[] productNo = request.getParameterValues("productNo");
	String[] productImg = request.getParameterValues("productImg");
	String[] productName = request.getParameterValues("productName");
	String[] productPrice = request.getParameterValues("productPrice");
	String[] selCart = request.getParameterValues("selCart");
	String[] totalPrice = request.getParameterValues("totalPrice");
	String[] cartCnt = request.getParameterValues("cartCnt");

	// 요청값 디버깅
	for (int i = 0; i < cartNo.length; i += 1) { // 장바구니 목록 내 제품 개수만큼 반복
		for (int j = 0; j < selCart.length; j += 1) { // 선택된 제품 개수만큼 반복
			if (cartNo[i].equals(selCart[j])) { // 장바구니 번호와 체크된 체크박스의 번호가 일치하면
				System.out.println(cartNo[i] + " <-- cartNo(addOrderCart"); // 카트번호
				System.out.println(productNo[i] + " <-- productNo(addOrderCart)"); // 상품번호
				System.out.println(productImg[i] + " <-- productImg(addOrderCart)"); // 이미지 이름
				System.out.println(productName[i] + " <-- productName(addOrderCart)"); // 상품 이름
				System.out.println(cartCnt[i] + " <-- cartCnt(addOrderCart)"); // 수량
				System.out.println(productPrice[i] + " <-- productPrice(addOrderCart)"); // 상품 가격
				System.out.println(totalPrice[i] + " <-- totalPrice(addOrderCart)"); // 총 가격
			}
		}
	} 
	
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
	System.out.println(myPoint + " <-- myPoint(addOrderCart)");
	
	// 이름 조회
	String myName = customerDao.selectMyName(id);
	System.out.println(myName + " <-- myName(addOrderCart)");
	
	// 주소 조회
	String myAdd = customerDao.selectMyAdd(id);
	System.out.println(myAdd + " <-- myAdd(addOrderCart)"); 
	
	System.out.println("==============addCartProduct.jsp==============");
	
	// 
	
	// productOne.jsp에서 넘어온 주문, 카트에서 넘어온 주문
	
	// 여러 상품 주문 불가능 이슈:
	// 주문 여러 상품 받을 때 requestParameterValues() 로 받음
	// 주문넘버 = {"1", "2", "3", ...} 과 같은 형태
	// for (String s : order) {} ... 배열 생성
	// 배열 내부에 주문 메소드
	// 한 번에 여러 상품 주문이 가능하나 주문코드는 다르게 찍힘
	
	// request.getParameterValues() -> 사용?
	
	/*
	
	String[] a = get;

   AraayList<Orders> oList = new ArrayList<>();
   for(int i=0; i<a.length;i+=1) {
      Orders order = new Orders();
      order.setProductNo(Integer.parseInt(a[i]));
      oList.add(order);
   }
   
   for(Orders o : oList){
      int row = oDao.addOders(o);
      if(row == 1) {
         o.get
      }
   }
	
   */
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addOrderCart</title>
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
		<h1>주문하기</h1>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/order/addOrderCartAction.jsp" method="post">
			
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
			<%
				int allTotalPrice = 0; // 전체 주문금액	
			
				for (int i = 0; i < cartNo.length; i += 1) { // 장바구니 목록 내 제품 개수만큼 반복
					for (int j = 0; j < selCart.length; j += 1) { // 선택된 제품 개수만큼 반복
						if (cartNo[i].equals(selCart[j])) { // 장바구니 번호와 체크된 체크박스의 번호가 일치하면
			%>
				<tr>
					<td><img src="<%=request.getContextPath()%>/pimg/<%=productImg[i]%>" width="100" height="100"></td>
					<td>
						<input type="hidden" name="productNo" value="<%=productNo[i]%>">
						<input type="hidden" name="cartNo" value="<%=cartNo[i]%>">
						<%=productName[i]%>
					</td>
					<td>
						<input type="hidden" name="productPrice" value="<%=productPrice[i]%>">
						<%=productPrice[i]%>원
					</td>
					<td>
						<input type="hidden" name="cartCnt" value="<%=cartCnt[i]%>">
						<%=cartCnt[i]%>
					</td>
					<td><%=myName%></td>
					<td><%=myAdd%>(최근 등록 주소)</td>
					<td>
						<input type="hidden" name="totalPrice" value="<%=totalPrice[i]%>">
						<%=totalPrice[i]%>원
					</td>
				</tr>
			<%
							allTotalPrice += Integer.parseInt(totalPrice[i]);
						}
					}
				} 
			%>
		</table>
		<div>
			총 합계 금액: <%=allTotalPrice%>원
		</div>
		
		사용할 포인트 입력: <input type="number" id="inputValue" placeholder="보유 포인트: <%=myPoint%>" name="point">	
		<!-- <button type="button" id="submitButton">입력</button> -->
		<div>
			<button type="submit">결제</button> 
		</div>
	</form>
	</body>
</html>