<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>   
<%@ page import="java.net.*"%>   

<%
	// 메인 카테고리
	// 메인 카테고리에서 타이틀 클릭 시 서브 카테고리로 이동
	
	// 카테고리 추가 - 리스트 위에 버튼 노출(메인, 서브)
	// 타이틀 옆에 수정, 삭제 버튼 노출 (메인, 서브)
	// 카테고리 안에 상품이 있을 경우 수정, 삭제 불가
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
		
	// 세션 유효성 검사 - 로그인 상태가 아니면 home.jsp로 리다이렉션
	String id = "";
	if (session.getAttribute("loginId") == null) {
		response.sendRedirect(request.getContextPath()+ "/home.jsp");
		return;
	} else { // 관리자 로그인 시 로그인된 사용자의 id값을 새 id 변수에 지정
		Employees employee = (Employees) session.getAttribute("loginId");
		id = employee.getId();
		System.out.println(id + " <-- id(orderList)");
	}

	// CategoryDao 클래스 객체 생성 -> SQL 메소드 이용
	CategoryDao cateDao = new CategoryDao();
	
	// ArrayList<Category> list 생성 후 값 추가
	ArrayList<Category> list = new ArrayList<>();
	list = cateDao.selectMainCategory();

	System.out.println("==============mainCategoryList.jsp==============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>mainCategoryList</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		
		<!-- breadcrumb -->
		<div class="container">
			<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
				<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<span class="stext-109 cl4">
					mainCategoryList
				</span>
			</div>
		</div>
		
	   <form class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-11 col-xl-11 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<h4 class="mtext-111 cl2 p-b-30">
									메인 카테고리 리스트
								</h4>
								<br>
							
						
		<%
			if (request.getParameter("msg") != null) {
		%>
				<p style="color: #F24182; font-weight:bolder;"><%=request.getParameter("msg")%></p>
		<%
			}
		%>
		<table class="center">
 		   	<colgroup>
		     	<col width="10%">
		     	<col width="20%">
		     	<col width="30%">
		     	<col width="30%">
	   		 </colgroup> 
   		 	<tr class="bor12" height="40">
				<th class="p-l-30">NO.</th>
				<th class="p-l-50">메인 카테고리</th>
				<!-- <th>서브 카테고리</th> -->
				<th class="p-l-150">생성일자</th>
				<th class="p-l-150">수정일자</th>
			<!-- 	<th></th>
				<th></th> -->
			</tr>
		<%
			for (Category c : list) {
		%>
			<!-- <div class="flex-w flex-t bor12 p-b-13" -->
			<%
				String categoryMainName = URLEncoder.encode(c.getCategoryMainName(), "UTF-8"); 
			%>
					
					<tr class="bor12" height="50">
						<td class="stext-112 cl8 p-l-30" style="font-size:17px; width: 30px"><%=c.getCategoryNo()%></td>
						<td class="stext-112 cl8 p-l-30" style="font-size:17px;">
							<a href="<%=request.getContextPath()%>/product/subCategoryList.jsp?categoryMainName=<%=categoryMainName%>" style="color: #747474" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
								<%=c.getCategoryMainName()%>
							</a>
						</td>
					<%-- 	<td class="stext-112 cl8" style="font-size:17px;"><%=c.getCategorySubName()%></td> --%>
						<td class="stext-112 cl8 p-l-100" style="font-size:17px;"><%=c.getCreatedate()%></td>
						<td class="stext-112 cl8 p-l-100" style="font-size:17px;"><%=c.getUpdatedate()%></td>
					<%-- 	<td class="stext-112 cl8" style="font-size:17px;">
							<a href="<%=request.getContextPath()%>/product/modifyCategory.jsp?categoryNo=<%=c.getCategoryNo()%>" style="color: #747474; width:80px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
								수정
							</a>
						</td>
						<td class="stext-112 cl8" style="font-size:17px;">
							<a href="<%=request.getContextPath()%>/product/removeCategory.jsp?categoryNo=<%=c.getCategoryNo()%>" style="color: #747474; width:80px;" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
								삭제
							</a>
						</td> --%>
					</tr>
		<%
			}
		%>
			</table> 
			<br>
			<div class="flex-w dis-inline-block">
				
					<a href="<%=request.getContextPath()%>/product/addCategory.jsp" style="color: #333333">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-plus"></i>
							새 카테고리 추가						
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