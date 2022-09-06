<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@page import="repository.OrdersDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("Customer")) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	// active가 Y이 아니면 접속 불가
	if (!session.getAttribute("active").equals("Y")) {
		response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println("active : " + session.getAttribute("active"));
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 현재 페이지 구하기
	int currentPage = 1;
	// 받아오는 페이지가 있을 경우
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅
	System.out.println("orderList - currentPage : " + currentPage);
	
	// 페이지 당 보여질 행 갯수
	final int rowPerPage = 10;
	
	// 쿼리 실행을 위한 객체 생성
	OrdersService ordersService = new OrdersService();
	
	// 마지막 페이지 호출
	int lastPage = ordersService.lastPage(currentPage, rowPerPage);
	// 디버깅
	System.out.println("orderList - lastPage : " + lastPage);
	
	// 주문 리스트
	List<Map<String, Object>> list = new ArrayList<>();
	list = ordersService.selectOrdersList(rowPerPage, currentPage);
	// 디버깅
	System.out.println("orderList - list : " + list);
	
	// 디버깅
	if (list != null) {
		System.out.println("orderList 출력 성공!");
	}
%>
<%@ include file="/inc/header.jsp"%>
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 주문량 chart -->
		<div class="col-lg-12"
			style="margin-bottom: 3%; margin-top: 6%;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>ORDER QUANTITY</b>
			</h2>
		<canvas id="myChart" style="width: 100%; max-width: 100%"></canvas>
		</div>
		<!-- 주문량 chart  end-->
		
		<!-- 메인페이지 -->
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-bottom: 6%; margin-top:3%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>ORDER LIST</b>
			</h2>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center;">
				<thead>
					<tr>
						<th>ordersNo</th>
						<th>orderDate</th>
						<th>goodsNo</th>
						<th>orderPrice</th>
						<th>orderQuantity</th>
						<th>customerId</th>
						<th>orderAddress</th>
						<th>orderState</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/admin/adminOrdersOne.jsp?ordersNo=<%=o.get("orders_no")%>">
								<%=o.get("orders_no")%>
						</a></td>
						<td><%=o.get("create_date")%></td>
						<td><%=o.get("goods_no")%></td>
						<td><%=o.get("order_price")%></td>
						<td><%=o.get("order_quantity")%></td>
						<td><a
							href="<%=request.getContextPath()%>/admin/customerOrderOne.jsp?customerId=<%=o.get("customer_id")%>">
								<%=o.get("customer_id")%>
						</a></td>
						<td><%=o.get("order_address")%></td>
						<td><%=o.get("order_state")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<!-- 주문 리스트 end -->
		<!-- 페이징 -->
		<div class="container" style="text-align: center;">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary">Pre</button>
			</a>
			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary" disabled="disabled">Pre</button>
			</a>
			<%
			}
			if (currentPage < lastPage) {
			// 디버깅
			System.out.println("lastPage : " + lastPage);
			System.out.println("currentPage : " + currentPage);
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp?currentPage=<%=currentPage + 1%>">
				<button type="submit" class="btn btn-dark">Next</button>
			</a>

			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminrOrdersList.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
			</a>
			<%
			}
			%>
		</div>
		<!--  end 페이징 -->
	</div>
	<!-- end row -->
</div>
<!-- end container -->
<%@ include file="/inc/footer.jsp"%>
</body>
<script>
	var xValues = [ "Clothing", "Shoes", "Bags", "Hats" ];
	var yValues = [ 60, 87, 24, 34, 25 ];
	var barColors = [ "red", "green", "blue", "orange"];

	new Chart("myChart", {
		type : "bar",
		data : {
			labels : xValues,
			datasets : [ {
				backgroundColor : barColors,
				data : yValues
			} ]
		},
		options : {
			legend : {
				display : false
			},
			title : {
				display : true
			}
		}
	});
</script>
</html>