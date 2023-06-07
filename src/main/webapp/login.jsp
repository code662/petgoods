<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<Style>
label {
  display: block;
}

@import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

* {
  box-sizing: border-box;
}

body {
  background: #f6f5f7;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  font-family: 'Montserrat', sans-serif;
  height: 100vh;
  margin: -20px 0 50px;
}

h1 {
  font-weight: bold;
  margin: 0;
}

h2 {
  text-align: center;
}

p {
  font-size: 14px;
  font-weight: 100;
  line-height: 20px;
  letter-spacing: 0.5px;
  margin: 20px 0 30px;
}

span {
  font-size: 12px;
}

a {
  color: #FFFFFF;
  font-size: 14px;
  text-decoration: none;
  margin: 15px 0;
}

button {
  border-radius: 20px;
  border: 1px solid #FF4B2B;
  background-color: #F24182;
  color: #FFFFFF;
  font-size: 12px;
  font-weight: bold;
  padding: 12px 45px;
  letter-spacing: 1px;
  text-transform: uppercase;
  transition: transform 80ms ease-in;
}

button:active {
  transform: scale(0.95);
}

button:focus {
  outline: none;
}

button.ghost {
  background-color: transparent;
  border-color: #FFFFFF;
}

form {
  background-color: #FFFFFF;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 50px;
  height: 100%;
  text-align: center;
}

input {
  background-color: #eee;
  border: none;
  padding: 12px 15px;
  margin: 8px 0;
  width: 100%;
}

.container {
  background-color: #fff;
  border-radius: 10px;
    box-shadow: 0 14px 28px rgba(0,0,0,0.25), 
      0 10px 10px rgba(0,0,0,0.22);
  position: relative;
  overflow: hidden;
  width: 800px;
  max-width: 100%;
  min-height: 480px;
}

.form-container {
  position: absolute;
  top: 0;
  height: 100%;
  transition: all 0.6s ease-in-out;
}

.sign-in-container {
  left: 0;
  width: 50%;
  z-index: 2;
}

.container.right-panel-active .sign-in-container {
  transform: translateX(100%);
}

.sign-up-container {
  left: 0;
  width: 50%;
  opacity: 0;
  z-index: 1;
}

.container.right-panel-active .sign-up-container {
  transform: translateX(100%);
  opacity: 1;
  z-index: 5;
  animation: show 0.6s;
}

@keyframes show {
  0%, 49.99% {
    opacity: 0;
    z-index: 1;
  }
  
  50%, 100% {
    opacity: 1;
    z-index: 5;
  }
}

.overlay-container {
  position: absolute;
  top: 0;
  left: 50%;
  width: 50%;
  height: 100%;
  overflow: hidden;
  transition: transform 0.6s ease-in-out;
  z-index: 100;
}

.container.right-panel-active .overlay-container{
  transform: translateX(-100%);
}

.overlay {
  background: #FF416C;
  background: -webkit-linear-gradient(to right, #F24182);
  background: linear-gradient(to right, #F24182);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: 0 0;
  color: #FFFFFF;
  position: relative;
  left: -100%;
  height: 100%;
  width: 200%;
    transform: translateX(0);
  transition: transform 0.6s ease-in-out;
}

.container.right-panel-active .overlay {
    transform: translateX(50%);
}

.overlay-panel {
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 40px;
  text-align: center;
  top: 0;
  height: 100%;
  width: 50%;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
}

.overlay-left {
  transform: translateX(-20%);
}

.container.right-panel-active .overlay-left {
  transform: translateX(0);
}

.overlay-right {
  right: 0;
  transform: translateX(0);
}

.container.right-panel-active .overlay-right {
  transform: translateX(20%);
}

.social-container {
  margin: 20px 0;
}

.social-container a {
  border: 1px solid #DDDDDD;
  border-radius: 50%;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  margin: 0 5px;
  height: 40px;
  width: 40px;
}

footer {
    background-color: #222;
    color: #fff;
    font-size: 14px;
    bottom: 0;
    position: fixed;
    left: 0;
    right: 0;
    text-align: center;
    z-index: 999;
}

footer p {
    margin: 10px 0;
}

footer i {
    color: red;
}

footer a {
    color: #3c97bf;
    text-decoration: none;
}
</Style>

</head>
<body>
<div class="container" id="container">
	<div class="form-container sign-up-container">
		<form action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="post">
			<br>
			<h1>회원가입</h1>
			<br>
			<div style="overflow:auto; width:250px; height:300px;">
				<!-- 회원가입 입력 폼 --> 
				<table>
					<tr>
						<td><span>ID</span></td>
						<td colspan="2"><input type ="text" placeholder="Enter id"></td>
					</tr>
					<tr>
						<td><span>PW</span></td>
						<td colspan="2"><input type="password" placeholder="Enter Password"></td>
					</tr>
					<tr>
						<td><span>이름</span></td>
						<td colspan="2"><input type ="text" placeholder="Enter Name"></td>
					</tr>
					<tr>
						<td><span>주소</span></td>
						<td colspan="2"><input type ="text" placeholder="Enter Address"></td>
					</tr>
					<tr>
						<td><span>이메일</span></td>
						<td colspan="2"><input type="text" placeholder="Enter Email"></td>
					</tr>
					<tr>
						<td><span>생일</span></td>
						<td colspan="2"><input type ="date"></td>
					</tr>
					<tr>
						<td><span>성별</span></td>
						<td ><input type="radio" name="gender" style="width: 20px;">남</td>
						<td><input type="radio" name="gender" style="width: 20px;">여</td>
					</tr>
				</table>
				<br>
				
			<!-- 약관 동의 -->
            <label for="agree_all" style="display: flex; width: 100%; justify-content: space-between; margin-top: 10px;">
               <input style="width: 20px" type="checkbox" name="agree_all" id="agree_all">
               <span style="width: 95%; padding-top: 7px; text-align:left;"><strong> 약관 전체 동의</strong></span>
            </label>
            <label for="agree" style="display: flex; width: 100%; justify-content: space-between; margin-top: 10px;">
               <input style="width: 20px" type="checkbox" name="agree" value="1" required="required">
               <span style="width: 95%; padding-top: 7px; text-align:left;"> 본인은 만 14세 이상 입니다<strong>(필수)</strong></span>
            </label>
            <label for="agree" style="display: flex; width: 100%; justify-content: space-between; margin-top: 10px;">
               <input style="width: 20px" type="checkbox" name="agree" value="2" required="required">
               <span style="width: 95%; padding-top: 7px; text-align:left;"> 서비스 이용약관 동의<strong>(필수)</strong></span>
            </label>
            <label for="agree" style="display: flex; width: 100%; justify-content: space-between; margin-top: 10px;">
               <input style="width: 20px" type="checkbox" name="agree" value="3" required="required">
               <span style="width: 95%; padding-top: 7px; text-align:left;"> 개인정보 수집 및 이용 동의<strong>(필수)</strong></span>
            </label>
            <br>
            <a href="<%=request.getContextPath()%>/customer/addCustomerAction.jsp"><button>회원가입</button></a>
         </div>
      </form>
   </div>
  
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
				<p>도그마켓과 함께 즐거운 쇼핑을 시작해봐요!</p>
				<button class="ghost" id="signUp">회원가입</button>
			</div>
		</div>
	</div>
</div>
</body>

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

</html>
