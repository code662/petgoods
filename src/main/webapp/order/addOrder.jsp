<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %> 
    
<% 
	// 제품 상세페이지에서만 작동하게 될 이슈 (장바구니에서는 어떻게?)

	// 주문하기 폼 (shopping cart.html 파일에서 분리 예정 -> 그대로 갈 수도)
	// 상품 이름, 상품이미지, 상품 가격, 상품 개수, 총 주문금액, 주문인 이름, 배송지(가장 최근에 등록한 배송지), 
	// 버튼: 포인트 (사용가능 포인트 표시, 사용할 포인트 입력), 결제

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 검사 (상품이미지, 상품이름, 상품 가격, 상품 개수)
	// 하나라도 null 값이 있다면 홈으로 리다이렉트
/* 	
	if (request.getParameter("productImg") == null
	|| request.getParameter("productName") == null
	|| request.getParameter("productPrice") == null
	|| request.getParameter("orderCnt") == null) {
		System.out.println("유효성 검사 확인(addOrder)");
		response.sendRedirect(request.getContextPath() + "/home.jsp");
	}
	
	// 요청값
	String productImg = request.getParameter("productImg");
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt")); */
	
	// request.getParameterValues();
	
	String[] productImg = request.getParameterValues("productImg");
	
	// 테스트용 값
	// String productImg = "시저 독 닭고기 캔 100g.jpeg";
	String productName = "습식1";
	int productPrice = 10000;
	int orderCnt = 1;
	
	
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
	
	
	System.out.println("==============addOrder.jsp==============");
	
	// 
	
	// productOne.jsp에서 넘어온 주문, 카트에서 넘어온 주문
	
	// 여러 상품 주문 불가능 이슈:
	// 주문 여러 상품 받을 때 requestParameterValues() 로 받음
	// 주문넘버 = {"1", "2", "3", ...} 과 같은 형태
	// for (String s : order) {} ... 배열 생성
	// 배열 내부에 주문 메소드
	// 한 번에 여러 상품 주문이 가능하나 주문코드는 다르게 찍힘
	
	// request.getParameterValues() -> 사용?
	
	// 상품번호, 수량, 
	// 상품 이름, 상품이미지, 상품 가격, 상품 개수, 총 주문금액, 주문인 이름, 배송지(가장 최근에 등록한 배송지), 
	// 버튼: 포인트 (사용가능 포인트 표시, 사용할 포인트 입력), 결제
	
	
	
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
		<title>addOrder</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	</head>
	<body>
		<h1>주문하기</h1>
		<form action="<%=request.getContextPath()%>/order/addOrderAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>상품이미지</th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>가격</th>
					<th>주문인 이름</th>
					<th>배송지</th>
					<th>합계금액</th>
				</tr>
			<%
				// for () {}
			%>
			
			<%
			
			%>
				<tr>
					<td><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
					<td><%=productName%></td>
					<td><%=productPrice%>원</td>
					<td><%=orderCnt%></td>
					<td><%=myName%></td>
					<td><%=myAdd%>(최근 등록 주소)</td>
					<td><%=productPrice * orderCnt%>원</td>
				
				</tr>
			
			
				<%-- <tr>
					<th>상품이미지</th>
					<td><img src="<%=request.getContextPath()%>/pimg/<%=productImg%>" width="100" height="100"></td>
				</tr>
				<tr>
					<th>상품이름</th>
					<td><%=productName%></td>
				</tr>
				<tr>
					<th>상품가격</th>
					<td><%=productPrice%>원</td>
				</tr>
				<tr>
					<th>개수</th>
					<td><%=orderCnt%></td>
				</tr>
				<tr>
					<th>주문인 이름</th>
					<td><%=myName%></td>
				</tr>
				<tr>
					<th>배송지</th>
					<td><%=myAdd%>(최근 등록 주소)</td>
				</tr>
				<tr>
					<th>합계금액</th>
					<td><%=productPrice * orderCnt%>원</td>
				</tr> --%>
		
		</table>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%		
			}
		%>
		사용할 포인트 입력: <input type="text" placeholder="보유 포인트: <%=myPoint%>" name="point">	
		<div>
			<button type="submit">결제</button> 
		</div>
	</form>
	</body>
</html>