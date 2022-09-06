<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
System.out.println("\n-----------------------addCutomerOrdersAction start--------------------------------");

//요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = request.getParameter("customerId");
String customerName = request.getParameter("customer_name");
String customerAddress = request.getParameter("customer_address");
String detailAddress = request.getParameter("detail_address");
// 디버깅
System.out.println("addCutomerOrdersAction - goodsNo : " + goodsNo);
System.out.println("addCutomerOrdersAction - CustomerId : " + customerId);
System.out.println("addCutomerOrdersAction - CustomerName : " + customerName);
System.out.println("addCutomerOrdersAction - CustomerAddress : " + customerAddress);
System.out.println("addCutomerOrdersAction - detailAddress : " + detailAddress);
/*
// 값 설정할 객체 생성 후 파라미터 값 넣어주기
Orders order = new Orders();
order.setGoodsNo(goodsNo);
order.setCustomerId(customerId);
order.setDetailAddr(detailAddr);
order.setOrderAddr(orderAddr);
order.set
// 주문하기 메서드 호출할 객체 생성 후 호출
OrdersService ordersService = new OrdersService();
int orderGoods = ordersService.insertCustomerOrders(order);

//디버깅
if (orderGoods != 0) {
	System.out.println("주문하기 성공");
}
*/
System.out.println("\n-----------------------addCutomerOrdersAction end--------------------------------");
%>