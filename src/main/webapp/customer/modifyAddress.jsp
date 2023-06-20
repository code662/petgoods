<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");

	//요청값 유효성 검사
	if(request.getParameter("addressNo") == null
			|| request.getParameter("addressNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/customer/addressList.jsp");
		return;
	}
	//요청값 변수에 저장
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 수정</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md cen">
				<form action="<%=request.getContextPath()%>/customer/modifyAddressAction.jsp?addressNo=<%=addressNo %>" method="post">
					<h4 class="mtext-111 cl2 txt-center p-b-30">
						배송지 수정
					</h4>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_postcode" name="postcode" placeholder="우편번호" style="font-size:16px">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="font-size:16px">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_address" name="address" placeholder="주소" style="font-size:16px">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소" style="font-size:16px">
					</div>
					<div class="bor8 m-b-20 how-pos4-parent">
						<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30"  type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목" style="font-size:16px">
					</div>
					<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
						Submit
					</button>
				</form>
				<br>
				<div class="flex-w dis-inline-block cen">
					<a href="<%=request.getContextPath()%>/customer/addressList.jsp" style="color: #333333" class="cen">
						<span class="flex-c-m stext-101 cl2 size-115 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointers">
							취소
						</span>
					</a>
				</div>
			</div>
		</div>
	</section>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		var themeObj = {
	 		   //bgColor: "", //바탕 배경색
	 		   searchBgColor: "#F24182", //검색창 배경색
	 		   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
	 		   //pageBgColor: "", //페이지 배경색
	 		   //textColor: "", //기본 글자색
	 		   queryTextColor: "#FFFFFF" //검색창 글자색
	 		   //postcodeTextColor: "", //우편번호 글자색
	 		   //emphTextColor: "", //강조 글자색
	 		   //outlineColor: "", //테두리
	 		};
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            },
	            theme: themeObj
	        }).open();
	    }
	</script>
<jsp:include page="/inc/footer.jsp"></jsp:include>
<jsp:include page="/inc/backToTheTop.jsp"></jsp:include>
<jsp:include page="/inc/quickView.jsp"></jsp:include>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>