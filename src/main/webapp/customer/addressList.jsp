<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	//세션 유효성 검사: 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 로그인 세션 정보 변수에 저장
	Customer c = (Customer)session.getAttribute("loginId");
	String id = c.getId(); 
	
	AddressDao ad = new AddressDao();
	ArrayList<Address> list = ad.selectAddress(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 관리</title>
</head>
<body>
	<!-- 리다이렉션 메시지 --> 
	<div>
	<%
		if(request.getParameter("msg") != null){
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
	</div>
	
	<div>
		<a href="<%=request.getContextPath()%>/customer/addAddress.jsp">
			<button>새 배송지 추가</button>
		</a>
	</div>
	<!-- 배송지 리스트 -->
	<table>
		<%
			for(Address a : list) {
		%>
				<tr>
					<td><%=a.getAddress()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/customer/modifyAddress.jsp">
							<button>수정</button>
						</a>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/customer/removeAddressAction.jsp">
							<button>삭제</button>
						</a>
					</td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>