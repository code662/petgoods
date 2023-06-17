<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="java.sql.*" %>   --%> 
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>   
<%@ page import="java.net.*"%>  

<%
	// 서브 카테고리
	// 메인 카테고리에서 타이틀 클릭 시 서브 카테고리로 이동
	
	// 카테고리 추가 - 리스트 위에 버튼 노출(메인, 서브)
	// 타이틀 옆에 수정, 삭제 버튼 노출 (메인, 서브)
	// 카테고리 안에 상품이 있을 경우 수정, 삭제 불가
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 유효성 검사 
	if (request.getParameter("categoryMainName") == null
	|| request.getParameter("categoryMainName").equals("")) { 
		response.sendRedirect(request.getContextPath() + "/product/mainCategoryList.jsp");
		return;
	}
	String categoryMainName  = request.getParameter("categoryMainName");
	System.out.println(categoryMainName + " <-- categoryMainName(subCategoryList)");

	// CategoryDao 클래스 객체 생성 -> SQL 메소드 이용
	CategoryDao cateDao = new CategoryDao();
	
	// ArrayList<Category> list 생성 후 값 추가
	ArrayList<Category> list = new ArrayList<>();
	list = cateDao.selectSubCategory(categoryMainName);

	System.out.println("==============subCategoryList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>subCategoryList</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
		<jsp:include page="/inc/sidebar.jsp"></jsp:include>
		<jsp:include page="/inc/cart.jsp"></jsp:include>
			
  	 	<form class="bg0 p-t-75 p-b-85">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-11 col-xl-11 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<h4 class="mtext-111 cl2 p-b-30">
								카테고리 리스트(서브)
							</h4>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<table class="center">
			<colgroup>
		     	<col width="5%">
		     	<col width="10%">
		     	<col width="15%">
		     	<col width="20%">
		     	<col width="20%">
		     	<col width="10%">
		     	<col width="10%">
	   		 </colgroup>
	 		<tr class="bor12" height="40">
				<th>NO.</th>
				<th>메인 카테고리</th>
				<th>서브 카테고리</th>
				<th>생성일자</th>
				<th>수정일자</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<%
			for (Category c : list) {
		%>
				<tr class="bor12">
					<td class="stext-112 cl8" style="font-size:17px;"><%=c.getCategoryNo()%></td>
					<td class="stext-112 cl8" style="font-size:17px;"><%=c.getCategoryMainName()%></td>
					<td class="stext-112 cl8" style="font-size:17px;"><%=c.getCategorySubName()%></td>
					<td class="stext-112 cl8" style="font-size:17px;"><%=c.getCreatedate().substring(0, 10)%></td>
					<td class="stext-112 cl8" style="font-size:17px;"><%=c.getCreatedate().substring(0, 10)%></td>
					<td class="stext-112 cl8" style="font-size:17px;">
						<a href="<%=request.getContextPath()%>/product/modifyCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">
							수정
						</a>
					</td>
					<td class="stext-112 cl8" style="font-size:17px;">
						<a href="<%=request.getContextPath()%>/product/removeCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">
							삭제
						</a>
					</td>
				</tr>
	 	<%
			}
		%>
		</table>
		<br>
		<div class="flex-w dis-inline-block">
			<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
				<a href="<%=request.getContextPath()%>/product/mainCategoryList.jsp" style="color: #333333">
					메인 카테고리로
				</a>
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