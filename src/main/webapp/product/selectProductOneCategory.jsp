<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao dao = new CategoryDao();
	Category categoryOne = dao.selectCategoryOne(categoryNo);
	// 자바객체 list변수를 json문자열 변경
	Gson gson = new Gson();
	String jsonStr = gson.toJson(categoryOne);
	out.print(jsonStr);
%>