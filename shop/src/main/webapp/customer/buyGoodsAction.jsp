<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="vo.Cart"%>
<%@page import="service.BuyService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
System.out.println("\n-----------------------addCutomerOrdersAction start--------------------------------");

//요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = request.getParameter("customerId");

// 디버깅
System.out.println("addCutomerOrdersAction - goodsNo : " + goodsNo);
System.out.println("addCutomerOrdersAction - CustomerId : " + customerId);

// 주문하기 메서드 호출할 객체 생성
BuyService buyService = new BuyService();

// 주문하기 메서드 파라미터에 값 설정
Cart paracart = new Cart();
paracart.setCustomerId(customerId);
paracart.setGoodsNo(goodsNo);

// 설정한 값 넣어주기
List<Cart> cart = new ArrayList<>();
cart.add(paracart);

// 주문하기 메서드 실행
buyService.getBuyByCartList(cart);

// 주문리스트 추가  메서드 파라미터에 값 설정
Orders order = new Orders();
order.setCustomerId(customerId);
order.setDetailAddr(detailAddress);
order.setGoodsNo(goodsNo);
order.setOrderQuantity(orderQuantity);
order.setOrderPrice(orderPrice);
order.setOrderAddr(orderAddress);
// 주문리스트 추가 메서드 호출할 객체 생성
OrdersService ordersService = new OrdersService();

// 주문리스트 추가하기
ordersService.insertCustomerOrders(order);

// 주문 성공시 페이지 재요청
if(buyService.getBuyByCartList(cart) != null){
	System.out.println("주문 성공");
	response.sendRedirect(request.getContextPath()+"/customer/orderList.jsp");
}
System.out.println("\n-----------------------addCutomerOrdersAction end--------------------------------");
%>