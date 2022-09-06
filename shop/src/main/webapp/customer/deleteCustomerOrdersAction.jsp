<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n----------------------------------deleteCustomerOrdersAction - start ---------------------------------");

	//요청값 처리
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println("deleteCustomerOrders - orderNo : " + orderNo);
	
	// 주문삭제 메서드 호출할 객체 생성
	OrdersService ordersService = new OrdersService();
	
	// 주문삭제 메서드 호출 
	int row = ordersService.removeCustomerOrder(orderNo);
	
	// 디버깅
	if (row != 0) {
		System.out.println("주문 삭제 성공");
		// 페이지 재요청
		response.sendRedirect(request.getContextPath()+"/customer/customerOrdersList.jsp");
	}
	
	// 디버깅
	System.out.println("----------------------------------deleteCustomerOrdersAction - end ---------------------------------\n");
%>