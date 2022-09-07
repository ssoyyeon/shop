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
System.out.println("\n--------------------------------cutomerGoodsOne start----------------------------------------------\n");

//customer가 아닐 경우 접속 불가
if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
// 디버깅
System.out.println("goodsNo : " + goodsNo);

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
//디버깅
if (list != null) {
	System.out.println("리뷰보기 성공");
}
System.out.println("\n-------------------------------cutomerGoodsOne end--------------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 6%; background-color: #E9EDF1; text-align: center;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>GOODS DETAIL</b>
			</h2>
			<hr>
			<br> <br>
			<form action="<%=request.getContextPath()%>/noticeList.jsp"
				method="post">
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
			</form>
		</div>
		<div class="col-lg-12">
			<div
				style="float: right; margin-top: 5%; margin-left: 75%%; margin-bottom: 6%;">
				<a href="<%=request.getContextPath()%>/customer/customerAddCart.jsp">
					<button type="submit" class="btn btn-warning" style="color: white">AddCart</button>
				</a> <a
					href="<%=request.getContextPath()%>/customer/GoodsOrderForm.jsp">
					<button type="submit" class="btn btn-warning"
						style="color: white; background-color: darkorange; border-color: darkorange;">GoodsOrder</button>
				</a> <a
					href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">
					<button type="submit" class="btn btn-success">GoodsList</button>
				</a>
			</div>
		</div>
		<br> <br>
		<!-- review -->
		<div class="col-lg-12"
			style="margin-top: 3%; background-color: #E9EDF1;">
			<h3 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>REVIEW</b>
			</h3>
			<hr>
			<br> <br>
			<div>
				<table class="table table-hover table-striped">
					<tr>
						<th><b>reviewNo</b></th>
						<th><b>reviewContent</b></th>
						<th><b>createDate </b></th>
						<th><b>customerId </b></th>
					</tr>
					<%
					for (Map<String, Object> m : list) {
					%>
					<tr>
						<td><%=m.get("orderNo")%></td>
						<td><%=m.get("reviewContent")%></td>
						<td><%=m.get("createDate")%></td>
						<td><%=m.get("customerId")%></td>
					</tr>
					<%
					}
					%>
				</table>
			</div>
		</div>
		<br> <br>
	</div>
	<div style="float: right; margin-top: 5%; margin-left: 75%%;">
		<a
			href="<%=request.getContextPath()%>/customer/addGoodsReview.jsp?goodsNo=<%=goodsNo%>">
			<button type="submit" class="btn btn-warning" style="color: white">AddReview</button>
		</a> <a href="<%=request.getContextPath()%>/customer/updateReviewForm.jsp">
			<button type="submit" class="btn btn-success"
				style="background-color: darkorange; border-color: darkorange;">ModifyReview</button>
		</a> <a href="<%=request.getContextPath()%>/customer/deleteReviewForm.jsp">
			<button type="submit" class="btn btn-success">DeleteReview</button>
		</a>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>