<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>   
<%
	// 전체 고객 주문 리스트 (관리자 로그인 상태에서 볼 수 있는 리스트)
	// 필터 : 아이디, 상태, 날짜 (기본정렬 주문일자 최신순)
	// 아이디 검색 / 주문상태 선택 / 날짜 범위 선택
	// 필터 부분 추후 Dao로 옮기기
	
	// 주문상태 수정 -> 옵션 : 결제완료 / 취소 / 배송완료 / 구매확정 -> modifyOrderStatusAction.jsp 파일에서 실행

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	/* // 필터(ID, 주문상태, 날짜 범위) 파라미터값
	System.out.println("searchWord param: " + request.getParameter("searchWord") + " <-- orderList");
	System.out.println("orderStatus param: " + request.getParameter("orderStatus") + " <-- orderList");
	System.out.println("beginYear param: " + request.getParameter("beginYear") + " <-- orderList");
	System.out.println("endYear param: " + request.getParameter("endYear") + " <-- orderList"); */

	// 넘어온 ckMonth 값 String 배열에 저장
	String[] ckMonth = request.getParameterValues("ckMonth"); // 다중값 매개변수 저장
	
	// ckMonth값들을 정수로 변환해서 담을 배열 생성
	int[] intCkMonth = null;
	
	// checkbox에 반영하기 위한 배열 -> 각 월 값들이 포함되어 있는지 확인 여부 저장
	boolean[] isChecked = new boolean[13];
	
	// 넘어온 값 체크
	if (request.getParameterValues("ckMonth") != null) {
		for (String s : request.getParameterValues("ckMonth")) {
			System.out.println(s + "ckMonth(orderList)");
		}
	}
	
	// ckMonth에 넘어온 값이 있으면 변환하여 정수 배열에 추가
	if (ckMonth != null) {
		intCkMonth = new int[ckMonth.length];
		for (int i = 0; i < intCkMonth.length; i++) {
			intCkMonth[i] = Integer.parseInt(ckMonth[i]);
			// 넘어온 값에 해당하는 인덱스 번호에 true 입력
			isChecked[intCkMonth[i]] = true;
		}
	}
	
	// ID 검색값 초기화 -> null 아닌 값이 넘어올 경우 저장
	String searchWord = "";
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	// 주문상태 선택값 초기화 -> null 아닌 값이 넘어올 경우 저장
	String orderStatus = "";
	if (request.getParameter("orderStatus") != null) {
		searchWord = request.getParameter("orderStatus");
	}
	
	// 최소 년도: 임의의 값 설정 (2020)
	int beginYear = 2020;
	if (request.getParameter("beginYear") != null) {
		beginYear = Integer.parseInt(request.getParameter("beginYear"));
	}
	
	// 최대 년도: 임의의 값 설정 (2023)
	int endYear = 2023;
	if (request.getParameter("beginYear") != null) {
		beginYear = Integer.parseInt(request.getParameter("beginYear"));
	}
	
	// 디버깅
	System.out.println(searchWord + " <-- searchWord(orderList)");
	System.out.println(orderStatus + " <-- orderStatus(orderList)");
	System.out.println(beginYear + " <-- beginYear(orderList)");
	System.out.println(endYear + " <-- endYear(orderList)");

	// OrdersDao 클래스 객체 생성 -> SQL 메소드 이용
	OrdersDao ordersDao = new OrdersDao();

	// 현재 페이지 번호
	// currentPage가 null값이 아니면서 공백값이 아닌 경우 (유효값이 있는 경우)가 아닐 시 기본 1페이지 설정
	int currentPage = 1;
	if (request.getParameter("currentPage") != null
	&& !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(orderList)");
	
	// 페이징 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호(beginRow) - 0, 10, 20, ...
	// ... LIMIT (beginRow, rowPerPage)
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행 수 
	int totalRow = ordersDao.selectOrdersCnt();
	
	// 마지막 페이지 번호
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	
	System.out.println(totalRow + " <-- totalRow(orderList)");
	System.out.println(lastPage + " <-- lastPage(orderList)");
	
	// [이전] [다음] 탭 사이 출력 행 수 
	int pagePerPage = 5;
	
	// [이전] 1 2 3 4 5 [다음]
	// [이전] 6 7 8 9 10 [다음]
	// [이전] 11 12 13 14 15 [다음]	
			
	// [이전] [다음] 탭 사이 최소, 최대값
	int minPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage - 1);
	
	// maxPage가 lastPage보다 클 수 없음
	if (maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	// DB연결
    Class.forName("org.mariadb.jdbc.Driver");
    String driver = "jdbc:mariadb://127.0.0.1:3306/employees";
    String dbUser = "root";
    String dbPw = "java1234";
    Connection conn = DriverManager.getConnection(driver, dbUser, dbPw);
   
    String sql = "";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ArrayList<Orders> list 생성 후 값 추가
	ArrayList<Orders> list = new ArrayList<>();	
	list = ordersDao.selectTotalOrders(beginRow, rowPerPage);
	
	System.out.println("==============orderList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>orderList</title>
	</head>
	<body>
		<div>
			<h1>전체 고객 주문 리스트</h1>
		</div>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		
		<!-- 요청 폼 -->
		<form action="<%=request.getContextPath()%>/order/orderList.jsp" method="get">
			<label>ID 검색 : </label>
			
			<label>주문상태 : </label>
			<select name="orderStatus">
				<option value="">선택</option>
				<option value="결제완료">결제완료</option>
				<option value="주문취소">주문취소</option>
				<option value="배송완료">배송완료</option>
				<option value="구매확정">구매확정</option>
			</select>		
			<button type="submit">검색</button>
		</form>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>상품번호</th>
				<th>ID</th>
				<th>주문상태</th>
				<th>주문수량</th>
				<th>가격</th>
				<th>합계금액</th>
				<th>주문일자</th>
				<th>수정일자</th>
			</tr>
		<%
			for (Orders o : list) {
		%>
			<tr>
				<td><%=o.getOrderNo()%></td>
				<td><%=o.getProductNo()%></td>
				<td><%=o.getId()%></td>
				
		<%
			if (o.getOrderStatus().equals("결제완료")) { // 주문상태가 결제완료인 경우 링크 클릭하면 배송완료로 상태 변경
		%>	
		  		<td><a href="<%=request.getContextPath()%>/order/modifyOrderStatusAction.jsp?orderNo=<%=o.getOrderNo()%>&createdate=<%=o.getCreatedate()%>">결제완료</a></td>
		<%
			} else {
		
		%>
				<td><%=o.getOrderStatus()%></td>
		<%
			}
		%>		
				<td><%=o.getOrderCnt()%></td>
				<td><%=o.getOrderPrice()%>원</td>
				<td><%=o.getOrderPrice() * o.getOrderCnt()%>원</td>
				<td><%=o.getCreatedate()%></td>
				<td><%=o.getUpdatedate()%></td>
			</tr>
		<%
			}
		%>
		</table>
		
		<%
			// minPage가 1보다 클 때만 [이전] 탭 출력
			if (minPage > 1) {
		%>	
				<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=minPage - pagePerPage%>">이전</a>
		<%
			}
		%>
		
		<%
			// [이전] [다음] 탭 내에서 반복
			for (int i = minPage; i <= maxPage; i++) {
				if (currentPage == i) { // 해당 페이지는 링크 없이 표시 (css 적용 전)
		%>
					<span><%=i%></span>
		<% 			
				} else { // 현재 페이지가 아닌 나머지 페이지에는 번호를 링크로 표시 (클릭 시 해당 번호 페이지로 이동)
		%>
					<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
				}
			}
		
			if (maxPage < lastPage) { // [이전] [다음] 탭 사이 가장 큰 숫자가 마지막 페이지보다 작을 때만 [다음] 버튼 생성	
		%>
				<a href="<%=request.getContextPath()%>/order/orderList.jsp?currentPage=<%=minPage + pagePerPage%>">다음</a>
		<%
			}
		%>
	</body>
</html>