<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="java.sql.*" %>   --%> 
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>   

<%
	// 메인 카테고리, 서브 카테고리 분리
	// 메인 카테고리에서 타이틀 클릭 시 서브카테고리로 이동
	
	// 카테고리 추가 - 리스트 위에 버튼 노출(메인, 서브)
	// 타이틀 옆에 수정, 삭제 버튼 노출 (메인, 서브)
	// 카테고리 안에 상품이 있을 경우 수정, 삭제 불가
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// OrdersDao 클래스 객체 생성 -> SQL 메소드 이용
	CategoryDao cateDao = new CategoryDao();
	
	// ArrayList<Category> list 생성 후 값 추가
	ArrayList<Category> list = new ArrayList<>();
	list = cateDao.selectMainCategory();

	System.out.println("==============categoryList.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
	</head>
	<body>
		<div>
			<h1><a href="">카테고리 리스트(메인))</a></h1>
		</div>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<table border="1">
			<tr>
				<th>addressNo</th>
				<th>메인 카테고리명</th>
				<th>서브 카테고리명</th>
				<th>생성일자</th>
				<th>수정일자</th>
			</tr>
		<%
			for (Category c : list) {
		%>
				<tr>
					<td><%=c.getCategoryNo()%></td>
				</tr>
		<%
			}
		%>
		
		</table>
	</body>
</html>