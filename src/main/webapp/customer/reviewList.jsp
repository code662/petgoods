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
	int rowPerPage = 3; // 한페이지에 출력할 게시물 수
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
<jsp:include page="/inc/link.jsp"></jsp:include>
<style>

</style>
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

<form class="bg0 p-t-75 p-b-85">
	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-lg-11 col-xl-11 m-lr-auto m-b-50">
				<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
					<h4 class="mtext-111 cl2 p-b-30">
						Review
					</h4>
					
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
					
				<%
					for(HashMap<String, Object> m : list){
				%>
					<div class="flex-w flex-t p-b-68">
						<div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6">
							<img src="<%=request.getContextPath()%>/rimg/<%= rd.reviewImgName((int)m.get("reviewNo")) %>" alt="IMG-REVIEW" style="width:80px; height:80px;">
						</div>
		
						<div class="size-207">
							<div class="flex-w flex-sb-m p-b-17">
								<span class="mtext-107 cl2 p-r-20">
									<%=(String)m.get("id") %>
								</span>
								<span class="fs-18 cl11 stext-102">
									<%=(String)m.get("createdate") %>
								</span>
							</div>
							<span class="mtext-107 cl2 p-r-20">
								<%=(String)m.get("reviewTitle") %>
							</span>
							<p class="stext-102 cl6">
								<%=(String)m.get("reviewContent") %>
							</p>
							<div class="flex-w flex-sb-m p-b-17">
								<span class="mtext-107 cl2 p-r-20">
									&nbsp;
								</span>
								<span class="fs-18 cl11 stext-102 flex-w m-r--5">
									<a href="<%=request.getContextPath()%>/customer/modifyReview.jsp?reviewNo=<%=m.get("reviewNo") %>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
										수정
									</a>
									<a href="<%=request.getContextPath()%>/customer/removeReviewAction.jsp?reviewNo=<%=m.get("reviewNo") %>" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">
										삭제
									</a>
								</span>
							</div>
						</div>
					</div>
				<%
					}
				%>
				
				<!-- Pagination -->
				<div class="flex-l-m flex-w w-full p-t-10 m-lr--7" style="justify-content: center">
				<%
					//이전 페이지 버튼
					if(startPage >1){
				%>
		  				<a href="<%=request.getContextPath()%>/customer/reviewList.jsp?currentPage=<%=startPage-pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
		  					이전 
		  				</a>
			   	<%
					}
			        for(int i = startPage; i <= endPage; i++){
			        	if(i==currentPage){
			    %>
			    			<a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
			       				<%=i %>
			       			</a>
			    <%
			        	}else{
			   	%>
			       			<a href="<%=request.getContextPath()%>/customer/reviewList.jsp?currentPage=<%=i %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
			       				<%=i %>
			       			</a>
			    <%
			       		}
			        }
			    	//다음 페이지 버튼
			    	if(endPage != lastPage){
			    %>
						<a href="<%=request.getContextPath()%>/customer/reviewList.jsp?currentPage=<%=startPage+pagePerPage %>" class="flex-c-m how-pagination1 trans-04 m-all-7">
							다음
						</a>
				<%
					}
				%>
				</div>
				<br>
					<div class="flex-w dis-inline-block cen">
						<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers cen">
							<a href="<%=request.getContextPath()%>/customer/myPage.jsp" style="color: #333333">
								취소
							</a>
						</div>
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