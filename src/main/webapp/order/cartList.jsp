<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	// 장바구니 리스트 - 세션 있는 경우, 없는 경우 분기
	// 메인에 inc 추가 (오른쪽 팝업) / 공통
	// 오른쪽 서브메뉴: address 상세 띄우기, 총합계금액 표시
	// 하단 결제하기 버튼 생성 (클릭 시 addOrder.jsp 이동) -> 링크로 처리
	
	// 로그인 전: 세션-장바구니(아이템) -> 세션에 아이템 있을 경우 cart DB에 저장(로그인 후)
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 상태이면 로그인된 사용자의 id값을 새 id 변수에 지정
 	String msg = "";
	String id = "";
 	if (session.getAttribute("loginId") != null) {
 		Customer customer = (Customer) session.getAttribute("loginId");
 		id = customer.getId();
 		System.out.println(id + " <-- id(cartList)");
 	}
	
	// model 
	CartDao cartDao = new CartDao();
	
	// ArrayList<Cart> list 생성 후 값 추가
	ArrayList<Cart> list = new ArrayList<>();
	list = cartDao.selectMyCart(id);
	
	// &cartCnt=$('input[name=cartCnt]').val();"
	System.out.println("==============cartList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cartList</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
		
	</head>
	<body>
		<div>
			<h1>장바구니</h1>
		</div>
		
		<%
			// 로그인 상태이면 cart 테이블에서 데이터 조회
			if (session.getAttribute("loginId") != null) {
				Customer customer = (Customer) session.getAttribute("loginId");
				if (request.getParameter("msg") != null) {
		%>
					<%=request.getParameter("msg")%>
		<%
				}
		%>
				<table border="1">
					<tr>
					   <!--  <th>번호</th> -->
						<th>상품이름</th>
						<th>가격</th>
						<th>수량</th>
						<th>총 금액</th>
						<th>수량 변경</th>
						<th>삭제</th>
					</tr>
		<%
				for (Cart c : list) {
				// 상품 이름 조회
				String productName = cartDao.selectProductName(c.getProductNo());
				// 상품 가격 조회
				int productPrice = cartDao.selectProductPrice(c.getProductNo());
				
				/* int cartCnt = 0;
				if (cartCnt >= 0) {
					cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
				} */
		
		%>
					<tr>
						<%-- <td><%=c.getCartNo()%></td> --%>
						<td>(이미지 추가)<%=productName%></td>
						<td><%=productPrice%></td>
						<td><%=c.getCartCnt()%></td>
						<td><%=productPrice * c.getCartCnt()%></td>
						<td><input type="number" id="cartCnt" value=""><a href="<%=request.getContextPath()%>/order/modifyCartAction.jsp?cartNo=<%=c.getCartNo()%>&cartCnt=4">수량 수정</a></td>
						<td><a href="<%=request.getContextPath()%>/order/removeCartAction.jsp?cartNo=<%=c.getCartNo()%>">삭제버튼</a></td>
					</tr>
		<%
		 		// 위 <input> 태그 하드코딩 부분 템플릿 적용 시 수정할 것 
					
				}
		%>
				</table>
				<a href="<%=request.getContextPath()%>/order/addOrder.jsp">결제하기</a>
		
		<%
			} else { // 로그인 상태가 아니면 세션에서 데이터 조회
		%>
				
		<%
			}
		%>
	</body>
</html>