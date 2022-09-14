<%@page import="service.Cartservice"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%
// 디버깅
System.out.println(
		"\n--------------------------------------cartListAction start-------------------------------------------\n");

// 요청값 받아오기
// 장바구니에서 선택한 값의 개수가 여러개이므로 배열 객체로 값을 받아옴
String[] goodsNo = request.getParameterValues("goodsNo");
// 디버깅
System.out.println("선택한 상품의 개수 : " + request.getParameterValues("goodsNo").length);
System.out.println("cartListAction - goodsNo : " + Arrays.toString(goodsNo));

// CartList 조회하기 위한 파라미터 만들기
Cart paramCart = new Cart();
paramCart.setCustomerId((String) session.getAttribute("id"));

// 장바구니 리스트를 가져오기 위한 객체 생성
Cartservice cartService = new Cartservice();
// 장바구니 리스트 가져오기
List<Map<String, Object>> cartList = cartService.selectCartListByCustomer(paramCart);

// 주문할 상품 정보 담을 객체 생성
List<Cart> list = new ArrayList<>();
// 디버깅
System.out.println("cartAction.jsp cartListSize : " + cartList.size());

// list에 주문할 상품 담기
for (int i = 0; i < goodsNo.length; i++) {
	// 한 상품씩 담아주기
	Cart cart = new Cart();

	cart.setCartQuantity((Integer) cartList.get(i).get("cartQuantity"));
	cart.setCustomerId((String) session.getAttribute("id"));
	cart.setGoodsNo(Integer.parseInt(goodsNo[i]));

	list.add(cart);
	// 디버깅
	System.out.println("getGoodsNo() : "  + cart.getGoodsNo());
	System.out.println("cartAction list : " + list);
}

// 세션에 장바구니리스트 담기
session.setAttribute("cartList", list);
// 디버깅
System.out.println(" cartList: " + session.getAttribute("cartList"));
// 주문 페이지로 보내기
response.sendRedirect(request.getContextPath() + "/customer/buyGoods.jsp");

System.out.println( "\n--------------------------------------cartListAction end-------------------------------------------\n");
%>s
