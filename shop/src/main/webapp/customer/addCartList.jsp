<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 디버깅
System.out.println("\n----------------------------------addCartList - start ---------------------------------\n");

// 로그인 전이면 로그인 페이지로 재요청
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// 디버깅
System.out.println("id : " + session.getAttribute("id"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 디버깅
System.out.println("1" + request.getParameter("goodsNo"));

// 요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = ((String) session.getAttribute("id"));
// 디버깅
System.out.println("goodsNo : " + goodsNo);
System.out.println("customerId : " + customerId);

// 상품 상세보기 메서드 호출
GoodsService goodsService = new GoodsService();
Map<String, Object> selectGoods = goodsService.selectGoodsAndImgOne(goodsNo);
// 디버깅
if (selectGoods != null) {
	System.out.println("상세보기 성공");
}

// 디버깅
System.out.println("\n----------------------------------addCartList - end ---------------------------------\n");
%>
<!-- header -->
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- goodsOne start -->
		<div class="col-lg-12"
			style="margin-top: 6%; background-color: #E9EDF1; text-align: center;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Goods Detail</b>
			</h2>
			<br> <br>
			<table class="table table-hover table-striped">
				<thead>
					<tr style="width: 120px; text-align: center;">
						<th><b>goodseNo</b></th>
						<th><b>goodsName</b></th>
						<th><b>goodsImg</b></th>
						<th><b>goodsPrice</b></th>
						<th><b>soldOut</b></th>
						<th><b>createDate</b></th>
					</tr>
				</thead>

				<tr>
					<td><%=goodsNo%></td>
					<td><%=selectGoods.get("goodsName")%></td>
					<td><img alt="이미지 파일"
						src="<%=request.getContextPath()%>/upload/<%=selectGoods.get("filename")%>"
						width=200; height=200; style="background-color: white;"></td>
					<td><%=selectGoods.get("goodsPrice")%></td>
					<td><%=selectGoods.get("soldOut")%></td>
					<td><%=selectGoods.get("createDate")%></td>
				</tr>
			</table>
			<!-- goodsOne end -->
			<!-- 장바구니에 담을 수량 start-->
			<form
				action="<%=request.getContextPath()%>/customer/addCartListAction.jsp"
				method="post"
				style="text-align: center; margin-bottom: 5%; margin-top: 5%;">
				<table class="table table-hover table-striped" class="group-form"
					style="margin-top: 3%; margin-bottom: 3%;">
					<tr style="width: 120px; text-align: center;">
						<td><b>cartQuantity</b></td>
						<td><input type="text" name="cartQuantity"
							placeholder="수량을 입력해주세요." class="form-control"></td>
					</tr>
				</table>
				<!-- 장바구니에 담을 수량 end-->
				<!-- addCart start -->
				<hr>
				<h2 style="margin-top: 5%;">
					<b style="color: #673ab7;">상품 <%=goodsNo%>번
					</b> 을 장바구니에 담겠습니까?
				</h2>
				<input type="hidden" name="customerId" value="<%=customerId%>">
				<input type="hidden" name="goodsNo" value="<%=goodsNo%>">
				<button type="submit" class="btn btn-success"
					style="float: center; margin-top: 2%;">네.</button>
				<a href="<%=request.getContextPath()%>/customer/cartList.jsp"
					style="margin-bottom: 7%;">
					<button type="button" class="btn btn-danger"
						style="float: center; margin-top: 2%;">아니오.</button>
				</a>
			</form>
		</div>
		<!-- addCart end -->
		<div
			style="float: right; margin-top: 5%; margin-left: 90%; margin-bottom: 6%;">
			<a
				href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">
				<button type="submit" class="btn" style="background-color:black; color:white;">GoodsList</button>
			</a>
		</div>
	</div>
</div>
<!-- end main -->
<!-- footer -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>