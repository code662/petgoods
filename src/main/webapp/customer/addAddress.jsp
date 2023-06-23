<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 배송지 추가</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 입력폼 유효성 검사
	$(document).ready(function(){
		$('#btn').click(function(){
			if($('#sample6_postcode').val() == ''){
				alert('우편번호를 입력해주세요');
			}else if($('#sample6_address').val() == ''){
				alert('주소를 입력해주세요');
			}else if($('#sample6_detailAddress').val() == ''){
				alert('상세주소를 입력해주세요');
			}else {
				$('#addAddress').submit();
			}
		});
	});
	
	// 주소API
	var themeObj = {
	 		   searchBgColor: "#F24182", 
	 		   queryTextColor: "#FFFFFF" 
	 		};
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; 
                var extraAddr = ''; 
                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }
                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            },
            theme: themeObj
        }).open();
    }
</script>
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="<%=request.getContextPath()%>/home.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				mypage
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<a href="<%=request.getContextPath()%>/customer/addressList.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				addressList
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				addAddress
			</span>
		</div>
	</div>
	
	<!-- 배송지 추가 폼 -->
	<section class="bg0 p-t-75 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/customer/addAddressAction.jsp" method="post" id="addAddress">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						배송지 추가
					</h4>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_postcode" name="postcode" placeholder="우편번호">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_address" name="address" placeholder="주소">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="mtext-107 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목">
					</div>
					<button id="btn" type="button" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/customer/addressList.jsp" class="cen">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer">
							취소
						</span>
					</a>
				</div>
			</div>
		</div>
	</section>
<jsp:include page="/inc/footer.jsp"></jsp:include>
<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
<jsp:include page="/inc/quickView.jsp"></jsp:include>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>