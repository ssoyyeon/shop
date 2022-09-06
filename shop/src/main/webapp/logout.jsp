<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//원래 session의 값을 지우기 - session reset
	session.invalidate();	
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	System.out.println("로그아웃 성공!");
%>