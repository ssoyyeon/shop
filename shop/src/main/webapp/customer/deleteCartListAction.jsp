<%@page import="service.Cartservice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//디버깅
	System.out.println("\n-------------------------------deleteCartListAction start--------------------------------");

	// 요청값 처리
	String customerId = request.getParameter("customerId");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("deleteCartListAction - customerId : " + customerId);
	System.out.println("deleteCartListAction - goodsNo : " + goodsNo);
	
	// 리뷰삭제 메서드 호출 
	Cartservice cartService = new Cartservice();
	int row = cartService.removecartList(goodsNo, customerId);
	// 디버깅
	System.out.println("deleteCartListForm - row : " + row);
	
	// 장바구니 삭제 성공시 페이지 재요청
	if(row != 0){
		System.out.println("장바구니 리스트 삭제 성공!");
		response.sendRedirect(request.getContextPath()+"/customer/cartList.jsp");
	}
	
	// 디버깅
	System.out.println("------------------------------deleteCartListAction end---------------------------------------\n");
%>