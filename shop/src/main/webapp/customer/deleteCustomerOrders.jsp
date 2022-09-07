<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	// 디버깅
	System.out.println("\n----------------------------------deleteCustomerOrders - start -------------------------------------\n");
	
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
	// 디버깅
	System.out.println("deleteCustomerOrders - orderNo : " + orderNo);
	
	// 디버깅
	System.out.println("\n----------------------------------deleteCustomerOrders - end --------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-2"></div>
		<!-- 메인페이지 -->
		<div class="col-lg-8"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Orders Delete</b>
			</h2>
			<hr>
			<br> <br>
			<form action="<%=request.getContextPath()%>/customer/deleteCustomerOrdersAction.jsp?orderNo=<%=orderNo%>" method="post" style="text-align: center; margin-bottom:5%;">
				<fieldset >
					<h2 style="margin-bottom:3%;"><b style="color:#673ab7;"><%=orderNo%>번</b> 주문을 삭제하시겠습니까?</h2>
					<button type="submit" class="btn btn-outline-danger" style="float: center;">네.</button>
					<a href="<%=request.getContextPath()%>/customerOrdersList.jsp">
					<button type="button" class="btn btn-outline-dark" style="float: center;">아니오.</button>
					</a> 
					<br><br><br>			
				</fieldset>
			</form>
			
		</div>
		<div class="col-lg-2"></div>
		<br>
	</div>
		<br> <br> 
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>