<%@page import="vo.Cart"%>
<%@page import="service.Cartservice"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 디버깅
System.out.println("\n--------------------------------------cartList start-------------------------------------------\n");

// 로그인 전, 고객이 아니면 접속 불가
if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("Employee")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// 디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

//인코딩
request.setCharacterEncoding("utf-8");

// 변수 가져오기
String customerId = ((String) session.getAttribute("id"));
// 디버깅
System.out.println("CartList - customerId : " + customerId);

// 페이징
// 한 페이지 당 보여질 게시물 수
final int rowPerPage = 10;

// 현재 페이지
int currentPage = 1;
// 받아오는 페이지 값이 있다면 현재 페이지 변경
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
// 디버깅
System.out.println("CartList - currentPage : " + currentPage);

// 메서드 호출을 위한 객체 생성
Cartservice cartService = new Cartservice();

// 마지막 페이지 메서드 호출 
int lastPage = cartService.lastPage(rowPerPage, currentPage, customerId);
// 디버깅
System.out.println("CartList - lastPage : " + lastPage);


// 장바구니 리스트 호출
List<Map<String, Object>> list = new ArrayList<>();
list = cartService.selectCartListByCustomer(customerId);
// 디버깅
System.out.println("CartList - list : " + list);

if (list != null) {
	System.out.println("CartList 출력 성공!");
}
//디버깅
System.out.println("\n--------------------------------------cartList end-------------------------------------------\n");
%>

<%@ include file="/inc/header.jsp"%>
<body>
	<div class="container">
		<div class="row">
			<!-- 로그인이 되어있지 않으면 장바구니리스트 보여주지 않음 -->
			<%
			if (session.getAttribute("id") == null || list.isEmpty()) {
			%>
			<div class="col-lg-12"
				style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">
				<h2 style="font-size: 40px; margin-top: 5%; height: 213px;">
					<b>장바구니에 담긴 상품이 없습니다.</b>
				</h2>
				<a href="<%=request.getContextPath()%>/main.jsp"><button
						type="button" class="btn btn-dark">홈으로 가기</button></a>
			</div>
			<%
			} else {
			%>
			<!-- 메인페이지 -->
			<div class="col-lg-12"
				style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">
				<h2 style="font-size: 40px; margin-top: 5%;">
					<b><%=customerId%>'s Cart List</b>
				</h2>
				<form
					action="<%=request.getContextPath()%>/customer/cartListAction.jsp"
					method="post">
					<table class="table table-striped">
						<thead class="thead-light">
							<tr>
								<th><b>goods</b></th>
								<th><b>goodsName</b></th>
								<th><b>cartQuantity</b></th>
								<th><b>createDate</b></th>
								<th><b>updateDate</b></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Map<String, Object> n : list) {
							%>
							<tr>
								<td>
									<input type="checkbox" name="goodsNo" value="<%=n.get("goodsNo")%>">
								</td>
								<td>
									<input type="hidden" name=goodsName value="<%=n.get("goodsName")%>"><%=n.get("goodsName")%>
								</td>
								<td>
									<input type="hidden" name="cartQuantity" value="<%=n.get("cartQuantity")%>"><%=n.get("cartQuantity")%>
								</td>
								<td><input type="hidden" name="goodsPrice" value="<%=n.get("goodsPrice")%>"><%=n.get("goodsPrice")%>won</td>
								<td><a
									href="<%=request.getContextPath()%>/customer/deleteCarListForm.jsp?goodsNo=<%=n.get("goodsNo")%>">
										<button type="submit" class="btn btn-danger"
											style="color: white; background-color: black;">Delete</button>
								</a> <a
									href="<%=request.getContextPath()%>/customer/updateCartQuantity.jsp?goodsNo=<%=n.get("goodsNo")%>&cartQuantity=<%=n.get("cartQuantity")%>&">
										<button type="submit" class="btn btn-warning"
											style="color: white; background-color: black;">Modify</button>
								</a></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
					<button type="submit" class="btn"
						style="width: 300px; font-size: 50px; border: 2px solid; margin-top: 6%; margin-bottom: 3%; float: center; background-color: white; border-color: black;">
						<b>Order</b>
					</button>
				</form>
				<br> <br>
			</div>
			<%
			}
			%>
		</div>
		<!--  end row -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<div class="container" style="text-align: center; margin-top: 5%;">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/cartList.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary">Pre</button>
			</a>
			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/cartList.jsp?currentPage=<%=currentPage - 1%>">
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
				href="<%=request.getContextPath()%>/customer/cartList.jsp?currentPage=<%=currentPage + 1%>">
				<button type="submit" class="btn btn-dark">Next</button>
			</a>

			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/cartList.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
			</a>
			<%
			}
			%>
		</div>
	</div>
	<!-- end container -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>