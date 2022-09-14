<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
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
//디버깅
System.out.println("\n------------------------------------ customerOrdersOne - start ------------------------------------------------\n");

//admin이 아닐 경우 접속 불가
if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// 디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));
System.out.println("active : " + session.getAttribute("active"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
String customerId = request.getParameter("customerId");
// 디버깅
System.out.println("customerId : " + customerId);

//한 페이지당 게시물 수
int ROW_PER_PAGE = 20;
if (request.getParameter("ROW_PER_PAGE") != null) {
	ROW_PER_PAGE = Integer.parseInt(request.getParameter("ROW_PER_PAGE"));
}

//현재페이지
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

// 쿼리 실행을 위한 객체 생성
OrdersService ordersService = new OrdersService();
CustomerService customerService = new CustomerService();

// 1인 개인정보 가져오는 메서드
Customer customer = customerService.selecCustomerOne(customerId);

// 고객 1인 주문 리스트 list = 모델값
List<Map<String, Object>> list = ordersService.selectOrdersListByEmployee(customerId);
// 디버깅
System.out.println("\n---------------------------------------customerOrderOne - end ----------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-bottom: 6%; margin-top: 6%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b><%=customerId%> INFO</b>
			</h2>
			<br>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center;">
				<tr>
					<th>customerId</th>
					<td><%=customer.getCustomerId()%></td>
				</tr>
				<tr>
					<th>customerName</th>
					<td><%=customer.getCustomerName()%></td>
				</tr>
				<tr>
					<th>customerAddress</th>
					<td><%=customer.getCustomerAddress()%></td>
				</tr>
				<tr>
					<th>customerTelephone</th>
					<td><%=customer.getCustomerTelephone()%></td>
				</tr>
				<tr>
					<th>createDate</th>
					<td><%=customer.getCreateDate()%></td>
				</tr>
				<tr>
					<th>updateDate</th>
					<td><%=customer.getUpdateDate()%></td>
				</tr>
			</table>
		</div>

		<%
		// active가 Y이 수정, 삭제 불가
		if (session.getAttribute("active").equals("Y")) {
		%>
		<div style="margin-left: 77%;">
			<!-- 고객 임시 비밀번호  -->
			<a
				href="<%=request.getContextPath()%>/admin/updateCustomerForm.jsp?customerId=<%=customer.getCustomerId()%>">
				<button type="submit" class="btn btn"
					style="float: right; color: white; background-color: black;">ModifyPassword</button>
			</a>
			<!--  고객 계정 강제 삭제 -->
			<a
				href="<%=request.getContextPath()%>/admin/deleteCustomerForm.jsp?customerId=<%=customer.getCustomerId()%>">
				<button type="submit" class="btn btn"
					style="float: right; color: white; background-color: black;">DeleteAccount</button>
			</a>
		</div>
		<%
		}
		%>
	</div>
</div>
<div class="container">
	<div class="row">
		<div class="col-lg-12"
			style="margin-bottom: 6%; margin-top: 6%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>ORDER</b>
			</h2>
			<hr>
			<%
			// 상품목록/등록/수정(품절)/삭제(장바구니, 주문이 없는경우)
			if (list.isEmpty()) {
			%>
			<p style="font-size: 25px;  margin-bottom: 6%; margin-top: 6%; text-align: center;"><b>주문한 상품이 없습니다.</b></p>
			<%
			} else {
			%>
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>ordersNo</th>
						<th>ordereDate</th>
						<th>goodsNo</th>
						<th>orderPrice</th>
						<th>orderQuantity</th>
						<th>orderState</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/customer/customerOrdersOne.jsp?orderNo=<%=o.get("orderNo")%>">
								<%=o.get("orderNo")%>
						</a></td>
						<td><%=o.get("createDate")%></td>
						<td><%=o.get("goodsNo")%></td>
						<td><%=o.get("orderPrice")%></td>
						<td><%=o.get("orderQuantity")%></td>
						<td><%=o.get("orderState")%></td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<a href="<%=request.getContextPath()%>/admin/customerMemberList.jsp">
		<button type="submit" class="btn"
			style="float: right; color: white; background-color: black;">CustomerList</button>
	</a>
</div>
<%@ include file="/inc/footer.jsp"%>

</body>
</html>