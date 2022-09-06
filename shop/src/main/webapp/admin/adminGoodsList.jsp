<%@page import="java.util.List"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@page import="repository.GoodsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null && ((String) session.getAttribute("user")).equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	// 디버깅
	System.out.println(session.getAttribute("id"));
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 현재 페이지
	int currentPage = 1;
	// 받아오는 페이지가 있을 경우
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// rowPerPage 처음에 값을 지정하여 변하지 않으므로 상수로 선언
	final int rowPerPage = 10;
	
	// 쿼리 실행을 위한 객체 생성
	GoodsService goodsService = new GoodsService();
	// 상품리스트 
	List<Goods> list = null;
	list = goodsService.selectGoodsListbyPage(rowPerPage, currentPage);
	// 페이징 마지막 페이지 메서드 호출
	int lastPage = goodsService.lastPage(rowPerPage, currentPage);
	
	// 디버깅
	System.out.println("----------------------------------adminGoodsList - end ---------------------------------");
%>

<%@ include file="/inc/header.jsp"%>
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12" style="margin-bottom: 6%; margin-top: 6%; background-color: #E9EDF1; text-align: center;">
			<h2 style="font-size: 40px; margin-top: 5%;">
				<b>GOODS LIST</b>
			</h2>
			<p>
				<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp">
					<button type="submit" class="btn btn-success"
						style="float: right; margin-bottom: 3%; margin-right: 5%; margin-bottom:3%;">AddGoods</button>
				</a>
			</p>
			<br>
			<hr>
			<!-- 상품목록/등록/수정(품절)/삭제(장바구니, 주문이 없는경우) -->
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>goodsNo</th>
						<th>goodsName</th>
						<th>goodsPrice</th>
						<th>createDate</th>
						<th>soldOut</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Goods good : list) {
					%>
					<tr>
						<td><%=good.getGoodsNo()%></td>
						<td><a
							href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?goodsNo=<%=good.getGoodsNo()%>"><%=good.getGoodsName()%></a></td>
						<td><%=good.getGoodsPrice()%></td>
						<td><%=good.getCreateDate()%></td>
						<td><%=good.getSoldOut()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

		</div>
	</div>
	<!-- 페이징 -->
	<!-- 페이징 -->
	<!-- 페이징 -->
	<div class="container" style="text-align: center;">
		<%
		if (currentPage > 1) {
		%>
		<a
			href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage - 1%>">
			<button type="submit" class="btn btn-secondary">Pre</button>
		</a>
		<%
		} else {
		%>
		<a
			href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage - 1%>">
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
			href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage + 1%>">
			<button type="submit" class="btn btn-dark">Next</button>
		</a>

		<%
		} else {
		%>
		<a
			href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage%>">
			<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
		</a>
		<%
		}
		%>
	</div>
	<!--  end 페이징 -->
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>
