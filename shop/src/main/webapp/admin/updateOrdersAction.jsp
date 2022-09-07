<%@page import="java.util.HashMap"%>
<%@page import="vo.Orders"%>
<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n------------------------------updateOrdersAction start-------------------------------------\n");
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 전송받은 값 map에 셋팅
	Map<String, Object> map = new HashMap<>();
	map.put("ordersNo", request.getParameter("ordersNo"));
	map.put("goodsNo", Integer.parseInt(request.getParameter("goodsNo")));
	map.put("orderQuantity", Integer.parseInt(request.getParameter("orderQuantity")));
	map.put("orderPrice", Integer.parseInt(request.getParameter("orderPrice")));
	map.put("orderState", request.getParameter("orderState"));
	// 디버깅
	System.out.println("adminOrdersList map : " + map);
	
	// 수정하기 메서드 호출
	OrdersService ordersService = new OrdersService();
	int updateOrders = ordersService.updateOrdersList(map);
	
	// 수정하기 성공 시 페이지 재요청
	if(updateOrders != 0){
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
	}
	

	// 디버깅
	System.out.println("\n------------------------------updateOrdersAction end-------------------------------------\n");
	
%>
