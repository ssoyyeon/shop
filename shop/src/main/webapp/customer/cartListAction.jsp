<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%
// 디버깅
System.out.println("\n--------------------------------------cartListAction start-------------------------------------------\n");

// 장바구니 리스트 선택을 하지 않았을 경우 막기
if (request.getParameterValues("goodsNo").length == 0) {
	response.sendRedirect(request.getContextPath() + "/customer/cartList.jsp");
	return;
}

// 요청값 받아오기
// 장바구니에서 선택한 값의 개수가 여러개이므로 배열 객체로 값을 받아옴
String[] goodsNo = request.getParameterValues("goodsNo");
// 디버깅
System.out.println("선택한 상품의 개수 " + request.getParameterValues("goodsNo").length);
System.out.println("cartListAction - goodsNo : " + Arrays.toString(goodsNo));

//디버깅
System.out.println(
		"\n--------------------------------------cartListAction end-------------------------------------------\n");
%>