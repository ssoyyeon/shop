<%@page import="service.Cartservice"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------addCartListAction - start ---------------------------------");
	
	// 요청값 처리
	int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println("addCartListAction - cartQuantity : " + cartQuantity);
	System.out.println("addCartListAction - goodsNo : " + goodsNo);
	System.out.println("addCartListAction - customerId : " + customerId);
	
	// 받아온 값 넣어줄 객체 생성
	Cart paraCart = new Cart();
	// 값 넣어주기
	paraCart.setCartQuantity(cartQuantity);
	paraCart.setCustomerId(customerId);
	paraCart.setGoodsNo(goodsNo);
	
	// 디버깅
	System.out.println("addCartListAction - paraCart : " + paraCart);
	
	// 리뷰수정 메서드 호출을 위한 Service 객체 생성
	Cartservice cartService = new Cartservice();
	
	// 리뷰수정 메서드 호출
	int  row = cartService.addcartList(paraCart);
	
	// 디버깅
	if(row != 0){
		response.sendRedirect(request.getContextPath() + "/customer/cartList.jsp");
		System.out.println("장바구니 추가성공");
	}
	//디버깅
	System.out.println("----------------------------------addCartListAction -  end ---------------------------------\n");
	%>