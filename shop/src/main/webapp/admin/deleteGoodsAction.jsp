<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청값 처리
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	
	// 삭제하기 메서드 호출 
	GoodsService goodsService = new GoodsService();
	int goods = goodsService.deleteGoods(goodsNo);

	if (goods != 0) {
		System.out.println("상픔 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/adminGoodsList.jsp");
	}
%>