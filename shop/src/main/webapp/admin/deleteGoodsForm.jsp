<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//디버깅
	System.out.println("\n------------------------------------ deleteGoodsForm - start ------------------------------------------------\n");

	// admin이 아닐 경우 접속 불가
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

	//디버깅
	System.out.println("\n------------------------------------ deleteGoodsForm -  end------------------------------------------------\n");
%>    
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-2"></div>
		<!-- 메인페이지 -->
		<div class="col-lg-8"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>GOODS DELETE</b>
			</h2>
			<hr>
			<br> <br>
			<form action="<%=request.getContextPath()%>/admin/deleteGoodsAction.jsp?goodsNo=<%=goodsNo%>" method="post" style="text-align: center; margin-bottom:5%;">
				<fieldset >
					<h2 style="margin-bottom:3%;"><b style="color:#673ab7;"><%=goodsNo %>번</b> 상품을 삭제하시겠습니까?</h2>
					<button type="submit" class="btn btn-outline-danger" style="float: center;">네.</button>
					<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">
					<button type="button" class="btn btn-outline-dark" style=" color:black; float: center;">아니오.</button>
					</a> 
					<br><br><br>			
				</fieldset>
			</form>
			
		</div>
		<div class="col-lg-2"></div>
		<br>
	</div>
		<br> <br> 
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>