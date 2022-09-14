<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="repository.GoodsDao"%>
<%@page import="java.util.Map"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 디버깅
System.out
		.println("\n----------------------------------cutomerGoodsOne - start ------------------------------------\n");

// 로그인 전이면 로그인 페이지로 재요청
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// 디버깅
System.out.println("id : " + session.getAttribute("id"));

// 인코딩
request.setCharacterEncoding("utf-8");

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

// 리뷰 메서드 호출
ReviewService ReviewService = new ReviewService();
List<Map<String, Object>> list = ReviewService.getReviewListByGoods(goodsNo);
// 디버깅
System.out.println(list);
if (list != null) {
	System.out.println("리뷰보기 성공");
}

// 디버깅
System.out
		.println("\n----------------------------------cutomerGoodsOne - end ---------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row"
		style="margin-top: 6%; background-color: #E9EDF1; text-align: center;">
		<!-- goodsOne start -->
		<!-- 상품 이미지 -->
		<div class="col-lg-5 mt-5" style="">
			<img class="card-img img-fluid"
				src="<%=request.getContextPath()%>/upload/<%=selectGoods.get("filename")%>"
				alt="goods image">
		</div>
		<div class="col-lg-7">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Goods Detail</b>
			</h2>
			<hr>
			<br> <br>
			<table class="table table-hover table-striped">
				<tr style="width: 120px; text-align: center;">
					<th><b>goodseNo</b></th>
					<td><%=goodsNo%></td>
				</tr>
				<tr>
					<th><b>goodsName</b></th>
					<td><%=selectGoods.get("goodsName")%></td>
				</tr>
				<tr>
					<th><b>goodsPrice</b></th>
					<td><%=selectGoods.get("goodsPrice")%></td>
				</tr>
				<tr>
					<th><b>soldOut</b></th>
					<td><%=selectGoods.get("soldOut")%></td>
				</tr>
				<tr>
					<th><b>createDate</b></th>
					<td><%=selectGoods.get("createDate")%></td>
				</tr>
			</table>
		</div>
		<div
			style="float: right; margin-top: 5%; margin-left: 75%; margin-bottom: 6%;">
			<a
				href="<%=request.getContextPath()%>/customer/addCartList.jsp?goodsNo=<%=goodsNo%>">
				<button type="submit" class="btn btn"
					style="color: white; background-color: black;">AddCart</button>
			</a> <a
				href="<%=request.getContextPath()%>/customer/addCustomerOrders.jsp?goodsNo=<%=goodsNo%>">
				<button type="submit" class="btn btn"
					style="color: white; background-color: black;">GoodsOrder</button>
			</a> <a
				href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">
				<button type="submit" class="btn btn"
					style="color: white; background-color: black;">GoodsList</button>
			</a>
		</div>
		<br> <br>
	</div>
</div>
<!-- goodsOne end -->
<!-- review start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12"
			style="margin-top: 5%; background-color: #E9EDF1;">
			<h3 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Review</b>
			</h3>
			<hr>
			<br> <br>
			<div>
				<%
				// 리뷰가 없는 경우
				if (session.getAttribute("id") == null || list.isEmpty()) {
					System.out.println("list : " + list);
				%>
				<div class="col-lg-12"
					style="margin-top: 3%; background-color: #E9EDF1; text-align: center;">
					<p style="font-size: 25px; margin-top: 5%; height: 70px;">
						<b>리뷰가 없습니다.</b>
					</p>
					<a href="<%=request.getContextPath()%>/main.jsp"><button
							type="button" class="btn btn-dark" style="margin-bottom:10%;">홈으로 가기</button></a>
				</div>

				<%
				} else {
				%>
				<table class="table table-hover table-striped"
					style="text-align: center;">
					<thead>
						<tr>
							<th><b>orderNo</b></th>
							<th><b>reviewContent</b></th>
							<th><b>createDate </b></th>
							<th><b>updateDate </b></th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Map<String, Object> m : list) {
						%>
						<tr>
							<td><%=m.get("orderNo")%></td>
							<td><%=m.get("reviewContent")%></td>
							<td><%=m.get("createDate")%></td>
							<td><%=m.get("updateDate")%></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!-- review end -->
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>