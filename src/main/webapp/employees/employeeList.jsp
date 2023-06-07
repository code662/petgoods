<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%> 
<%
	//test용 아이디 저장
	Employees empVo = new Employees();
	empVo.setId("admin1");
	empVo.setEmpLevel("2");
	session.setAttribute("loginId", empVo);
	
	//로그인 되지 않은 사용자가 넘어왔을 경우
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
	//현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// sql 메서드들이 있는 클래스의 객체 생성
	EmployeesDao empDao = new EmployeesDao();
	
	// 전체 해의 수
	int totalRow = empDao.selectEmployeesCnt();
	// 페이지 당 행의 수
	int rowPerPage = 10;
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	// 마지막 페이지 번호
	int lastPage = totalRow/ rowPerPage;
	//추가하지 못한 행이 있을 경우 페이지 +1
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	// 현재 페이지에 표시 할 리스트
	ArrayList<Employees> list = empDao.selectEmployeesListByPage(beginRow, rowPerPage);
	
	// 페이징 수
	int pagePerPage = 10;
	// 최소 페이지
	int minPage = (currentPage-1) / pagePerPage * pagePerPage + 1;
	// 최대 페이지
	int maxPage = minPage + pagePerPage - 1;
	// 최대 페이지가 마지막 페이지 보다 크면 최대 페이지 = 마지막 페이지
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container">
	<h1>사원 리스트</h1>
	<%
		
		if(session.getAttribute("loginId") != null && 
		empVo.getEmpLevel().equals("2")){
	%>
			<div class="d-grid">
				<a href="<%=request.getContextPath()%>/employees/addEmployee.jsp">
					<button type="button" class="btn btn-dark btn-block">추가</button>
				</a>
			</div>
	<%		
		}
	%>
		<table class="table table-bordered">
			<tr>
				<th class="table-dark">번호</th>
				<th class="table-dark">사원 ID</th>
				<th class="table-dark">사원 이름</th>
				<th class="table-dark">사원 레벨</th>
				<th class="table-dark">입사 날짜</th>
			</tr>
			<%
				for(Employees employee : list) {
			%>
					<tr>
						<td><%=employee.getEmpNo()%></td>
						<td>
							<a href="<%=request.getContextPath()%>/employees/employeeOne.jsp?empNo=<%=employee.getEmpNo()%>">
								<%=employee.getId()%>
							</a>
						</td>
						<td><%=employee.getEmpName()%></td>
						<td><%=employee.getEmpLevel()%></td>
						<td><%=employee.getCreatedate().substring(0,10)%></td>
					</tr>
			<%		
				}
			%>
		</table>

	<%	
		// 이전 페이지
		// 최소 페이지가 1보타 클 경우 이전 페이지 표시
		if(minPage>1) {
	%>
			<a href="<%=request.getContextPath()%>/employees/employeeList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>
	<%			
		}
		// 최소 페이지부터 최대 페이지까지 표시
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage) {	// 현재페이지는 링크 비활성화
	%>	
			<%=i%>
	<%			
			}else {					// 현재페이지가 아닌 페이지는 링크 활성화
	%>	
				<a href="<%=request.getContextPath()%>/employees/employeeList.jsp?currentPage=<%=i%>"><%=i%></a>
	<%				
			}
		}
		// 다음 페이지
		// 최대 페이지가 마지막 페이지와 다를 경우 다음 페이지 표시
		if(maxPage != lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/teacher/teacherListjsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
	<%	
		}
	%>
	</div>
</body>
</html>