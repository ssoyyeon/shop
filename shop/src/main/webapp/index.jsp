<%@page import="vo.Employee"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 전이면 로그인 페이지로 돌아가기
	if(session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	if(session.getAttribute("user").equals("Customer")){
		response.sendRedirect(request.getContextPath()+"/customerIndex.jsp");
		return;
	}
	if(session.getAttribute("user").equals("Employee")){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>    