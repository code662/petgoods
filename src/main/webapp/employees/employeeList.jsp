<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%> 
<%
	// 로그인 되지 않은 사용자가 넘어왔을 경우
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
	
	// 로그인 세션 정보 변수에 저장
	Employees empVo = (Employees)session.getAttribute("loginId");
		
	// 현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// sql 메서드들이 있는 클래스의 객체 생성
	EmployeesDao empDao = new EmployeesDao();
	
	// 전체 해의 수
	int totalRow = empDao.selectEmployeesCnt();
	// 페이지 당 행의 수
	int rowPerPage = 5;
	// 시작 행 번호
	int beginRow = (currentPage-1) * rowPerPage;
	// 마지막 페이지 번호
	int lastPage = totalRow/ rowPerPage;
	// 추가하지 못한 행이 있을 경우 페이지 +1
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	// 현재 페이지에 표시 할 리스트
	ArrayList<Employees> list = empDao.selectEmployeesListByPage(beginRow, rowPerPage);
	
	// 페이징 수
	int pagePerPage = 5;
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
<title>사원 리스트</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
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
			employeeList
		</span>
	</div>
</div>
	
<!-- 사원 목록 -->
<form class="bg0 p-t-75 p-b-85">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
						<div class="flex-w flex-sb-m p-b-17">
							<h4 class="mtext-111 cl2  p-r-20">
								사원 리스트
							</h4>
						<%
							if(session.getAttribute("loginId") != null && 
								empVo.getEmpLevel().equals("2")){
						%>
								<span class="fs-18 cl11 stext-102 flex-w m-r--5">
									<a href="<%=request.getContextPath()%>/employees/addEmployee.jsp" class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
										<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-plus"></i>
											사원 추가
									</a>
								</span>
						<%		
							}
						%>
						</div>
						<br>
						
						<!-- 리다이렉션 메시지 -->
						<div>
						<%
						   if(request.getParameter("msg") != null){
						%>
								<p style="color: #F24182; font-weight:bolder;"><%=request.getParameter("msg") %></p>
						<%
						   }
						%>
						<br>
						</div>
						
						<table class="table-shopping-cart">
							<tr class="table_head" >
								<th class="column-1" style="width: 80px">번호</th>
								<th class="column-1">사원 ID</th>
								<th class="column-1">사원 이름</th>
								<th class="column-1">권한 등급</th>
								<th class="column-1">입사일</th>
							</tr>
						<%
							for(Employees employee : list) {
						%>
								<tr class="table_head" style="height: 100px">
									<td class="column-1" style="width: 80px"><%=employee.getEmpNo()%></td>
									<td class="column-1">
								<%
									if(session.getAttribute("loginId") != null && 
										empVo.getEmpLevel().equals("2")){
								%>
										<span class="fs-18 cl11 stext-102 flex-w m-r--5">
											<a href="<%=request.getContextPath()%>/employees/employeeOne.jsp?empNo=<%=employee.getEmpNo()%>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
												<%=employee.getId()%>
											</a>
										</span>
								<% 
									}else if(session.getAttribute("loginId") != null && 
										empVo.getEmpLevel().equals("1")){
								%>
										<%=employee.getId()%>
								<%
									}
								%>
									</td>
									<td class="column-1"><%=employee.getEmpName()%></td>
									<td class="column-1"><%=employee.getEmpLevel()%></td>
									<td class="column-1"><%=employee.getCreatedate().substring(0,10)%></td>
								</tr>
						<%		
							}
						%>
						</table>
						
						<!-- Pagination -->
						<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
						<%
							//이전 페이지 버튼
							if(minPage >1){
						%>
				  				<a href="<%=request.getContextPath()%>/employees/employeeList.jsp?currentPage=<%=minPage-pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
				  					이전 
				  				</a>
					   	<%
							}
					        for(int i = minPage; i <= maxPage; i++){
					        	if(i==currentPage){
					    %>
					    			<a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
					       				<%=i %>
					       			</a>
					    <%
					        	}else{
					   	%>
					       			<a href="<%=request.getContextPath()%>/employees/employeeList.jsp?currentPage=<%=i %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
					       				<%=i %>
					       			</a>
					    <%
					       		}
					        }
					    	//다음 페이지 버튼
					    	if(maxPage != lastPage){
					    %>
								<a href="<%=request.getContextPath()%>/employees/employeeList.jsp?currentPage=<%=minPage+pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
									다음
								</a>
						<%
							}
						%>
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