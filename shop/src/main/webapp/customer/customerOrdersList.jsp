<%@page import="vo.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@page import="repository.OrdersDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 디버깅
System.out.println("----------------------------------customerOrderOne - start ---------------------------------");

//로그인 전이거나 고객이 아니면 로그인 페이지로 돌아가기
if (session.getAttribute("id") == null || !(session.getAttribute("user").equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
String customerId = ((String) session.getAttribute("id"));
// 디버깅
System.out.println("customerId : " + customerId);

// 현재 페이지 구하기
int currentPage = 1;
// 받아오는 페이지가 있을 경우
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
// 디버깅
System.out.println("customerMemberList - currentPage : " + currentPage);

// 페이지 당 보여질 행 갯수
final int rowPerPage = 10;

// 쿼리 실행을 위한 객체 생성
OrdersService ordersService = new OrdersService();

// lastPage 구하는 메서드 호출
int lastPage = ordersService.lastPage(rowPerPage, currentPage);
// 디버깅
System.out.println("customerMemberList - lastPage : " + lastPage);

// 고객 1인 상품 리스트 list = 모델값
List<Map<String, Object>> list = ordersService.selectOrdersListByCustomer(customerId);
// 디버깅
System.out.println("----------------------------------customerOrderOne - end ---------------------------------");
%>
<%@ include file="/inc/header.jsp"%>
<!-- 분리하면 servlet / 연계기술 forword(request, response) / jsp -->
<!-- 모델값을 전달하기 위한 것, 객체로 전달 request.setAttribute( )   -> request가 끝나면 같이 사라짐 -->
<!--  view : 태그 -->

<!-- for/ if 대체 기술 -> 커스텀 태그(JSTL & EL) JSP -->
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-bottom: 6%; margin-top: 5%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<strong><%=customerId%>'s OrderList</strong>
			</h2>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center;">
				<thead>
					<tr>
						<th><b>ordersNo</b></th>
						<th><b>ordereDate</b></th>
						<th><b>goodsNo</b></th>
						<th><b>orderPrice</b></th>
						<th><b>orderQuantity</b></th>
						<th><b>orderState</b></th>
						<th><b>review</b></th>
						<th><b>order</b></th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<%
						// 주문한 상품이 없는 경우
						if (o.isEmpty()) {
						%>
						<td style="font-size: 30px; margin-top: 10%;">주문한 상품이 없습니다.</td>
						<%
						}
						%>
						<td><a
							href="<%=request.getContextPath()%>/customer/customerOrdersOne.jsp?goodsNo=<%=o.get("goodsNo")%>&orderNo=<%=o.get("orderNo")%>">
								<%=o.get("orderNo")%>
						</a></td>
						<td><%=o.get("createDate")%></td>
						<td><a
							href="<%=request.getContextPath()%>/customer/customerGoodsOne.jsp?goodsNo=<%=o.get("goodsNo")%>&orderNo=<%=o.get("orderNo")%>"><%=o.get("goodsNo")%></a></td>
						<td><%=o.get("orderPrice")%></td>
						<td><%=o.get("orderQuantity")%></td>
						<td><%=o.get("orderState")%></td>
						<%
						if (o.get("orderState").equals("배송완료")) {
						%>
						<td><a
							href="<%=request.getContextPath()%>/customer/addGoodsReview.jsp?goodsNo=<%=o.get("goodsNo")%>&orderNo=<%=o.get("orderNo")%>">
								<button type="submit" class="btn btn-success"
									style="color: white; background-color:black; ">write</button>
						</a></td>
						<%
						} else {
						%>
						<td></td>
						<%
						}
						if (o.get("orderState").equals("배송전")) {
						%>
						<td><a
							href="<%=request.getContextPath()%>/customer/deleteCustomerOrders.jsp?orderNo=<%=o.get("orderNo")%>">
								<button type="submit" class="btn btn"
									style="float: right; margin-top: 5%; color: white; background-color:black;">Delete</button>
						</a> <a
							href="<%=request.getContextPath()%>/customer/updateCustomerOrders.jsp?orderNo=<%=o.get("orderNo")%>">
								<button type="submit" class="btn btn"
									style="float: right; margin-top: 5%; color: white; background-color:black;">Modify</button>
						</a></td>
						<%
						} else {
						%>
						<td></td>
						<%
						}
						%>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>