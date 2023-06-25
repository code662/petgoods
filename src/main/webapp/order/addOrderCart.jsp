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
	// 하나라도 null 값이 있다면 cartList.jsp 로 리다이렉트
 	
	String msg = "";
	if (request.getParameterValues("cartNo") == null
	|| request.getParameterValues("productNo") == null
	|| request.getParameterValues("productImg") == null
	|| request.getParameterValues("productName") == null
	|| request.getParameterValues("productPrice") == null
	|| request.getParameterValues("cartCnt") == null
	|| request.getParameterValues("totalPrice") == null
	|| request.getParameterValues("selCart") == null) {
		System.out.println("유효성 검사 확인(addOrderCart)");
		msg = URLEncoder.encode("체크박스 선택 후 주문 가능합니다.", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
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
				System.out.println(cartNo[i] + " <-- cartNo(addOrderCart)"); // 카트번호
				System.out.println(productNo[i] + " <-- productNo(addOrderCart)"); // 상품번호
				System.out.println(productImg[i] + " <-- productImg(addOrderCart)"); // 이미지 이름
				System.out.println(productName[i] + " <-- productName(addOrderCart)"); // 상품 이름
				System.out.println(cartCnt[i] + " <-- cartCnt(addOrderCart)"); // 수량
				System.out.println(productPrice[i] + " <-- productPrice(addOrderCart)"); // 상품 가격
				System.out.println(totalPrice[i] + " <-- totalPrice(addOrderCart)"); // 총 가격
				
				if (Integer.parseInt(cartCnt[i]) == 0) {
					msg = URLEncoder.encode("1개 이상의 수량을 입력해주세요.", "UTF-8"); 
					response.sendRedirect(request.getContextPath() + "/order/cartList.jsp?msg=" + msg);
					return;
				}
			}
		}
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
		<jsp:include page="/inc/link.jsp"></jsp:include>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
	<%-- 		$(document).ready(function(){
				const urlParams  = new URL(location.href).searchParams;
				const msg = urlParams.get('msg');
				if (msg != null) {
					alert(msg);
				}
				
				const myPoint = <%=myPoint%>;
				$('#btn').click(function(){
					if ($('#inputValue').val() > myPoint || $('#inputValue').val() < 0) {
						alert('유효값(0 ~ ' + myPoint + ')을 입력해주세요.');
					} else {
						$('#addOrderCart').submit();
					}
				});
				
				const myPoint = <%=myPoint%>;
				$('#btn').keyup(function(){
					if ($('#inputValue').val() > myPoint || $('#inputValue').val() < 0) {
						alert('유효값(0 ~ ' + myPoint + ')을 입력해주세요.');
					} else {
						$('#addOrderCart').submit();
					}
				});
			}); --%>
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
				      $('#addOrderCart').submit();
				    }
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
					cartList
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</span>
				<span class="stext-109 cl4">
					addOrderCart
				</span>
			</div>
		</div>
		
		<form action="<%=request.getContextPath()%>/order/addOrderCartAction.jsp" method="post" class="bg0 p-t-75 p-b-85" id="addOrderCart">
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
								<%
									int allTotalPrice = 0; // 전체 주문금액	
								
									for (int i = 0; i < cartNo.length; i += 1) { // 장바구니 목록 내 제품 개수만큼 반복
										for (int j = 0; j < selCart.length; j += 1) { // 선택된 제품 개수만큼 반복
											if (cartNo[i].equals(selCart[j])) { // 장바구니 번호와 체크된 체크박스의 번호가 일치하면
								%>
									<tr class="table_head">
										<td class="text-center">
											<input type="hidden" name="productImg" value="<%=productImg[i]%>">
											<img src="<%=request.getContextPath()%>/pimg/<%=productImg[i]%>" width="100" height="100">
										</td>
										<td class="text-center">
											<input type="hidden" name="productNo" value="<%=productNo[i]%>">
											<input type="hidden" name="cartNo" value="<%=cartNo[i]%>">
											<input type="hidden" name="productName" value="<%=productName[i]%>">
											<%=productName[i]%>
										</td>
										<td class="text-center">
											<input type="hidden" name="productPrice" value="<%=productPrice[i]%>">
											<%=productPrice[i]%>원
										</td>
										<td class="text-center">
											<input type="hidden" name="cartCnt" value="<%=cartCnt[i]%>">
											<%=cartCnt[i]%>
										</td>
										<td class="text-center"><%=myName%></td>
										<td class="text-center"><%=myAdd%></td>
										<td class="text-center">
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
							<br>
							<div style="text-align: right;">
								총 합계 금액: <%=allTotalPrice%>원
							</div>
					<%-- 		사용할 포인트 입력: <input type="number" id="inputValue" placeholder="보유 포인트: <%=myPoint%>" name="point" class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5">	
							<div>
								<button type="submit">결제</button> 
							</div> --%>
							
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