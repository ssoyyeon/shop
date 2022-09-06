<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------addGoodsReviewAction - start ---------------------------------");
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String reviewContent = request.getParameter("reviewContent");
	String customerId = ( (String )session.getAttribute("id") );
	// 디버깅
	System.out.println("addGoodsAction - orderNo : " + orderNo);
	System.out.println("addGoodsAction - reviewContent : " + reviewContent);
	System.out.println("addGoodsAction - customerId : " + customerId);
	
	// 추가하기 메서드 호출 
	ReviewService reviewService = new ReviewService();
	int row = reviewService.addReview(orderNo, reviewContent, customerId);
			
	if (row != 0) {
		System.out.println("리뷰 추가 성공");
		response.sendRedirect(request.getContextPath() + "/customer/customerReviewList.jsp");
	}
	//디버깅
	System.out.println("----------------------------------addGoodsReviewAction - end ---------------------------------\n");
%>