<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
	// 카테고리 수정 폼
	// 카테고리 안에 상품이 있는 경우 수정 불가
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값 (CategoryDao 내 상세 정보 메소드 요청값 -> category_no) 유효성 확인
	// 카테고리 번호 값 없을 시 메인 카테고리 목록으로 이동
	if (request.getParameter("categoryNo") == null
	|| request.getParameter("categoryNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/product/mainCategoryList.jsp");
		return;
	}
	
	// 요청값 디버깅
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	System.out.println(categoryNo + " <-- categoryNo(modifyCategory)");
	
	// CategoryDao 클래스 객체 생성 -> SQL 메소드 이용
	CategoryDao cateDao = new CategoryDao();
	Category category = new Category();
	category = cateDao.selectCategoryOne(categoryNo);
	
	// 해당 메인-서브 카테고리 내 존재하는 상품 개수 확인
	int cnt = cateDao.productCnt(categoryNo);
	System.out.println(cnt + " <-- cnt(modifyCategory)");
			
	System.out.println("==============modifyCategory.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modifyCategory</title>
	</head>
	<body>
	<!-- cnt가 0 (메인-서브 카테고리 내 상품이 없는 경우)인 경우에만 입력폼 출력 -->
	<%
		if (cnt == 0) {
	%>
		<div>
			<h1>카테고리 정보 수정</h1>
		</div>
		<form action="<%=request.getContextPath()%>/product/modifyCategoryAction.jsp" method="post">
			<input type="hidden" name="categoryNo" value="<%=category.getCategoryNo()%>">
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
			<table border="1">
				<tr>
					<th>카테고리 번호</th>
					<td><%=category.getCategoryNo()%></td>
				</tr>
				<tr>
					<th>메인 카테고리명</th>
					<td>
						<input type="text" name="categoryMainName" value="<%=category.getCategoryMainName()%>">
					</td>
				</tr>
				<tr>
					<th>서브 카테고리명</th>
					<td>
						<input type="text" name="categorySubName" value="<%=category.getCategorySubName()%>">
					</td>
				</tr>
			</table>
			<button type="submit">카테고리 수정</button>
		</form>
	<%	
		} else { // 값이 있는 경우 삭제 불가
	%>	
			<h4>상품이 존재하는 카테고리입니다. 변경할 수 없습니다.</h4>
			<h4><%=category.getCategoryMainName()%>-<%=category.getCategorySubName()%> 내 상품 개수: <%=cnt%></h4>
			<a href="<%=request.getContextPath()%>/product/mainCategoryList.jsp">메인 카테고리로</a>
	<%
		}
	%>
	</body>
</html>