<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>   
<%@ page import="java.net.*"%>   

<%
	// 메인 카테고리, 서브 카테고리 분리
	// 메인 카테고리에서 타이틀 클릭 시 서브카테고리로 이동
	
	// 카테고리 추가 - 리스트 위에 버튼 노출(메인, 서브)
	// 타이틀 옆에 수정, 삭제 버튼 노출 (메인, 서브)
	// 카테고리 안에 상품이 있을 경우 수정, 삭제 불가
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

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
	</head>
	<body>
		<div>
			<h1>카테고리 리스트(메인)</h1>
		</div>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<div>
			<a href="<%=request.getContextPath()%>/product/addCategory.jsp">새 카테고리 입력</a>
		</div>
		
		<table border="1">
			<tr>
				<th>카테고리 번호</th>
				<th>메인 카테고리명</th>
				<th>서브 카테고리명</th>
				<th>생성일자</th>
				<th>수정일자</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<%
			for (Category c : list) {
		%>
				<tr>
					<td><%=c.getCategoryNo()%></td>
		<%
					String categoryMainName = URLEncoder.encode(c.getCategoryMainName(), "UTF-8"); 
		%>
					<td><a href="<%=request.getContextPath()%>/product/subCategoryList.jsp?categoryMainName=<%=categoryMainName%>"><%=c.getCategoryMainName()%></a></td>
					<td><%=c.getCategorySubName()%></td>
					<td><%=c.getCreatedate()%></td>
					<td><%=c.getUpdatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/product/modifyCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/product/removeCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
				</tr>
		<%
			}
		%>
		</table>
	</body>
</html>