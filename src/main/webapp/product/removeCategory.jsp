<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
	// 카테고리 삭제 폼
	// 카테고리 안에 상품이 있는 경우 삭제 불가
	
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
	System.out.println(categoryNo + " <-- categoryNo(removeCategory)");
	
	// CategoryDao 클래스 객체 생성 -> SQL 메소드 이용
	CategoryDao cateDao = new CategoryDao();
	Category category = new Category();
	category = cateDao.selectCategoryOne(categoryNo);
	
	System.out.println("==============removeCategory.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeCategory</title>
	</head>
	<body>
		<div>
			<h1>카테고리 정보 삭제</h1>
		</div>
		<form action="<%=request.getContextPath()%>/product/removeCategoryAction.jsp" method="post">
			<input type="hidden" name="categoryNo" value="<%=category.getCategoryNo()%>">
			<table border="1">
				<tr>
					<th>카테고리 번호</th>
					<td><%=category.getCategoryNo()%></td>
				</tr>
				<tr>
					<th>메인 카테고리명</th>
					<td><%=category.getCategoryMainName()%></td>
				</tr>
				<tr>
					<th>서브 카테고리명</th>
					<td><%=category.getCategorySubName()%></td>
				</tr>
				<tr>
					<th>생성일자</th>
					<td><%=category.getCreatedate()%></td>
				</tr>
				<tr>
					<th>수정일자</th>
					<td><%=category.getUpdatedate()%></td>
				</tr>
			</table>
			<button type="submit">카테고리 삭제</button>
		</form>
	</body>
</html>