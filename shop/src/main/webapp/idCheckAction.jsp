<%@page import="service.SignService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String ckid = request.getParameter("ckid");
	// 디버깅
	System.out.println("idCheckAction - ckid : " + ckid);
	
	// 아이디 중복검사 메서드 호출 객체 생성
	SignService signService = new SignService();
	
	boolean sign = signService.idCheck(ckid);
	
	if(sign == true){
		System.out.println("중복 x");
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp");
	}
%>