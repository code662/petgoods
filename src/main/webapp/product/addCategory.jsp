<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %> 
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	System.out.println("==============addCategory.jsp==============");
%>
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addCategory</title>
	</head>
	<body>
		<div>
			<h1>새 카테고리 입력</h1>
		</div>
		<% 
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg") %>
		<%
			}
		%>
		<form action="<%=request.getContextPath()%>/product/addCategoryAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>메인 카테고리명</th>
					<td>
						<input type="text" name="categoryMainName">
					</td>
				</tr>
				<tr>
					<th>서브 카테고리명</th>
					<td>
						<input type="text" name="categorySubName">
					</td>
				</tr>
			</table>
			<button>카테고리 추가</button>
		</form>
	</body>
</html>