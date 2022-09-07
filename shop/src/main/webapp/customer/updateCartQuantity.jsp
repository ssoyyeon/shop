<%@page import="vo.Cart"%>
<%@page import="service.GoodsService"%>
<%@page import="service.Cartservice"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println("\n--------------------------------------updateCartQuantity- start -----------------------------------------\n");

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

// 뱐수 가져오기
String customerId = ((String) session.getAttribute("id"));
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
// 디버깅
System.out.println("updateCartQuantity - customerId : " + customerId);
System.out.println("updateCartQuantity - goodsNo : " + goodsNo);

//상품 상세보기 메서드 호출할 객체 생성
GoodsService goodsService = new GoodsService();

//상품 상세보기 메서드 호출
Map<String, Object> selectGoods = goodsService.selectGoodsAndImgOne(goodsNo);
//디버깅
if (selectGoods != null) {
	System.out.println("updateCartQuantity - 상세보기 성공");
}

//매개변수 값을 넣어줄 객체 생성
Cart paracart = new Cart();
//매개변수 값 넣기
paracart.setGoodsNo(goodsNo);
paracart.setCustomerId(customerId);

//메서드 호출을 위한 객체 생성
Cartservice cartService = new Cartservice();

//장바구니 상품1 상세보기 호출할 객체 생성
Cart cartList = new Cart();
//장바구니 상품1 상세보기 호출
cartList = cartService.selectCartOne(paracart);
//디버깅
System.out.println("updateCartQuantity - cartList : " + cartList);

//디버깅
if (cartList != null) {
	System.out.println("updateCartQuantity 출력 성공!");
}

//디버깅
System.out.println("\n----------------------------------updateCartQuantity- end -----------------------------------------\n");
%>
<!-- header -->
<%@ include file="/inc/header.jsp"%>
<body>
	<div class="container">
		<div class="row">
			<!-- 메인페이지 -->
			<div class="col-lg-12"
				style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">
				<h2 style="font-size: 40px; margin-top: 5%;">
					<b>Modify CartList</b>
				</h2>
				<table class="table table-hover table-striped"
					style="margin-bottom: 5%; margin-top: 5%;">
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
				<hr>
				<form
					action="<%=request.getContextPath()%>/customer/updateCartQuantityAction.jsp"
					method="post">
					<table class="table table-striped"
						style="margin-bottom: 5%; margin-top: 5%">
						<tr>
							<td><b>goodsNo</b></td>
							<td>
								<input type="hidden" name="goodsNo" value="<%=goodsNo%>"><%=goodsNo%>
							</td>
							<td>
								<input type="hidden" name="customerId" value="<%=cartList.getCustomerId()%>"><%=cartList.getCustomerId()%>
							</td>
						</tr>
						<tr>
							<td><b>cartQuantity</b></td>
							<td><input type="text" name="cartQuantity"
								value="<%=cartList.getCartQuantity()%>"></td>
						</tr>
						<tr>
							<td><b>createDate</b></td>
							<td><%=cartList.getCreateDate()%></td>
						</tr>
						<tr>
							<td><b>updateDate</b></td>
							<td><%=cartList.getUpdateDate()%></td>
						</tr>
					</table>

					<div style="margin-top: 5%; margin-bottom: 5%; margin-left: 80%;">
						<button type="submit" class="btn btn-warning"
							style="color: white;">Modify</button>
						<a href="<%=request.getContextPath()%>/customer/cartList.jsp">
							<button type="button" class="btn btn-success"
								style="color: white;">CartList</button>
						</a>
					
					</div>
				</form>
			</div>
			<!-- col-12 end -->
		</div>
		<!--  end row -->
	</div>
	<!-- end container -->
	<!-- footer -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>