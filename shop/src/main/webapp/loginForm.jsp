<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<div class="half" style="margin-bottom: 6%; margin-top: 6%;">
	<div class="contents order-2 order-md-1">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-md-10"
					style="height: 400px; background-color: #ced4da;">
					<div class="form-block">
						<div class="text-center mb-5">
							<h2 style="margin-top: 10%; font-size: 50px;">
								<b>Welcome To NNIKE</b>
							</h2>
							<div style="margin-top: 8%; font-size: 33px;">
								<a
									href="<%=request.getContextPath()%>/admin/employeeLoginForm.jsp"
									style="margin-right: 5%; color: white;"> <b
									style="color: grey">﻿▶ </b><b>Employee Login</b>
								</a> 
								<a
									href="<%=request.getContextPath()%>/customer/customerLoginForm.jsp"
									style="color: white;"> <b style="color: grey">﻿▶ </b><b>Customer
										Login</b>
								</a>

							</div>
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
	$('#cutomerLoginBtn').click(function() {
		if ($('#customerId').val().length < 1) {
			alert('아이디를 입력하세요.');
		} else if ($('#customerPass').val().length < 1) {
			alert('비밀번호를 입력하세요.');
		} else {
			$('#customerLoginForm').submit();
		}
	});
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