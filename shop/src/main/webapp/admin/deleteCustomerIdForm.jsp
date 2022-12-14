<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println(
		"\n------------------------------------ deleteCustomerIdForm - start ------------------------------------------------\n");
//admin이 아닐 경우 접속 불가
if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// active가 Y이 아니면 접속 불가
if (!session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// 디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));
System.out.println("active : " + session.getAttribute("active"));

// 고객 아이디 받아오기
String customerId = request.getParameter("customerId");
// 디버깅
System.out.println("customerId : " + customerId);

//디버깅
System.out.println(
		"\n------------------------------------ deleteCustomerIdForm - end ------------------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<body>
	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12"
					style="height: 400px; background-color: #ced4da; text-align: center;">
					<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
						<b>Delete Customer Account</b>
					</h2>
					<form class="form-group" id="deleteCustomerForm" method="post"
						action="<%=request.getContextPath()%>/admin/deleteCustomerIdAction.jsp?customerId=<%=customerId%>">
						<input type="hidden" name="customerId" id="customerId"
							value="<%=session.getAttribute("id")%>">
						<hr>
						<br>
						<br>
						<br>
						<br>
						<fieldset style="text-align: center; margin-bottom: 3%;">
							<h2 style="margin-bottom: 3%;">
								<b style="color: #673ab7;"><%=customerId%></b> 고객을 강제 탈퇴하시겠습니까?
							</h2>
							<button type="submit" class="btn btn-outline-danger"
								style="float: center;">네.</button>
							<a
								href="<%=request.getContextPath()%>/admin/customerMemberList.jsp">
								<button type="button" class="btn btn-outline-dark"
									style="float: center;">아니오.</button>
							</a> <br>
							<br>
							<br>
						</fieldset>
						<button type="submit" class="btn btn-success"
							style="float: right;">DeleteCustomer</button>
					</form>
				</div>
				<div class="col-lg-2"></div>
			</div>
		</div>
	</section>
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>