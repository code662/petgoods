<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	String id = request.getParameter("id");
	CustomerDao cd = new CustomerDao();
	int dormantRow = cd.selectDormant(id);
	System.out.println(dormantRow);
	out.print(dormantRow);
	
%>
