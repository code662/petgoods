<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<!-- 사이드바 -->
<aside class="wrap-sidebar js-sidebar">
	<div class="s-full js-hide-sidebar"></div>

	<div class="sidebar flex-col-l p-t-22 p-b-25">
		<div class="flex-r w-full p-b-30 p-r-27">
			<!-- 사이드바 닫는 버튼 -->
			<div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-sidebar">
				<i class="zmdi zmdi-close"></i>
			</div>
		</div>
		<!-- 사이드바 메뉴 -->
		<div class="sidebar-content flex-w w-full p-lr-65 js-pscroll">
			<ul class="sidebar-link w-full">
				<li class="p-b-13">
					<a href="<%=request.getContextPath()%>/home.jsp" class="stext-102 cl2 hov-cl1 trans-04">
						Home
					</a>
				</li>
			<%
				// 로그인 정보가 없을 경우 로그인 버튼
				if(session.getAttribute("loginId") == null) {
			%>
					<li class="p-b-13">
						<a href="<%=request.getContextPath()%>/login.jsp" class="stext-102 cl2 hov-cl1 trans-04">
							Login
						</a>
					</li>
			<%	
				// 아니면 로그아웃 버튼 및 마이페이지 버튼
				} else {
			%>
					<li class="p-b-13">
						<a href="<%=request.getContextPath()%>/logoutAction.jsp" class="stext-102 cl2 hov-cl1 trans-04">
							Logout
						</a>
					</li>
			<%
					// 로그인 정보가 고객인지 사원인지에 따라 다른 페이지 이동
					if(session.getAttribute("loginId") instanceof Customer) {
			%>
						<li class="p-b-13">
							<a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="stext-102 cl2 hov-cl1 trans-04">
								MyPage
							</a>
						</li>
			<%	
					} else if(session.getAttribute("loginId") instanceof Employees) {
			%>
						<li class="p-b-13">
							<a href="<%=request.getContextPath()%>/employees/employeeOne.jsp?" class="stext-102 cl2 hov-cl1 trans-04">
								MyPage
							</a>
						</li>
			<%				
					}	
				}
			%>
			</ul>
			<!-- 사이드바 이미지 -->
			<div class="sidebar-gallery w-full p-tb-30">
				<span class="mtext-101 cl5">
					<img src="<%=request.getContextPath()%>/img/logo.png" width="150" height="50">
				</span>

				<div class="flex-w flex-sb p-t-36 gallery-lb">
				<%
					for(int i=0; i<9; i+=1){
				%>
						<!-- 이미지 -->
						<div class="wrap-item-gallery m-b-10">
							<a class="item-gallery bg-img1" href="<%=request.getContextPath()%>/img/sideImg<%=i+1%>.webp" data-lightbox="gallery" 
							style="background-image: url('<%=request.getContextPath()%>/img/sideImg<%=i+1%>.webp');"></a>
						</div>
				<%		
					}
				%>
				</div>
			</div>
			<!-- 사이드바 설명 -->
			<div class="sidebar-gallery w-full">
				<span class="mtext-101 cl5">
					About Us
				</span>

				<p class="stext-108 cl6 p-t-27">
					GDJ66 CODE662 <br> Jeong Seok Hyun <br> Gu Eun Hye <br> Oh Da Vin
				</p>
			</div>
		</div>
	</div>
</aside>