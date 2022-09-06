<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.Customer"%>
<%@ include file="/inc/header.jsp"%>
<body>
	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container" style="margin-bottom: 10%; margin-top: 10%;">
			<div class="row">
				<div class="col-lg-12" style="height: 400px; background-color: #ced4da;">
					<h2 style="font-size:40px; text-align:center; margin-top: 5%;"><b>Delete Account</b></h2>
					<form  id="deleteEmployeeForm" method="post" action="<%=request.getContextPath()%>/admin/deleteEmployeeAction.jsp">
						<div class="form-group">
							<input type="hidden" name="employeeId" id="employeeId"  value="<%=session.getAttribute("id")%>" class="form-group">
								<hr><br><br><br><br>
							<input type="password" class="form-control" name="employeePass" id="employeePass" placeholder="Enter password">
							<br><br><br><br><hr>
							<button type="button"class="btn" style=" color: white; background-color: black; float: right;" id="employeeBtn">Delete</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->
	<%@ include file="/inc/footer.jsp"%>
</body>
<script>
	$('#employeeBtn').click(function() {
		if ($('#employeePass').val() == '') {
			alert('비밀번호를 입력하세요.');
		} else {
			$('#deleteEmployeeForm').submit();
		}
	});
</script>
</html>
