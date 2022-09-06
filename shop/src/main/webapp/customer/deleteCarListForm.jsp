<%@page import="service.Cartservice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	// 디버깅
	System.out.println("\n-------------------------------deleteCartListForm start--------------------------------");

	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	// 로그인 전이거나 customer가 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String customerId = ( (String)session.getAttribute("id") );
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("deleteReviewForm - customerId : " + customerId);
	System.out.println("deleteReviewForm - goodsNo : " + goodsNo);
	
	// 디버깅
	System.out.println("\n-------------------------------deleteCartListForm end---------------------------------------");
%>    
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Delete Cart</b>
			</h2>
			<hr>
			<br> <br>
			<form action="<%=request.getContextPath()%>/customer/deleteCartListAction.jsp" method="post" style="text-align: center; margin-bottom:5%;">
				<fieldset >
					<h2 style="margin-bottom:3%;"><b style="color:#673ab7;">상품 <%=goodsNo%>번</b> 을 장바구니에서 삭제하시겠습니까?</h2>
					<input type="hidden" name="customerId" value="<%=customerId%>">
					<input type="hidden" name="goodsNo" value="<%=goodsNo%>">
					<button type="submit" class="btn btn-outline-danger" style="float: center;">네.</button>
					<a href="<%=request.getContextPath()%>/customer/cartList.jsp">
						<button type="button" class="btn btn-outline-dark" style="float: center;">아니오.</button>
					</a> 
					<br><br><br>			
				</fieldset>
			</form>
		</div>
		<br>
	</div>
		<br> <br> 
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>