<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="java.util.Map"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
// 디버깅
System.out.println("----------------------------------customerOrdersOne - start ---------------------------------");

// 로그인 전이면 로그인 페이지로 재요청
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
// 디버깅
System.out.println("customerId : " + session.getAttribute("id"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
// 디버깅
System.out.println("customerOrdersOne - orderNo : " + orderNo);
System.out.println("customerOrdersOne - goodsNo : " + goodsNo);

// 상세보기 메서드 호출 
OrdersService ordersService = new OrdersService();
Map<String, Object> map = ordersService.selectOrdersOne(orderNo);
// 디버깅
System.out.println("customerOrdersOne : " + map);
// 디버깅
if (map != null) {
	System.out.println("주문 상세보기 성공");
}

// 리뷰 메서드 호출
ReviewService ReviewService = new ReviewService();
List<Map<String, Object>> list = ReviewService.getReviewListByGoods(goodsNo);
// 디버깅
System.out.println(list);
if (list != null) {
	System.out.println("리뷰보기 성공");
}
%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12" style="margin-top: 10%; background-color: #E9EDF1; margin-bottom:5%;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Order Detail</b>
			</h2>
			<hr>
			<br> <br>
			<table class="table table-hover table-striped">
				<thead>
					<tr style="width: 120px; text-align: center; ">
						<th><b>ordersNo</b></th>
						<th><b>orderDate</b></th>
						<th><b>goodsNo</b></th>
						<th><b>goodsImg</b></th>
						<th><b>orderPrice</b></th>
						<th><b>orderQuantity</b></th>
						<th><b>orderState</b></th>
					</tr>
				</thead>
				<tbody>
					<tr style="text-align: center;">
						<td><%=map.get("ordersNo")%></td>
						<td><%=map.get("orderDate")%></td>
						<td><%=map.get("goodsNo")%></td>
						<td><img alt="이미지 파일" src="<%=request.getContextPath()%>/upload/<%=map.get("orderImg")%>" width=200; height=200; style="background-color: white;"></td>
						<td><%=map.get("orderPrice")%></td>
						<td><%=map.get("orderQuantity")%></td>
						<td><%=map.get("orderState")%></td>
					</tr>
			</table>
			<br> <br>
		</div>
		<!-- ordersOne end -->
		<div style="float: right; margin-left :90%; ">
		<a href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp">
			<button type="submit" class="btn" style="background-color:black; color:white; margin-bottom:3%;">OrderList</button>
		</a>
	</div>
		<!-- review -->
		<div class="col-lg-12" style="margin-top: 3%; background-color: #E9EDF1;">
			<h3 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Review</b>
			</h3>
			<hr>
			<br> <br>
			<div>
				<table class="table table-hover table-striped" style="text-align: center;">
					<tr>
						<th><b>orderNo</b></th>
						<th><b>reviewContent</b></th>
						<th><b>createDate </b></th>
						<th><b>updateDate </b></th>
					</tr>
					<%
					for (Map<String, Object> m : list) {
						// 주문한 상품이 없는 경우
						System.out.println("list : " + m);
						if (m.isEmpty()) {
					%>
							<tr>
								<td>주문한 상품이 없습니다.</td>
							</tr>
					<%
						} else {
					%>
							<tr>
								<td><%=m.get("orderNo")%></td>
								<td><%=m.get("reviewContent")%></td>
								<td><%=m.get("createDate")%></td>
								<td><%=m.get("updateDate")%></td>
							</tr>
					<%
						}
					}
					%>
				</table>
			</div>
		</div>
		<!-- review end -->
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>

