<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	// active가 Y이 아니면 접속 불가
	if(! session.getAttribute("active").equals("Y")){
		response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println("active : " + session.getAttribute("active"));
%>
<%@ include file="/inc/header.jsp"%>
<body>
	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12" style="height: 400px; background-color: #ced4da;">
					<h2 style="font-size:40px; text-align:center; margin-top: 5%;"><b>DELETE CUSTOMER ACCOUNT</b></h2>
					<form class="form-group" id="deleteCustomerForm" method="post" action="<%=request.getContextPath()%>/admin/deleteCustomerIdAction.jsp">
						<input type="hidden" name="customerId" id="customerId" value="<%=session.getAttribute("id")%>"> 
						<hr><br><br><br><br>
					<fieldset >
					<h2 style="margin-bottom:3%;"><b style="color:#673ab7;"><%=session.getAttribute("id")%></b> 고객을 강제 탈퇴하시겠습니까?</h2>
					<button type="submit" class="btn btn-outline-danger" style="float: center;">네.</button>
						<a href="<%=request.getContextPath()%>/admin/customerMemberList.jsp">
					<button type="button" class="btn btn-outline-dark" style="float: center;">아니오.</button>
					</a> 
					<br><br><br>			
				</fieldset>
						<button type="submit" class="btn btn-success" style="float: right;">DeleteCustomer</button>
					</form>
				</div>
				<div class="col-lg-2"></div>
			</div>
		</div>
	</section>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>