<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";	
	
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	// 디버깅
	System.out.println(PURPLE + id + " <--id reviewList" + RESET);
	
	// 페이징 
	int currentPage = 1; // 시작 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // 한페이지에 출력할 게시물 수
	int beginRow = (currentPage -1)*rowPerPage; // 한페이지에 출력될 첫번째 행 번호
	
	ReviewDao rd = new ReviewDao(); // Dao 객체 생성
	int totalRow = rd.reviewCnt(id); // 전체 행 수

	int lastPage = totalRow / rowPerPage; //마지막페이지
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	if(totalRow < currentPage){
		currentPage = lastPage;
	}
	
	int pagePerPage = 5; // 한번에 출력될 페이징 버튼 수
	int startPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1; // 페이징 버튼 시작 값
	int endPage = startPage + pagePerPage - 1; // 페이징 버튼 종료 값
	if(endPage > lastPage){
		endPage = lastPage;
	}
	
	// 내 리뷰 조회	
	ArrayList<HashMap<String,Object>> list = rd.selectReview(id, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록</title>
</head>
<body>
	<table>
		<tr>
			<td>주문번호</td>
			<td>아이디</td>
			<td>제목</td>
			<td>내용</td>
			<td>이미지</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<tr>
					<td><%=(int)m.get("orderNo") %></td>
					<td><%=(String)m.get("id") %></td>
					<td><%=(String)m.get("reviewTitle") %></td>
					<td><%=(String)m.get("reviewContent") %></td>
					<td>
						<img src="<%=request.getContextPath()%>/rimg/<%= rd.reviewImgName((int)m.get("reviewNo")) %>" alt="IMG-REVIEW" style="width:80px; height:80px;">
					</td>
					<td><a href="<%=request.getContextPath()%>/customer/modifyReview.jsp?reviewNo=<%=m.get("reviewNo") %>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/customer/removeReviewAction.jsp?reviewNo=<%=m.get("reviewNo") %>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- list 페이징 -->
	<%
		//이전 페이지 버튼
		if(startPage >1){
	%>
  				<a href="<%=request.getContextPath()%>/customer/reviewList.jsp?currentPage=<%=startPage-pagePerPage %>">
  					이전 
  				</a>
   	<%
		}
        for(int i = startPage; i <= endPage; i++){
        	if(i==currentPage){
    %>
       				<%=i %>
    <%
        	}else{
   	%>
       			<a href="<%=request.getContextPath()%>/customer/reviewList.jsp?currentPage=<%=i %>">
       				<%=i %>
       			</a>
       <%
       		}
        }
    	//다음 페이지 버튼
    	if(endPage != lastPage){
       %>
			<a href="<%=request.getContextPath()%>/customer/reviewList?currentPage=<%=startPage+pagePerPage %>">
				다음
			</a>
	<%
		}
	%>
	
	<div>
		<a href="<%=request.getContextPath()%>/customer/myPage.jsp">
			<button>취소</button>
		</a>
	</div>
</body>
</html>