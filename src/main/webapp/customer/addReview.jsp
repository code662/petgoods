<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";	
	
	// 세션 유효성 검사
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	// 요청값 유효성 검사
	if(request.getParameter("orderNo") == null 
			|| request.getParameter("orderNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myOrderList.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println(PURPLE + orderNo + " <--id addReview" + RESET);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰등록</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/customer/addReviewAction.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>주문번호</th>
				<td>
					<input type="text" name="orderNo" value="<%=orderNo %>" style="border:none" readonly="readonly"> 
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="reviewTitle"> 
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="3" cols="50" name="reviewContent"></textarea>
				</td>
			</tr>
			<tr>
				<th>파일</th>
				<td>
					<input type="file" name="reviewImg" required="required"> 
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">리뷰등록</button>
				</td>
				<!-- <td></td> -->
			</tr>
		</table>
	</form>
</body>
</html>