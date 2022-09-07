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
	System.out.println("\n----------------------------------updateReviewForm - start ----------------------------------------\n");
	
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
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String customerId = ( (String)session.getAttribute("id") );
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("orderNo : " + orderNo);
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
	List<Map<String, Object>> list = ReviewService.getReviewListByIdGoods(goodsNo,customerId);
	// 디버깅
	System.out.println(list);
	if (list != null) {
		System.out.println("리뷰보기 성공");
	}
	
	// 디버깅
	System.out.println("\n---------------------------------------updateReviewForm - end --------------------------------------------\n");
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
		<div
			style="float: right; margin-top: 5%; margin-left: 75%; margin-bottom: 6%;">
			<a href="#">
				<button type="button" class="btn btn-warning" style="color: white">AddCart</button>
			</a> <a href="#">
				<button type="button" class="btn btn-success"
					style="background-color: darkorange; border-color: darkorange">GoodsOrder</button>
			</a> <a
				href="#p">
				<button type="button" class="btn btn-success">GoodsList</button>
			</a>
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
			<form action="<%=request.getContextPath()%>/customer/updateReviewAction.jsp?orderNo=<%=orderNo%>" method="post">
				<table class="table table-hover table-striped"
					style="text-align: center;">
					<tr>
						<th><b>orderNo</b></th>
						<th><b>reviewContent</b></th>
						<th><b>createDate </b></th>
						<th><b>updateDate </b></th>
						<th></th>
					</tr>
					<%
					for (Map<String, Object> m : list) {
					%>
					<tr>
						<td><%=m.get("orderNo")%></td>
						<td>
							<input type="text" name="reviewContent" value="<%=m.get("reviewContent")%>">
						</td>
						<td><%=m.get("createDate")%></td>
						<td><%=m.get("updateDate")%></td>
						<td>
							<button type="submit" class="btn btn-warning">Modify</button>
							<button type="button" class="btn btn-danger">Delete</button>
						</td>
					</tr>
					<%
					}
					%>
				</table>
				</form>
			</div>
		</div>
		<br> <br>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>