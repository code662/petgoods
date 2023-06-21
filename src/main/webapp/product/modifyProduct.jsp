<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 유효성 검사
	if(request.getParameter("productNo") == null
		|| request.getParameter("productNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
	}
	// 
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	ProductDao pDao = new ProductDao();
	
	Product product = pDao.selectProductOne(productNo);
	// 카테고리 변수
	String mainCategory = "전체";
	String subCategory = "전체";
	// Dao 객체 생성
	CategoryDao cDao = new CategoryDao();
	// 메인 카테고리 리스트
	ArrayList<Category> categoryMainList = cDao.selectMainCategory();	
	Category categoryOne = cDao.selectCategoryOne(product.getCategoryNo());
	String SavefileName = pDao.selectProductImg(productNo).getProductSaveFilename();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		let mainName = '';
		let subName = '';
		$.ajax({
			url:'./selectProductOneCategory.jsp',
			data:{categoryNo:$('#categoryNo').val()},
			success: function(prm){
				$.ajax({
					url:'./selectSubList.jsp',
					data:{main: prm.categoryMainName},
					success: function(param){
						$('#sub').empty();
						$('#sub').append('<option value="">===서브 카테고리===</option>');	
						$(param).each(function(index, item){
							if(item.categoryMainName == prm.categoryMainName){
								if(item.categorySubName == prm.categorySubName) {
									$('#sub').append('<option value="'+item.categoryNo+'" selected="selected">'+item.categorySubName+'</option>');
								} else {
									$('#sub').append('<option value="'+item.categoryNo+'">'+item.categorySubName+'</option>');
								}
							}
						});
					}
				});
			}
		});
		
		$('#main').on('change', function(){
			if($('#main').val() == ''){
				alert('메인 카테고리를 선택해주세요');
				$('#sub').empty();
				$('#sub').append('<option value="">===서브 카테고리===</option>');
			} else {
				$.ajax({
					url:'./selectSubList.jsp',
					data:{main:$('#main').val()},
					success: function(param){
						$('#sub').empty();
						$('#sub').append('<option value="">===서브 카테고리===</option>');	
						$(param).each(function(index, item){
							if(item.categoryMainName == $('#main').val()){
								$('#sub').append('<option value="'+item.categoryNo+'">'+item.categorySubName+'</option>');
							}
						});
					}
				});
			}
		});
		$('#modifyProductBtn').click(function(){
			let extension = $('#productImg').val().substr($('#productImg').val().lastIndexOf(".")+1);
			if($('#sub').val() == ''){
				alert('카테고리를 선택해주세요');
			}else if(extension != '' && extension != 'png' && extension != 'jpg' && extension != 'jpeg'){
				alert('이미지 파일을 올려주세요'); 
			}else if($('#productName').val() == ''){
				alert('상품 이름을 입력해주세요');
			}else if($('#productStock').val() == ''){
				alert('상품 수량을 입력해주세요');
			}else if($('#productPrice').val() == ''){
				alert('상품 가격을 입력해주세요');
			}else if($('#prdouctStatus').val() == ''){
				alert('상품 상태를 선택해주세요');
			}else if($('#productInfo').val() == ''){
				alert('상품 정보를 입력해주세요');
			}else {
				$('#modifyProduct').submit();
			}
		});
	});
