<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.net.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	//입력값 불러오기
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	//디버깅
	System.out.println(id + "<-- 넘어온 id");
	System.out.println(pw + "<-- 넘어온 pw");
	
	//유효성 검사
	String msg = "";
	if(id == null || id.equals("")){ // 아이디가 입력되지 않았을 경우
		msg = URLEncoder.encode("아이디가 입력되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}
	
	if(pw == null || pw.equals("")){ // 비밀번호가 입력되지 않았을 경우
		msg = URLEncoder.encode("비밀번호가 입력되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}
	
	LoginDao loginDao = new LoginDao();
	
	// map 에 id pw 값 저장
	HashMap<String, Object> map = loginDao.selectLogin(id, pw);
	
	Customer c = null;
	Employees e = null;
	
	// 아이디 비번 체크
	if(loginDao.checkId(id, pw) == 1){
		if(map.get("login") instanceof Customer) {
			// 아이디가 customer 면 c 에 저장
			c = (Customer)map.get("login");
			session.setAttribute("loginId", c);
		} else if(map.get("login") instanceof Employees) {
			// 아이디가 customer 면 e 에 저장
			e = (Employees)map.get("login");
			session.setAttribute("loginId", e);
		}
		//로그인 성공 시
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		
	}else{
		System.out.println("로그인 실패");
		// 아이디와 비번이 존재하지않을 때 실행되는 메세지
		msg = URLEncoder.encode("로그인 정보를 다시 확인해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
		return;
	}
%>   