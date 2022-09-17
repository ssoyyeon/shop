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
System.out
		.println("\n----------------------------------customerOrderOne - start -----------------------------------\n");

//로그인 전이거나 고객이 아니면 로그인 페이지로 돌아가기
if (session.getAttribute("id") == null || !(session.getAttribute("user").equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
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
System.out.println("customerOrdersList - customerId : " + customerId);

// 현재 페이지 구하기
int currentPage = 1;
// 받아오는 페이지가 있을 경우
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
// 디버깅
System.out.println("customerOrdersList - currentPage : " + currentPage);

// 페이지 당 보여질 행 갯수
final int ROW_PER_PAGE = 10;

// 쿼리 실행을 위한 객체 생성
OrdersService ordersService = new OrdersService();

// lastPage 구하는 메서드 호출
int lastPage = ordersService.lastPage(ROW_PER_PAGE, customerId);
// 디버깅
System.out.println("customerOrdersList - lastPage : " + lastPage);

// 고객 1인 상품 리스트 list = 모델값
List<Map<String, Object>> list = ordersService.selectOrdersListByCustomer(customerId, currentPage, ROW_PER_PAGE);
// 디버깅
System.out.println(
		"\n----------------------------------customerOrderOne - end -----------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- 분리하면 servlet / 연계기술 forword(request, response) / jsp -->
<!-- 모델값을 전달하기 위한 것, 객체로 전달 request.setAttribute( )   -> request가 끝나면 같이 사라짐 -->
<!--  view : 태그 -->

<!-- for/ if 대체 기술 -> 커스텀 태그(JSTL & EL) JSP -->
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 로그인이 되어있지 않으면 주문리스트 보여주지 않음 -->
		<%
		// 주문리스트가 비었다면
		if (session.getAttribute("id") == null || list.isEmpty()) {
		%>
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">
			<h2 style="font-size: 40px; margin-top: 5%; height: 213px;">
				<b>주문하신 상품이 없습니다.</b>
			</h2>
			<a href="<%=request.getContextPath()%>/main.jsp"
				style="margin-bottom: 5%;">
				<button type="button" class="btn btn-dark"
					style="margin-bottom: 5%;">홈으로 가기</button>
			</a>
		</div>
		<%
		} else {
		%>
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-bottom: 6%; margin-top: 5%; background-color: #E9EDF1;">
			<h2
				style="font-size: 35px; text-align: center; margin-top: 5%; margin-bottom: 6%;">
				<strong><%=customerId%>'s Order List</strong>
			</h2>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center;">
				<thead>
					<tr>
						<th>ordersNo</th>
						<th>goodsNo</th>
						<th>orderPrice</th>
						<th>orderQuantity</th>
						<th>orderState</th>
						<th>ordereDate</th>
						<th><b>Review</b></th>
						<th><b>Order</b></th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/customer/customerOrdersOne.jsp?goodsNo=<%=o.get("goodsNo")%>&orderNo=<%=o.get("orderNo")%>">
								<%=o.get("orderNo")%>
						</a></td>
						<td><a
							href="<%=request.getContextPath()%>/customer/customerGoodsOne.jsp?goodsNo=<%=o.get("goodsNo")%>&orderNo=<%=o.get("orderNo")%>"><%=o.get("goodsNo")%></a></td>
						<td><%=o.get("orderPrice")%></td>
						<td><%=o.get("orderQuantity")%></td>
						<td><%=o.get("orderState")%></td>
						<td><%=o.get("createDate")%></td>
						<%
						if (o.get("orderState").equals("배송완료")) {
						%>
						<td><a
							href="<%=request.getContextPath()%>/customer/addGoodsReview.jsp?goodsNo=<%=o.get("goodsNo")%>&orderNo=<%=o.get("orderNo")%>">
								<button type="submit" class="btn"
									style="color: white; background-color: black;">Write</button>
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
									style="float: right; margin-top: 5%; color: white; background-color: black;">Withdraw</button>
						</a> <a
							href="<%=request.getContextPath()%>/customer/updateCustomerOrders.jsp?orderNo=<%=o.get("orderNo")%>">
								<button type="submit" class="btn btn"
									style="float: right; margin-top: 5%; color: white; background-color: black;">Modify</button>
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
		<%
		}
		%>
		<!-- 페이징 -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<%
		// 주문리스트가 비었다면
		if (!(session.getAttribute("id") == null || list.isEmpty())) {
		%>
		<div class="container" style="text-align: center; margin-top: 5%;">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary">Pre</button>
			</a>
			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp?currentPage=<%=currentPage - 1%>">
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
				href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp?currentPage=<%=currentPage + 1%>">
				<button type="submit" class="btn btn-dark">Next</button>
			</a>

			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
			</a>
			<%
			}
			}
			%>
		</div>
		<!--  end 페이징 -->
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>