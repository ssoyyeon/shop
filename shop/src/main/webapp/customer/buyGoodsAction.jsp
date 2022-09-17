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
System.out.println("\n-----------------------buyGoodsAction start--------------------------------");

// 인코딩
request.setCharacterEncoding("UTF-8");

//요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = ((String) session.getAttribute("id"));
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
String[] orderPrice = request.getParameterValues("orderPrice");
int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));

// 디버깅
System.out.println("addCutomerOrdersAction - goodsNo : " + goodsNo);
System.out.println("addCutomerOrdersAction - customerId : " + customerId);
System.out.println("addCutomerOrdersAction - address : " + address);
System.out.println("addCutomerOrdersAction - detailAddress : " + detailAddress);
System.out.println("addCutomerOrdersAction - cartQuantity : " + cartQuantity);
System.out.println(Arrays.toString(orderPrice));

// session 안에 cartList 가져오기
List<Cart> cartList = (List<Cart>) session.getAttribute("cartList");
// 디버깅
System.out.println("buyGoodsAction - cartList : " + cartList.toString());

// 리턴값 반환할 객체
List<Object> addOrders = new ArrayList<>();

// 주문메서드 호출할 객체 생성
OrdersService ordersService = new OrdersService();

// 주문리스트 추가  메서드 파라미터에 값 설정
for (int i = 0; i < cartList.size(); i++) {
	Orders orders = new Orders();

	// orders setter
	orders.setGoodsNo(cartList.get(i).getGoodsNo());
	orders.setCustomerId(cartList.get(i).getCustomerId());
	orders.setOrderQuantity(cartList.get(i).getCartQuantity());
	orders.setOrderPrice(orderPrice[i]);
	orders.setOrderAddr(request.getParameter("address"));
	orders.setDetailAddr(request.getParameter("detailAddress"));

	// 주문리스트 추가하기
	addOrders.add(ordersService.insertCustomerOrders(orders));
}

for (Object o : addOrders) {
	System.out.println("buyGoodsAction - addOrders : " + o);
}

if (addOrders != null) {
	
	// 장바구니 삭제 메서드 호출하기 위한 객체 생성
	Cartservice cartservice = new Cartservice();
	
	// 주문하기 성공시 cartList에서 삭제
	int removecartList = cartservice.removecartList(goodsNo, customerId);

	// cartList에서 삭제 성공시 페이지 재요청
	if(removecartList != 0){
	response.sendRedirect(request.getContextPath() + "/customer/customerIndex.jsp");
	}
}
System.out.println("\n-----------------------buyGoodsAction end--------------------------------");
%>