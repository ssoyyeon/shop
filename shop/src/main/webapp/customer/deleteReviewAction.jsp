<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------deleteReviewAction - start ---------------------------------");
	// 요청값 처리
	String customerId = ((String) session.getAttribute("id"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println("deleteReviewAction - customerId  : " + customerId);
	System.out.println("deleteReviewAction - goodsNo  : " + goodsNo);
	System.out.println("deleteReviewAction - orderNo  : " + orderNo);
	
	// 삭제할 데이터를 넣기 위한 객체 생성 후 삭제할 데이터값 설정
	Review review = new Review();
	
	// 삭제 메서드를 호출하기 위한 객체 생성 후 호출
	ReviewService reviewSerivce = new ReviewService();
	
	// 성공시 페이지 재요청하기 위한 변수 선언, 리뷰삭제 메서드 호출 
	int row = reviewSerivce.removeReview(goodsNo, customerId);
	// 디버깅
	System.out.println("deleteReviewForm - row : " + row);
	
	// 성공시 페이지 재요청
	if (row != 0) {
		// 디버깅
		System.out.println("remove 성공");
		response.sendRedirect(request.getContextPath() + "/customer/customerGoodsList.jsp");
	}
	// 디버깅
	System.out.println("----------------------------------deleteReviewAction - end ---------------------------------\n");
%>