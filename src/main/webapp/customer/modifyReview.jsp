<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";	
	
	// 세션 유효성 검사
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	// 디버깅
	System.out.println(PURPLE + id + " <--id modifyReview" + RESET);
	
	// 요청값 유효성 검사
	if(request.getParameter("reviewNo") == null 
			|| request.getParameter("reviewNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/myPage.jsp");
		return;
	}
	
	// 요청값 변수에 저장
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	// 디버깅
	System.out.println(PURPLE + reviewNo + " <--reviewNo modifyReview" + RESET);
	
	// 리뷰상세정보 조회
	ReviewDao rd = new ReviewDao();
	Review review = rd.selectReviewOne(reviewNo);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰수정</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/customer/modifyReviewAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="reviewNo" value="<%=review.getReviewNo() %>">
		<table>
			<tr>
				<th>주문번호</th>
				<td>
					<input type="text" name="orderNo" value="<%=review.getOrderNo() %>" style="border:none" readonly="readonly"> 
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="reviewTitle" value="<%=review.getReviewTitle() %>"> 
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="3" cols="50" name="reviewContent"><%=review.getReviewContent() %></textarea>
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
					<button type="submit">리뷰수정</button>
				</td>
				<!-- <td></td> -->
			</tr>
		</table>
	</form>
</body>
</html>