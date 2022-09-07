<%@page import="vo.GoodsImg"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 디버깅
	System.out.println("\n-------------------------------updateAdminGoodsOne start-------------------------------------------\n");


	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}
	// active가 Y이 아니면 접속 불가
	if(! session.getAttribute("active").equals("Y")){
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println("active : " + session.getAttribute("active"));
	
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 요청값 처리
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	
	// 보여질 값 메서드 호출 
	GoodsService goodsService = new GoodsService();
	GoodsImg goodsImg = new GoodsImg();
	
	Map<String, Object> map = new HashMap<>();
	map = goodsService.selectGoodsAndImgOne(goodsNo);
	
	// 디버깅
	System.out.println("\n-------------------------------updateAdminGoodsOne end-------------------------------------------\n");
		
%>
<%@ include file="/inc/header.jsp"%>

<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-2"></div>
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>GOODS UPDATE</b></h2>
			<form action="<%=request.getContextPath()%>/admin/updateGoodsAction.jsp" id="addGoodsForm" method="post" enctype="multipart/form-data" class="form-group">
				<hr>
				<br>
				<br>
				<table class="table table-hover table-striped" >
					<tr>
						<td><label for="goodsNo"><b>GoodsNo</b></label></td>
						<td><input type="text" name="goodsNo" id="goodsNo" class="form-control" value="<%=goodsNo%>" readonly></td>
					</tr>
					<tr>
						<input type="hidden" name="originFilename" value="<%=map.get("goodsName")%>">
						<td><label for="imgFile"><b>ImgFile</b></label></td>
						<td><input type="file" name="imgFile" id="imgFile" class="form-control"></td>
					</tr>
					<tr>
						<td><label for="goodsName"><b>GoodsName</b></label></td>
						<td><input type="text" name="goodsName" id="goodsName" class="form-control" placeholder="<%=map.get("goodsName")%>" ></td>
					</tr>
					<tr>
						<td><label for="goodsPrice"><b>GoodsPrice</b></label></td>
						<td><input type="text" name="goodsPrice" id="goodsPrice" class="form-control" placeholder="<%=map.get("goodsPrice")%>"></td>
					</tr>
					<tr>
						<td><label for="soldOut"><b>SoldOut</b></label></td>
						<td><input type="text" name="soldOut" id="soldOut" class="form-control" placeholder="<%=map.get("soldOut")%>"></td>
					</tr>

				</table>
				<br>
				<br>
				<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-right: 3%; margin-bottom:5%;">Modify</button>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>

</body>
</html>