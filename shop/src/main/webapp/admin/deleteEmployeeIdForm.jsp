<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="vo.Customer"%>
<%
//디버깅
System.out.println("\n\n----------------------------------deleteEmployeeForm- start ---------------------------------\n");

//admin이 아닐 경우 접속 불가
if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
//active가 Y이 아니면 접속 불가
if (!session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));
System.out.println("active : " + session.getAttribute("active"));

//인코딩
request.setCharacterEncoding("utf-8");

// 요청값 받아오기
String employeeId = request.getParameter("employeeId");
//디버깅
System.out.println("employeeId : " + employeeId);

//디버깅
System.out.println("\n\n----------------------------------deleteEmployeeForm- start ---------------------------------\n");

%>
<%@ include file="/inc/header.jsp"%>
<body>
	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-2"></div>
				<!-- 메인페이지 -->
				<div class="col-lg-8"
					style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">
					<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
						<b>Delete Account</b>
					</h2>
					<form id="deleteEmployeeForm" method="post"
						action="<%=request.getContextPath()%>/admin/deleteEmployeeAction.jsp" style="text-align: center; margin-top:5%;">
						<fieldset>
							<input type="hidden" name="employeeId" id="employeeId"
								value="<%=employeeId%>">
							<h2 style="margin-bottom: 3%;">
								<b style="color: #673ab7;"><%=employeeId%></b>매니저를
								삭제하시겠습니까?
							</h2>
							<button type="submit" class="btn btn-outline-danger"
								style="float: center;">네.</button>
							<a
								href="<%=request.getContextPath()%>/admin/employeeMemberList.jsp">
								<button type="submit" class="btn btn-outline-success" style="float: center;">아니오.</button>
							</a> <br> <br> <br>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>
