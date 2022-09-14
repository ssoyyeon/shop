<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n------------------------------updateOrdersForm start-------------------------------------\n");
	
	//로그인 전이거나 스텝이 아니면 로그인 페이지로 돌아가기
	if (session.getAttribute("id") == null || session.getAttribute("user").equals("Customer")) {
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}
	// active가 Y이 아니면 접속 불가
	if (!(session.getAttribute("active").equals("Y"))) {
		response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println(session.getAttribute("active"));
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	// 디버깅
	System.out.println("ordersNo : " + ordersNo);
	
	//상세보기 메서드 호출 
	OrdersService ordersService = new OrdersService();
	Map<String, Object> map = ordersService.selectOrdersOne(ordersNo);
	// 디버깅
	System.out.println("updateOrdersForm : " +  map);
	
	// 디버깅
	System.out.println("------------------------------updateOrdersForm end-------------------------------------\n\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<!-- 메인페이지 -->
	<form
		action="<%=request.getContextPath()%>/admin/updateOrdersAction.jsp"
		method="post">
		<div class="row">
			<div class="col-lg-12"
				style="margin-top: 10%; background-color: #E9EDF1;">
				<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
					<b>UPDATE GOODS</b>
				</h2>
				<hr>
				<br> <br>
				<table class="table table-hover table-striped" style="text-align: center;">
						<tr style="width: 120px; text-align: center;">						
							<th><b>ordersNo</b></th>
							<td><input style="text-align: center; background-color:#dee2e6; border: #dee2e6; margin-left: -60%;" type="text" name="ordersNo" id="ordersNo" value="<%=ordersNo%>" readonly></td>
						</tr>
						<tr style="width: 120px; text-align: center;">		
							<th><b>goodsNo</b></th>
							<td><input style="text-align: center; background-color: #90e9e900; border: #90e9e900; margin-left:-60%; type="text" name="goodsNo" id="goodsNo" value="<%=map.get("goodsNo")%>" readonly></td>
						</tr>
						<tr style="width: 120px; text-align: center;">		
							<th><b>goodsImg</b></th>
							<td><img style="margin-left:-60%;" alt="이미지 파일"
								src="<%=request.getContextPath()%>/upload/<%=map.get("orderImg")%>"
								width=200; height=200; style="background-color: white;"></td>
						</tr>
						<tr style="width: 120px; text-align: center;">			
							<th><b>orderPrice</b></th>
							<td><input style="text-align: center; background-color:#90e9e900; border: #90e9e900; margin-left:-60%; type="text" name="orderPrice" id="orderPrice" value="<%=map.get("orderPrice")%>" readonly></td>
						</tr>
						<tr style="width: 120px; text-align: center;">		
							<th><b>orderQuantity</b></th>
							<td><input style="text-align: center; background-color:#dee2e6; border: #dee2e6; margin-left:-60%; type="text" name="orderQuantity" id="orderQuantity" value="<%=map.get("orderQuantity")%>" readonly></td>
						</tr>
						<tr style="width: 120px; text-align: center;">		
							<th><b>customerId</b></th>
							<td><input style="text-align: center; background-color:#90e9e900; border: #90e9e900; margin-left:-60%; type="text" name="customerId" id="customerId" value="<%=map.get("customerId")%>" readonly></td>
						</tr>
						<tr style="width: 120px; text-align: center;">			
							<th><b>orderAddress</b></th>
							<td><input style="text-align: center; background-color:#dee2e6; border: #dee2e6; margin-left:-60%; type="text" name="orderAddress" id="orderAddress" value="<%=map.get("orderAddress")%>" readonly></td>
						</tr>
						<tr style="width: 120px; text-align: center;">			
							<th><b>orderState</b></th>
							<td><select name="orderState" id="orderState" style="margin-left:-60%;">
									<option>:::배송상태:::</option>
									<option value="배송전">배송전</option>
									<option value="배송중">배송중</option>
									<option value="배송완료">배송완료</option>
									<option value="배송취소">배송취소</option>
							</select></td>
						</tr>
					</tbody>
				</table>
				<br> <br>
			</div>
			<!-- end col-12 -->
		</div>
		<!-- end row -->
		<div style="float: right; margin-top: 5%; margin-left: 80%;">
			<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">
				<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-bottom: 5%;">OrdersList</button>
			</a> <a
				href="<%=request.getContextPath()%>/admin/updateOrdersAction.jsp?ordersNo=<%=map.get("ordersNo")%>">
				<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-bottom: 5%;">ModifyOrders</button>
			</a>
		</div>
	</form>
</div>
<!-- end container -->
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>