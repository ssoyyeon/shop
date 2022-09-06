<%@page import="service.Cartservice"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n\n----------------------------------updateCartQuantityAction- start ---------------------------------"); 
	
	// 요청값 처리
	String customerId = ((String) session.getAttribute("id"));
	int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("updatecartQuantityAction - customerId : " + customerId);
	System.out.println("updatecartQuantityAction - goodsNo : " + goodsNo);
	System.out.println("updatecartQuantityAction - cartQuantity : " + cartQuantity);
	
	// modifyCustomerPw 매개변수 setter
	Cart paracart= new Cart();
	paracart.setCartQuantity(cartQuantity);
	paracart.setGoodsNo(goodsNo);
	paracart.setCustomerId(customerId);
	// 디버깅
	System.out.println("updatecartQuantityAction - paracart : " + paracart);
	
	// 수량 수정 메서드 호출 객체 생성
	Cartservice cartService = new Cartservice();
		
	// 수량 수정 메서드 호출 
	int cart = cartService.modifyCartList(paracart);
	
	if (cart != 0) {
		System.out.println("주문 수량 수정 성공");
		response.sendRedirect(request.getContextPath() + "/customer/cartList.jsp");
	}
	
	//디버깅
	System.out.println("----------------------------------updatecartQuantityAction- end ---------------------------------\n\n"); 
%>