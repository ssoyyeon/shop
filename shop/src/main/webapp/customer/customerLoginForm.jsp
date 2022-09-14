<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<div class="half" style="margin-bottom: 10%; margin-top: 10%;">
	<div class="contents order-2 order-md-1">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-md-10"
					style="height: 500px; background-color: #ced4da;">
					<div class="form-block">
						<div class="text-center mb-5">
							<h2 style="margin-top: 8%; font-size: 35px;">
								<b>CUSTOMER</b>
							</h2>
							<form class="form-group" id="customerLoginForm" method="post"
								action="<%=request.getContextPath()%>/customer/customerLoginAction.jsp"
								style="margin-top: 5%;">
								<div class="form-group">
									<label for="customerId" style="float: left;">ID</label> <input
										type="text" name="customerId" id="customerId"
										class="form-control" placeholder="Please enter Your Id">
								</div>
								<div class="form-group">
									<label for="customerPass" style="float: left;">PASSWORD</label>
									<input type="password" class="form-control" id="customerPass"
										placeholder="Please enter Your Password" name="customerPass">
								</div>
								<div
									style="float: left; margin-left: 3%; margin-top: 3%; font-weight: bolder;">
									<p>
										고객 <br> Id: guest <br> Pw: 1234
									</p>
								</div>
								<br>
								<div>
									<a
										href="<%=request.getContextPath()%>/customer/addCustomer.jsp">
										<button type="submit" class="btn btn-secondary"
											style="float: right; margin-top: 5%;">Sign-up</button>
									</a>
									<button type="button" class="btn btn-dark" id="cutomerLoginBtn"
										style="float: right; margin-top: 5%;">login</button>
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
	$('#cutomerLoginBtn').click(function() {
		if ($('#customerId').val().length < 1) {
			alert('아이디를 입력하세요.');
		} else if ($('#customerPass').val().length < 1) {
			alert('비밀번호를 입력하세요.');
		} else {
			$('#customerLoginForm').submit();
		}
	});
</script>
</html>