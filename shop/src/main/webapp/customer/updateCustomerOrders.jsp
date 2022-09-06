<%@page import="java.util.Map"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
// 디버깅
System.out.println("\n----------------------------------updateCustomerOrders- start ---------------------------------");

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
// 디버깅
System.out.println("customerOrdersOne - orderNo : " + orderNo);

// 상세보기 메서드 호출 
OrdersService ordersService = new OrdersService();
Map<String, Object> map = ordersService.selectOrdersOne(orderNo);
// 디버깅
System.out.println("customerOrdersOne : " + map);
// 디버깅
if (map != null) {
	System.out.println("주문 상세보기 성공");
}

//디버깅
System.out.println("----------------------------------updateCustomerOrders- end ---------------------------------\n");
%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Modify Order </b>
			</h2>
			<hr>
			<br> <br>
			<form action="<%=request.getContextPath()%>/customer/updateCustomerOrdersAction.jsp" method="post">
				<table class="table table-hover table-striped" class="form-group">
					<tr>
						<td style="text-align: center;"><b>ordersNo</b></td>
						<td><input type="hidden" name="orderNo"
							value="<%=orderNo%>"><%=orderNo%></td>
					</tr>
					<tr>
						<td style="text-align: center;"><b>goodsNo</b></td>
						<td><%=map.get("goodsNo")%></td>
					</tr>
					<tr>
						<td style="text-align: center;"><b>orderPrice</b></td>
						<td><%=map.get("orderPrice")%></td>
					</tr>
					<tr>
						<td style="text-align: center;"><b>orderAddress</b></td>
						<td><%=map.get("orderAddress")%></td>
					</tr>
					<tr>
						<td style="text-align: center;"><b>orderQuantity</b></td>
						<td><%=map.get("detailAddress")%></td>
					</tr>
					<tr>
						<td style="text-align: center;"><b>orderQuantity</b></td>
						<td><input type="text" name="orderQuantity"
							value="<%=map.get("orderQuantity")%>" id="orderQuantity" class="form-control"></td>
					</tr>
					<tr>
						<td style="text-align: center;"><b>orderState</b></td>
						<td><%=map.get("orderState")%></td>
					</tr>
				</table>
				<div style="margin-top:5%; margin-bottom:5%;">
					<a href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp">
						<button type="submit" class="btn btn-success"
							style="float: right; margin-bottom:5%;">OrderList</button>
					</a> 
					<button type="submit" class="btn btn-warning" style="float: right;margin-bottom:5%; color:white; ">ModifyOrder</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>

