<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------updateCustomerOrdersAction- start ---------------------------------"); 

	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println("updateCustomerOrdersAction - orderNo : " + orderNo);
	System.out.println("updateCustomerOrdersAction - orderQuantity : " + orderQuantity);
	
	
	// 주문 수정 메서드 호출하기 위한 객체 생성
	OrdersService orderService = new OrdersService();
	
	// 디버깅 변수 생성 후 주문 수정 메서드 호출하고 값 넣어주기
	int row = orderService.modifyCustomerOrder(orderNo , orderQuantity);
	
	
	if (row != 0) {
		System.out.println("주문 정보 수정 성공");
		response.sendRedirect(request.getContextPath() + "/customer/customerOrdersList.jsp");
	}
	
	//디버깅
	System.out.println("----------------------------------updateCustomerOrdersAction- end ---------------------------------\n"); 
%>