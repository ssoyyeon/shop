<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------deleteEmployeeForm - startS ------------------------------------------\n");
	// EmployeeId가 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Employee"))) {
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 변수 가져오기
	String employeeId = ((String) session.getAttribute("id"));
	// 디버깅
	System.out.println("employeeId : " + employeeId);

	// 디버깅
	System.out.println("\n----------------------------------deleteEmployeeForm - end ---------------------------------------\n");
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
				<b>DELETE MY ACCOUNT</b>
			</h2>
			<form
				action="<%=request.getContextPath()%>/admin/deleteEmployeeAction.jsp"
				id="deleteEmployeeForm" method="post" class="form-group">
				<hr>
				<br> <br>
				<fieldset>
					<div>
						<label for="employeeId"><b>EmployeeId</b></label> <input
							type="text" name="employeeId" value="<%=employeeId%>"
							class="form-control" readonly>
					</div>
					<div>
						<label for="employeePass"><b>Password</b></label> <input
							type="password" name="employeePass" id="employeePass"
							class="form-control" placeholder="Please enter Your Password">
					</div>
					<div>
						<label for="ConfirmPassword"><b>Confirm password</b></label> <input
							type="password" name="ConfirmPassword" id="ConfirmPassword"
							class="form-control" placeholder="Please enter Your Password">
					</div>
				</fieldset>
				<br> <br>
				<button type="button" class="btn" id="deleteBtn"
					style="float: right; margin-right: 3%; margin-bottom: 5%; background-color:black; color:white; ">Delete</button>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
<script>
	$('#deleteBtn').click(function() {
		if ($('#employeePass').val() == '') {
			alert('비밀번호를 입력하세요.');
		} else if ($('#ConfirmPassword').val() == '') {
			alert('확인 비밀번호를 입력하세요.');
		} else if ($('#ConfirmPassword').val() != $('#employeePass').val()) {
			alert('비밀번호가 일치하지 않습니다. 다시 입력하세요.');
			$('#ConfirmPassword').focus();
		} else {
			$('#deleteEmployeeForm').submit();
		}
	});
</script>
</html>