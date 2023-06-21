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
	
	// 해당 메인-서브 카테고리 내 존재하는 상품 개수 확인
	int cnt = cateDao.productCnt(categoryNo);
	System.out.println(cnt + " <-- cnt(removeCategory)");

	System.out.println("==============removeCategory.jsp==============");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeCategory</title>
		<jsp:include page="/inc/link.jsp"></jsp:include>
	</head>

	<body>
	<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
	<jsp:include page="/inc/sidebar.jsp"></jsp:include>
	<jsp:include page="/inc/cart.jsp"></jsp:include>
	<!-- cnt가 0 (메인-서브 카테고리 내 상품이 없는 경우)인 경우에만 입력폼 출력 -->
	<%
		if (cnt == 0) {
	%>
	<form class="bg0 p-t-75 p-b-85" action="<%=request.getContextPath()%>/product/removeCategoryAction.jsp" method="post">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
					<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">	 	
						<h4 class="mtext-111 cl2 p-b-30">
							카테고리 정보 삭제
						</h4>
						<input type="hidden" name="categoryNo" value="<%=category.getCategoryNo()%>">
						<div class="flex-w flex-t bor12 p-b-13">
							<div class="size-208">
								<span class="stext-110 cl2" style="font-size:17px">
									카테고리 번호
								</span>
							</div>
								
							<div class="size-209">
									<span class="stext-112 cl8" style="font-size:17px">
										<%=category.getCategoryNo()%>
									</span>
							</div>
						</div>
							
						<div class="flex-w flex-t bor12 p-t-15 p-b-30">
							<div class="size-208 w-full-ssm">
								<span class="stext-110 cl2" style="font-size:17px">
									메인 카테고리명
								</span>
							</div>
							<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
								<p class="stext-112 cl8 p-t-2" style="font-size:17px">
									<%=category.getCategoryMainName()%>
								</p>
							</div>
						</div>
						
						<div class="flex-w flex-t bor12 p-t-15 p-b-30">
						<div class="size-208 w-full-ssm">
							<span class="stext-110 cl2" style="font-size:17px">
								서브 카테고리명
							</span>
						</div>
						<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
							<p class="stext-112 cl8 p-t-2" style="font-size:17px">
								<%=category.getCategorySubName()%>
							</p>
						</div>
					</div>
					
					<div class="flex-w flex-t bor12  p-t-15 p-b-30">
						<div class="size-208 w-full-ssm">
							<span class="stext-110 cl2" style="font-size:17px">
								생성일자
							</span>
						</div>
						<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
							<p class="stext-112 cl8 p-t-2" style="font-size:17px">
								<%=category.getCreatedate()%>
							</p>
						</div>
					</div>
					
					<div class="flex-w flex-t bor12 p-t-15 p-b-30">
						<div class="size-208 w-full-ssm">
							<span class="stext-110 cl2" style="font-size:17px">
								수정일자
							</span>
						</div>
						<div class="size-209 p-r-18 p-r-0-sm w-full-ssm">
							<p class="stext-112 cl8 p-t-2" style="font-size:17px">
								<%=category.getCreatedate()%>
							</p>
						</div>
					</div>
			
					
					<br>
					<div class="flex-w dis-inline-block">
						<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							<button type="submit" style="color: #333333">
								카테고리 삭제
							</button>
						</div>
					</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	<%	
		} else { // 값이 있는 경우 삭제 불가
	%>	
			<form class="bg0 p-t-75 p-b-85" >
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-lg-12 col-xl-12 m-lr-auto m-b-50">
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">	 	
							<h4 class="mtext-111 cl2 p-b-30">
								상품이 존재하는 카테고리입니다. 삭제할 수 없습니다. <br>
								<%=category.getCategoryMainName()%>-<%=category.getCategorySubName()%> 내 상품 개수: <%=cnt%>
							</h4>
							
						<br>
						<div class="flex-w dis-inline-block">
							<div class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
								<a href="<%=request.getContextPath()%>/product/mainCategoryList.jsp" style="color: #333333">
									메인 카테고리로
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</form>	
	<%
		}
	%>
	
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
	<jsp:include page="/inc/quickView.jsp"></jsp:include>
	<jsp:include page="/inc/script.jsp"></jsp:include>
	</body>
</html>