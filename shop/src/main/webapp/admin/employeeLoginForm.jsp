<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<div class="half" style="margin-bottom: 10%; margin-top: 10%;">
	<div class="contents order-2 order-md-1">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-md-2"></div>
				<div class="col-md-10"
					style="height: 500px; background-color: #ced4da;">
					<div class="form-block">
						<div class="text-center mb-5">
							<h2 style="margin-top: 8%; font-size:35px;">
								<b>EMPLOYEE</b>
							</h2>
							<form class="form-group" id="employeeLoginForm" method="post"
								action="<%=request.getContextPath()%>/admin/employeeLoginAction.jsp" style="margin-top:5%;">
								<div class="form-group">
									<label for="customerId" style="float: left;">ID</label> <input
										type="text" name="employeeId" id="employeeId"
										class="form-control" placeholder="Please enter Your Id">
								</div>
								<div class="form-group">
									<label for="customer_pass" style="float: left;">PASSWORD</label>
									<input type="password" name="employeePass" id="employeePass"
										placeholder="Please enter Your Password" class="form-control">
								</div>
								<div>
									<br> <a
										href="<%=request.getContextPath()%>/admin/addEmployee.jsp">
										<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-top:5%;">Sign-up</button>
									</a>
									<button type="button" class="btn" 
										id="employeeLoginBtn" class="btn" style=" color: white; background-color: black; float: right; margin-top:5%;" >login</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
<script>
$('#employeeLoginBtn').click(function() {
		if ($('#employeeId').val().length < 1) {
			alert('아이디를 입력하세요.');
		} else if ($('#employeePass').val().length < 1) {
			alert('비밀번호를 입력하세요.');
		} else {
			$('#employeeLoginForm').submit();
		}
	});
</script>	
</html>