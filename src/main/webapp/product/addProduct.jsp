<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 카테고리 변수
	String mainCategory = "전체";
	String subCategory = "전체";
	// Dao 객체 생성
	CategoryDao cDao = new CategoryDao();
	// 카테고리 리스트
	ArrayList<Category> categoryMainList = cDao.selectMainCategory();

		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/employeesHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="index.html" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				QuestionList
			</span>
		</div>
	</div>
	
	<form>
		<div class="col-sm-10 col-lg-7 col-xl-7 m-lr-auto m-b-50">
			<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
				<h4 class="mtext-109 cl2 p-b-30">
					상품 추가
				</h4>
	
				<div class="flex-w flex-t bor12 p-b-13">
					<div class="size-208">
						<span class="stext-110 cl2">
							상품유형:
						</span>
					</div>
	
					<div class="size-209">
						<div class="rs1-select2 rs2-select2 bor8 bg0 m-b-12">
							<select class="js-select2" name="time">
								<option>===메인 카테고리===</option>
								<option>USA</option>
								<option>UK</option>
							</select>
							<div class="dropDownSelect2"></div>
						</div>
						<div class="rs1-select2 rs2-select2 bor8 bg0 m-b-12 m-t-9">
							<select class="js-select2" name="time">
								<option>...서브 카테고리...</option>
								<option>USA</option>
								<option>UK</option>
							</select>
							<div class="dropDownSelect2"></div>
						</div>
					</div>
				</div>
	
				<div class="flex-w flex-t bor12 p-t-15 p-b-30">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품이름:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="text" name="postcode" placeholder="상품 이름">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-30">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품수량:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="number" name="postcode" placeholder="상품 수량">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-30">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품가격:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="number" name="postcode" placeholder="상품 가격">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-30">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품상태:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="text" name="postcode" placeholder="상품 상태">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-30">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품정보:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="text" name="postcode" placeholder="상품 정보">
					</div>
				</div>
				<div class="flex-w flex-t p-t-27">
					<button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
						상픔 추가
					</button>
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