<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="java.util.Map"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
// 디버깅
System.out.println("\n----------------------------------customerOrdersOne - start -----------------------------------------\n");

// 로그인 전이면 로그인 페이지로 재요청
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
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
//디버깅
System.out.println("\n----------------------------------cutomerOrdersOne - end ---------------------------------------\n");
%>
<!-- main -->
<div class="container" style="margin-bottom: 5%;">
	<div class="row"
		style="margin-top: 6%; background-color: #E9EDF1; text-align: center;">
		<!-- 메인페이지 -->
		<div class="col-lg-5 mt-5" style="">
			<img class="card-img img-fluid"
				src="<%=request.getContextPath()%>/upload/<%=map.get("orderImg")%>"
				width=200; height=200; style="background-color: white;">
		</div>
		<div class="col-lg-7">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Order Detail</b>
			</h2>
			<hr>
			<table class="table table-hover table-striped">
				<thead>
					<tr style="width: 120px; text-align: center;">
						<th><b>goodsName</b></th>
						<td><%=map.get("goodsName")%></td>
					</tr>
					<tr>
						<th><b>customerId</b></th>
						<td><%=map.get("customerId")%></td>
					</tr>
					<tr>
						<th><b>customerAddress</b></th>
						<td><%=map.get("orderAddress")%>-<%=map.get("detailAddress")%></td>
					</tr>
					<tr>
						<th><b>orderPrice</b></th>
						<td><%=map.get("orderPrice")%></td>
					</tr>
					<tr>
						<th><b>orderQuantity</b></th>
						<td><%=map.get("orderQuantity")%></td>
					</tr>
					<tr>
						<th><b>orderState</b></th>
						<td><%=map.get("orderState")%></td>
					</tr>
					<tr>
						<th><b>orderDate</b></th>
						<td><%=map.get("orderDate")%></td>
					</tr>
			</table>
		</div>
	</div>
	<!-- goodsOne end -->
	<!-- review start -->
	<div class="container" style="margin-top: 5%;">
		<div class="row">
			<!-- ordersOne end -->
			<div style="float: right; margin-left: 90%; margin-bottom: 5%;">
				<a
					href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp">
					<button type="submit" class="btn"
						style="background-color: black; color: white; margin-bottom: 3%;">OrderList</button>
				</a>
			</div>
			<!-- review -->
			<div class="col-lg-12"
				style="margin-top: 3%; background-color: #E9EDF1;">
				<h3 style="font-size: 40px; text-align: center; margin-top: 5%;">
					<b>Review</b>
				</h3>
				<hr>
				<br> <br>
				<div>
					<table class="table table-hover table-striped"
						style="text-align: center;">
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
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>