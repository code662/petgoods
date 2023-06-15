<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입, 로그인</title>
<jsp:include page="/inc/link.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/inc/loginAddCustomer.css">
</head>
<body>
<jsp:include page="/inc/customerHeader.jsp"></jsp:include>
<jsp:include page="/inc/sidebar.jsp"></jsp:include>
<jsp:include page="/inc/cart.jsp"></jsp:include>

<div class="container" id="container">
	<div class="form-container sign-up-container">
		<!-- 회원가입 -->
		<form action="<%=request.getContextPath()%>/customer/addCustomerAction.jsp" method="post">
			<br>
			<h1>회원가입</h1>
			<br>
			<div class="sc" style="overflow:auto; width:280px; height:300px;">
				<!-- 회원가입 입력 폼 --> 
				<table class="cen">
					<tr>
						<td colspan="2"><input type ="text" placeholder="Enter id" name="id" style="width: 230px;"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="password" placeholder="Enter Password" name="pw" style="width: 230px;"></td>
					</tr>
					<tr>
						<td colspan="2"><input type ="text" placeholder="Enter Name" name="cstmName" style="width: 230px;"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" placeholder="Enter Email" name="cstmEmail" style="width: 230px;"></td>
					</tr>
					<tr>
						<td colspan="2"><input type ="date" name="cstmBirth" style="width: 230px;"></td>
					</tr>
					<tr>
						<td><input type="radio" name="cstmGender" style="width: 20px; display: inline;" value="M">남</td>
						<td><input type="radio" name="cstmGender" style="width: 20px; display: inline;" value="F">여</td>
					</tr>
				</table>
				<br>
				
				<!-- 약관 동의 -->
				<label class="cen" for="agree_all" style="display: flex; width: 230px; justify-content: space-between; margin-top: 10px;">
					<input style="width: 20px" type="checkbox" name="agree_all" id="agree_all" value="Y">
					<span style="width: 95%; padding-top: 7px; text-align:left;"><strong> 약관 전체 동의</strong></span>
				</label>
				<label class="cen" for="agree" style="display: flex; width: 230px; justify-content: space-between; margin-top: 10px;">
					<input style="width: 20px" type="checkbox" name="agree" id="agree1" required="required">
					<span style="width: 95%; padding-top: 7px; text-align:left;"> 본인은 만 14세 이상 입니다<strong>(필수)</strong></span>
				</label>
				<label class="cen" for="agree" style="display: flex; width: 230px; justify-content: space-between; margin-top: 10px;">
					<input style="width: 20px" type="checkbox" name="agree" id="agree2" required="required">
					<span style="width: 95%; padding-top: 7px; text-align:left;"> 서비스 이용약관 동의<strong>(필수)</strong></span>
				</label>
				<label class="cen" for="agree" style="display: flex; width: 230px; justify-content: space-between; margin-top: 10px;">
					<input style="width: 20px" type="checkbox" name="agree" id="agree3" required="required">
					<span style="width: 95%; padding-top: 7px; text-align:left;"> 개인정보 수집 및 이용 동의<strong>(필수)</strong></span>
				</label>
				<br>
				<a href="<%=request.getContextPath()%>/customer/addCustomerAction.jsp"><button>회원가입</button></a>
			</div>
		</form>
	</div>
  	<!-- 로그인 -->
	<div class="form-container sign-in-container">
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<h1>로그인</h1>
			<br>
			<span>로그인 정보를 입력해주세요.</span>
			<%
	      		if(request.getParameter("msg") != null){
	      	%>
	            <p style="color: red"><%=request.getParameter("msg") %></p>
	     	<%
	        	}
	     	%>
			<input type="text" placeholder="id" name="id" />
			<input type="password" placeholder="Password" name="pw"/>
			<a href="#">비밀번호를 잊으셨나요?</a>
			<button>로그인</button>
		</form>
	</div>
	
	<div class="overlay-container">
		<div class="overlay">
			<div class="overlay-panel overlay-left">
				<h1>Welcome Back!</h1>
				<p>쇼핑을 하시려면 로그인 버튼을 눌러주세요!</p>
				<button class="ghost" id="signIn">로그인</button>
			</div>
			<div class="overlay-panel overlay-right">
				<h1>Hello, Friend!</h1>
				<p>펫프렌즈와 함께 즐거운 쇼핑을 시작해봐요!</p>
				<button class="ghost" id="signUp">회원가입</button>
			</div>
		</div>
	</div>
</div>

<!-- 약관 동의 java script -->
<script type="text/javascript">
	//동의 모두선택 / 해제
	const agreeChkAll = document.querySelector('input[name=agree_all]');
	    agreeChkAll.addEventListener('change', (e) => {
	    	let agreeChk = document.querySelectorAll('input[name=agree]');
		    for(let i = 0; i < agreeChk.length; i++){
		      agreeChk[i].checked = e.target.checked;
		    }
		});
	    
    const agreeChkOne = document.querySelector('input[id=agree1]');
       agreeChkOne.addEventListener('change', (e) => {
          let agreeChk = document.querySelectorAll('input[name=agree]');
          let agreeAll = document.querySelector('input[name=agree_all]');
          let CheckAll = true;
          for(let i = 0; i < agreeChk.length; i++){
              if(!agreeChk[i].checked){
                 CheckAll = false;
                 break;
              }
          }
          agreeAll.checked = CheckAll;   
      });
       
    const agreeChkTwo = document.querySelector('input[id=agree2]');
       agreeChkTwo.addEventListener('change', (e) => {
          let agreeChk = document.querySelectorAll('input[name=agree]');
          let agreeAll = document.querySelector('input[name=agree_all]');
          let CheckAll = true;
          for(let i = 0; i < agreeChk.length; i++){
              if(!agreeChk[i].checked){
                 CheckAll = false;
                 break;
              }
          }
          agreeAll.checked = CheckAll;   
      });
       
    const agreeChkThree = document.querySelector('input[id=agree3]');
       agreeChkThree.addEventListener('change', (e) => {
          let agreeChk = document.querySelectorAll('input[name=agree]');
          let agreeAll = document.querySelector('input[name=agree_all]');
          let CheckAll = true;
          for(let i = 0; i < agreeChk.length; i++){
              if(!agreeChk[i].checked){
                 CheckAll = false;
                 break;
              }
          }
          agreeAll.checked = CheckAll;   
      });
    
    window.onload = function(){
        const signUpButton = document.getElementById('signUp');
        const signInButton = document.getElementById('signIn');
        const container = document.getElementById('container');
        
        signUpButton.addEventListener("click", () => {
          container.classList.add("right-panel-active");
        });
        
        signInButton.addEventListener("click", () => {
          container.classList.remove("right-panel-active");
        });
     };
</script>
<jsp:include page="/inc/script.jsp"></jsp:include>
</body>
</html>