</script>
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
			
			<a href="<%=request.getContextPath()%>/product/productList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				product
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				modifyProduct
			</span>
		</div>
	</div>
	
	<section class="bg0 p-t-65 p-b-60">
	<form action="<%=request.getContextPath()%>/product/modifyProductAction.jsp" method="post" enctype="multipart/form-data" id="modifyProduct">
		<div class="col-sm-10 col-lg-7 col-xl-7 m-lr-auto m-b-50">
			<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
				<input type="hidden" name="productNo" value="<%=product.getProductNo()%>">
				<input type="hidden" id="categoryNo" value="<%=product.getCategoryNo()%>">
				<h4 class="mtext-109 cl2 p-b-30">
					상품 추가
				</h4>
	
				<div class="flex-w flex-t bor12 p-b-10">
					<div class="size-208">
						<span class="stext-110 cl2">
							상품유형:
						</span>
					</div>
	
					<div class="size-209">
						<div class="rs1-select2 rs2-select2 bor8 bg0 m-b-5">
							<select class="js-select2" id="main">
								<option value="">===메인 카테고리===</option>
								<%
									for(Category c : categoryMainList) {
										if(categoryOne.getCategoryMainName().equals(c.getCategoryMainName())){
								%>
											<option value="<%=c.getCategoryMainName()%>" selected="selected"><%=c.getCategoryMainName()%></option>
								<%				
										}else{
								%>
											<option value="<%=c.getCategoryMainName()%>"><%=c.getCategoryMainName()%></option>
								<%			
										}		
									}
								%>
							</select>
							<div class="dropDownSelect2"></div>
						</div>
						<div class="rs1-select2 rs2-select2 bor8 bg0 m-b-12 m-t-9">
							<select class="js-select2" name="categoryNo" id="sub">
								<option value="">===서브 카테고리===</option>
							</select>
							<div class="dropDownSelect2"></div>
						</div>
					</div>
				</div>
				
				<div class="flex-w flex-t bor12 p-t-15 p-b-10">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품이미지:
						</span>
					</div>
					<div class="size-209" style="text-align: center">
						<div class="p-b-5">
							<img src="<%=request.getContextPath()%>/pimg/<%=SavefileName%>" width="100px" height="auto">
						</div>
						<div>
							<span class="stext-109 cl2">현재이미지</span>
						</div>
						<div class="p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
							<input class="stext-111 cl8 plh3 size-111 p-lr-15 p-tb-6" type="file" id="productImg" name="productImg" accept=".jpeg,.jpg,.png">
						</div>
					</div>
				</div>
				
				<div class="flex-w flex-t bor12 p-t-15 p-b-10">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품이름:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="text" id="productName" name="productName" placeholder="상품 이름" value="<%=product.getProductName()%>">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-10">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품수량:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="number" id="productStock" name="productStock" placeholder="상품 수량" value="<%=product.getProductStock()%>">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-10">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품가격:
						</span>
					</div>
	
					<div class="size-209 p-r-18 p-r-0-sm w-full-ssm bor8 bg0">
						<input class="stext-111 cl8 plh3 size-111 p-lr-15" type="number" id="productPrice" name="productPrice" placeholder="상품 가격" value="<%=product.getProductPrice()%>">
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-10">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품상태:
						</span>
					</div>
	
					<div class="size-209">
						<div class="rs1-select2 rs2-select2 bor8 bg0 m-b-5">
							<select class="js-select2" id="prdouctStatus" name="prdouctStatus">
							<%
								if(product.getProductStatus().equals("판매중")){
							%>
									<option value="">===상품 상태===</option>
									<option value="판매중" selected="selected">판매중</option>
									<option value="품절">품절</option>
							<%		
								} else {
							%>
									<option value="">===상품 상태===</option>
									<option value="판매중">판매중</option>
									<option value="품절" selected="selected">품절</option>
							<%		
								}
							%>	
							</select>
							<div class="dropDownSelect2"></div>
						</div>
					</div>
				</div>
				<div class="flex-w flex-t bor12 p-t-15 p-b-10">
					<div class="size-208 w-full-ssm">
						<span class="stext-110 cl2">
							상품정보:
						</span>
					</div>
	
					<div class="size-209 p-r-0-sm w-full-ssm bor8 bg0">
						<textarea class="stext-111 cl8 plh3 size-120 p-lr-15" id="productInfo" name="productInfo" placeholder="상품 정보"><%=product.getProductInfo() %></textarea>
					</div>
				</div>
				<div class="flex-w flex-t p-t-27">
					<button type="button" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer" id="modifyProductBtn">
						상픔 정보 수정
					</button>
				</div>
			</div>
		</div>
	</form>
	</section>
<jsp:include page="/inc/footer.jsp"></jsp:include>
<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
<jsp:include page="/inc/quickView.jsp"></jsp:include>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>