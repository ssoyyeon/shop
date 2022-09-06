<%@page import="java.util.Map"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
	//로그인 전이거나 스텝이 아니면 로그인 페이지로 돌아가기
	if (session.getAttribute("id") == null || session.getAttribute("user").equals("Customer")) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	//active가 Y이 아니면 접속 불가
	if (!(session.getAttribute("active").equals("Y"))) {
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
		return;
	}
	//디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println(session.getAttribute("active"));


	System.out.println("\n------------------------------adminOrdersOne-------------------------------------");
	
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 요청값 처리
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	// 디버깅
	System.out.println("ordersGoodsOne - ordersNo : " + ordersNo);
	
	// 상세보기 메서드 호출 
	OrdersService ordersService = new OrdersService();
	Map<String, Object> map = ordersService.selectOrdersOne(ordersNo);
	// 디버깅
	System.out.println("ordersGoodsOne : " +  map);
	// 디버깅
	if(map != null){
		System.out.println("주문 상세보기 성공");
	}
	
%>
	<!-- main -->
	<div class="container">
		<div class="row">
			<!-- 메인페이지 -->
			<div class="col-lg-12" style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>ORDERS DETAIL</b></h2>
					<hr><br><br>	
					<table class="table table-hover table-striped" >
					<thead>
							<tr style=" width: 120px; text-align: center;">
								<th><b>ordersNo</b></th>
								<th><b>orderDate</b></th>
								<th><b>goodsNo</b></th>
								<th><b>goodsImg</b></th>
								<th><b>orderPrice</b></th>
								<th><b>orderQuantity</b></th>
								<th><b>customerId</b></th>
								<th><b>orderAddress</b></th>
								<th><b>orderState</b></th>
							</tr>
						</thead>
						<tbody>
						<tr style="text-align:center;">
							<td><%=map.get("ordersNo") %></td>
							<td><%=map.get("orderDate") %></td>
							<td><%=map.get("goodsNo") %></td>
							<td><img alt="이미지 파일" src="<%=request.getContextPath()%>/upload/<%=map.get("orderImg")%>" width=200; height=200; style="background-color:white;"></td>	
							<td><%=map.get("orderPrice") %></td>
							<td><%=map.get("orderQuantity") %></td>
							<td><%=map.get("customerId") %></td>
							<td><%=map.get("orderAddress") %></td>
							<td><%=map.get("orderState") %></td>
							
						</tr>
					
					</table>
				<br><br>
			</div>
			<div  style=" float: right; margin-top:5%; margin-left: 86%;">
			<a href="<%=request.getContextPath()%>/admin/updateCustomerForm.jsp?ordersNo=<%=map.get("ordersNo") %>" >
				<button type="submit" class="btn" style=" color: white; background-color: black;" >Modify</button>	
				</a>
			<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">
					<button type="submit" class="btn" style=" color: white; background-color: black;">OrdersList</button>
				</a>
			</div>	
		</div>
	</div>
	<!-- end main -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>

			