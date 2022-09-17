<%@page import="service.Cartservice"%>
<%@page import="java.util.Arrays"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="vo.Cart"%>
<%@page import="service.BuyService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
System.out.println("\n-----------------------directBuyAction start--------------------------------");

// 인코딩
request.setCharacterEncoding("UTF-8");

//요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = ((String) session.getAttribute("id"));
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
String orderPrice = request.getParameter("orderPrice");
int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));

// 디버깅
System.out.println("directBuyAction - goodsNo : " + goodsNo);
System.out.println("directBuyAction - customerId : " + customerId);
System.out.println("directBuyAction - address : " + address);
System.out.println("directBuyAction - detailAddress : " + detailAddress);
System.out.println("directBuyAction - orderPrice : " + orderPrice);
System.out.println("directBuyAction - orderQuantity : " + orderQuantity);


// 주문리스트 추가  메서드 파라미터에 값 설정
Orders orders = new Orders();

// orders setter
orders.setCustomerId(customerId);
orders.setDetailAddr(detailAddress);
orders.setGoodsNo(goodsNo);
orders.setOrderAddr(address);
orders.setOrderPrice(orderPrice);
orders.setOrderQuantity(orderQuantity);

//주문메서드 호출할 객체 생성
OrdersService ordersService = new OrdersService();

// 주문 메서드 실행
int addOrders = ordersService.insertCustomerOrders(orders);

if (addOrders != 0) {
	System.out.println("directBuyAction - 주문성공 ");
	// 주문 성공시 페이지 재요청
	response.sendRedirect(request.getContextPath() + "/customer/customerOrdersList.jsp");
}
System.out.println("\n-----------------------buyGoodsAction end--------------------------------");
%>