<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%> 
<%
	 int empNo = Integer.parseInt(request.getParameter("empNo")); 
	//sql 메서드들이 있는 클래스의 객체 생성
	EmployeesDao empDao = new EmployeesDao();

	//현재 페이지에 표시 할 리스트
	
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>사원 상세정보</h3>
	<form action="<%=request.getContextPath()%>/employees/modifyEmployee.jsp" method="post">
		<table>
			<tr>
				<th>사원 번호</th>
				<td><%= %></td>
			</tr>
		</table>
	</form>
</body>
</html>