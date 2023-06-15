<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%

%>
<!DOCTYPE html>
<!-- Footer -->
<footer class="bg3 p-t-75 p-b-32">
	<div class="container">
		<div class="row">
			<!-- 카테고리 -->
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">
					Main Categories
				</h4>

				<ul>
					<li class="p-b-10">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료" class="stext-107 cl7 hov-cl1 trans-04">
							Foods
						</a>
					</li>

					<li class="p-b-10">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식" class="stext-107 cl7 hov-cl1 trans-04">
							Treat
						</a>
					</li>

					<li class="p-b-10">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품" class="stext-107 cl7 hov-cl1 trans-04">
							Goods
						</a>
					</li>
				</ul>
			</div>

			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">
					Sub Categories
				</h4>

				<ul>
					<li class="p-b-10">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료&subCategory=습식사료" class="stext-107 cl7 hov-cl1 trans-04">
							습식사료&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료&subCategory=건식사료" class="stext-107 cl7 hov-cl1 trans-04">
							건식사료&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료&subCategory=에어/동결사료" class="stext-107 cl7 hov-cl1 trans-04">
							에어/동결사료&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=사료&subCategory=자연식" class="stext-107 cl7 hov-cl1 trans-04">
							자연식
						</a>
					</li>

					<li class="p-b-10">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식&subCategory=뼈간식" class="stext-107 cl7 hov-cl1 trans-04">
							뼈간식&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식&subCategory=껌" class="stext-107 cl7 hov-cl1 trans-04">
							껌&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식&subCategory=동결/건조" class="stext-107 cl7 hov-cl1 trans-04">
							동결/건조&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=간식&subCategory=저키" class="stext-107 cl7 hov-cl1 trans-04">
							저키
						</a>
					</li>

					<li class="p-b-10">
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품&subCategory=장난감" class="stext-107 cl7 hov-cl1 trans-04">
							장난감&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품&subCategory=의류/악세사리" class="stext-107 cl7 hov-cl1 trans-04">
							의류/악세사리&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품&subCategory=하우스/방석" class="stext-107 cl7 hov-cl1 trans-04">
							하우스/방석&nbsp;
						</a>
						<a href="<%=request.getContextPath()%>/product/productList.jsp?mainCategory=용품&subCategory=가방/카시트" class="stext-107 cl7 hov-cl1 trans-04">
							가방/카시트
						</a>
					</li>
				</ul>
			</div>
			<!-- 깃허브 주소 -->
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">
					Git Hub Address
				</h4>

				<p class="stext-107 cl7 size-201">
					https://github.com/code662/petgoods<br>
					https://github.com/seokhyun03<br>
					https://github.com/ueuye<br>
					https://github.com/conio11
				</p>
				
				
			</div>
			<!-- 개발기간 -->
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">
					develop period
				</h4>

				<p class="stext-107 cl7 size-201">
					2023.05.30 WED ~ 2023.06.23 FRI
				</p>
			</div>
		</div>

		<div class="p-t-40">
			<!-- 결제 이미지 -->
			<div class="flex-c-m flex-w p-b-18">
				<img src="<%=request.getContextPath()%>/temp/images/icons/icon-pay-01.png" alt="ICON-PAY">
				<img src="<%=request.getContextPath()%>/temp/images/icons/icon-pay-02.png" alt="ICON-PAY">
				<img src="<%=request.getContextPath()%>/temp/images/icons/icon-pay-03.png" alt="ICON-PAY">
				<img src="<%=request.getContextPath()%>/temp/images/icons/icon-pay-04.png" alt="ICON-PAY">
				<img src="<%=request.getContextPath()%>/temp/images/icons/icon-pay-05.png" alt="ICON-PAY">
			</div>
			<!-- 카피라이트 -->
			<p class="stext-107 cl6 txt-center">
				<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
				Copyright &copy; 2023 All rights reserved | Made by Team CODE662 Jeong Seok Hyun & Gu Eun Hye & Oh Da Vin
				<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->

			</p>
		</div>
	</div>
</footer>