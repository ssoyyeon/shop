<%@page import="vo.Review"%>
<%@page import="service.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println("----------------------------------updateReviewAction - start ---------------------------------");

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
String reviewContent = request.getParameter("reviewContent");
// 디버깅
System.out.println("updateReviewAction - orderNo : " + orderNo);
System.out.println("updateReviewAction - reviewContent : " + reviewContent);

// 받아온 값 넣어줄 객체 생성
Review review = new Review();
// 값 넣어주기
review.setOrderNo(orderNo);
review.setReviewContent(reviewContent);
// 디버깅
System.out.println(review);

// 리뷰수정 메서드 호출을 위한 Service 객체 생성
ReviewService reviewService = new ReviewService();

// 리뷰수정 메서드 호출
int row = reviewService.modifyReview(review);
// 디버깅
if (row == 0) {
	System.out.println("리뷰 수정 실패");
} else {
	response.sendRedirect(request.getContextPath() + "/customer/customerReviewList.jsp");
	System.out.println("리뷰 수정 성공");
}
//디버깅
System.out.println("----------------------------------updateReviewAction - start ---------------------------------");
%>