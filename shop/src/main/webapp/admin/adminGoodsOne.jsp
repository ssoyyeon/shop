<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.GoodsImg"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//로그인 전이거나 스텝이 아니면 로그인 페이지로 돌아가기
	if (session.getAttribute("id") == null || session.getAttribute("user").equals("Customer")) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	System.out.println("\nadminGoodsOne");
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	
	// 상품 상세보기 메서드 호출 
	GoodsService goodsService = new GoodsService();
	GoodsImg goodsImg = new GoodsImg();
	
	Map<String, Object> map = new HashMap<>();
	map = goodsService.selectGoodsAndImgOne(goodsNo);
	
	if (map != null) {
		System.out.println("상품 상세보기 성공");
	}
	
	//리뷰 메서드 호출
	ReviewService ReviewService = new ReviewService();
	List<Map<String, Object>> list = ReviewService.getReviewListByGoods(goodsNo);
	//디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("list : " + list);
	if (list != null) {
		System.out.println("리뷰보기 성공");
	}
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Goods Detail</b>
			</h2>
			<hr>
			<br> <br>
			<table class="table table-hover table-striped">
				<thead>
					<tr style="width: 120px; text-align: center;">
						<th><b>goodseNo</b></th>
						<th><b>ImgFile</b></th>
						<th><b>goodsName</b></th>
						<th><b>goodsPrice</b></th>
						<th><b>soldOut</b></th>
						<th><b>createDate</b></th>
					</tr>
				</thead>
				<tbody>
					<tr style="text-align: center;">
						<td><%=goodsNo%></td>
						<td><img alt="이미지 파일"
							src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>"
							width=200; height=200; style="background-color: white;"></td>
						<td><%=map.get("goodsName")%></td>
						<td><%=map.get("goodsPrice")%></td>
						<td><%=map.get("soldOut")%></td>
						<td><%=map.get("createDate")%></td>
					</tr>
				</tbody>
			</table>
			<br> <br> 
			
		</div>
					<div style="float: right; margin-bottom: 3%; margin-top: 3%; margin-left: 73%;">
			<a
				href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">
				<button type="submit" class="btn" style=" color: white; background-color: black;">GoodsList</button>
			</a>
			<%
			// 상품 수정, 삭제 조건
			if (!(session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")
					|| !session.getAttribute("active").equals("Y"))) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/updateOrdersForm.jsp?goodsNo=<%=goodsNo%>
				&goodsPrice=<%=map.get("goodsPrice")%>&soldOut=<%=map.get("soldOut")%>&filename=<%=map.get("filename")%>&goodsName=<%=map.get("goodsName")%>">
				<button type="submit" class="btn" style=" color: white; background-color: black;" style=" color:white;">ModifyGoods</button>
			</a> <a
				href="<%=request.getContextPath()%>/admin/deleteGoodsForm.jsp?goodsNo=<%=goodsNo%>">
				<button type="submit" class="btn" style=" color: white; background-color: black;">DeleteGoods</button>
			</a>
			<%
			}
			%>
			</div>
		<!-- goods datail -->
		<!-- review -->
		<!-- review -->
		<div class="col-lg-12"
			style="margin-top: 5%; background-color: #E9EDF1;">
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
						<td><a
							href="<%=request.getContextPath()%>/admin/customerOrderOne.jsp?customerId=<%=m.get("customerId")%>"><%=m.get("customerId")%></a></td>
					</tr>
					<%
					}
					%>
				</table>
			</div>
		</div>
		<%
		// 리뷰 삭제 조건
		if (!(session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")
				|| !session.getAttribute("active").equals("Y"))) {
		%>
		<a
			href="<%=request.getContextPath()%>/customer/deleteGoodsReviewForm.jsp"
			style="margin-left: 90%; margin-top: 5%;">
			<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-top: 10%;">Delete Review</button>
		</a>
		<%
		}
		%>
		<!--  review end -->
	</div>

</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>