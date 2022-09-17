<%@page import="service.CounterService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println(
		"\n-------------------------------------adminIndex - start ------------------------------------------------\n");
//admin이 아닐 경우 접속 불가
if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}

// 디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

//디버깅
System.out.println(
		"\n-------------------------------------adminIndex- end ------------------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>My Account</b>
			</h2>
			<br>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center; margin-bottom: 5%;">
				<tr>
					<th style="width: 40%;">employeeId</th>
					<td><%=session.getAttribute("id")%></td>
				</tr>
				<tr>
					<th style="width: 40%;">employeeName</th>
					<td><%=session.getAttribute("name")%></td>
				</tr>
				<tr>
					<th style="width: 40%;">User Position</th>
					<td><%=session.getAttribute("user")%></td>
				</tr>
			</table>
		</div>

		<div style="float: right; margin-top: 7%; margin-left:75%;">
			<%
			if (!session.getAttribute("active").equals("Y")) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/deleteEmployeeForm.jsp">
				<button class="btn btn" type="submit"
					style="color: white; background-color: black;">DeleteAccount</button>
			</a>
			<%
}
%>
			<a
				href="<%=request.getContextPath()%>/admin/updateEmployeePwForm.jsp?employeeId=<%=session.getAttribute("id")%>">
				<button class="btn btn" type="submit"
					style="color: white; background-color: black;">ModifyPassword</button>
			</a>
		</div>
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>