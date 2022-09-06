<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// customer가 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 변수 가져오기
	String customerId = ((String) session.getAttribute("id"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 디버깅
	System.out.println("customerId : " + customerId);
	System.out.println("deleteCustomerAction - goodsNo : " + goodsNo);

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
				action="<%=request.getContextPath()%>/customer/deleteCustomerAction.jsp?customerId=<%=customerId%>"
				id="deleteCustomerForm" method="post" class="form-group">
				<hr>
				<br> <br>
				<fieldset>
					<div>
						<label for="customerId"><b>customerId</b></label> <input
							type="text" name="customerId" value="<%=customerId%>"
							class="form-control" readonly>
					</div>
					<div>
						<label for="customerPass"><b>Password</b></label> <input
							type="password" name="customerPass" id="customerPass"
							class="form-control" placeholder="Please enter Your Password">
					</div>
					<div>
						<label for="ConfirmPassword"><b>Confirm password</b></label> <input
							type="password" name="ConfirmPassword" id="ConfirmPassword"
							class="form-control" placeholder="Please enter Your Password">
							<input type="hidden" name="goodsNo" id="goodsNo" value="goodsNo">
					</div>
				</fieldset>
				<br> <br>
				<button type="button" class="btn btn-danger" id="deleteBtn"
					style="float: right; margin-right: 3%; margin-bottom: 5%;">Delete</button>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
<script>
	$('#deleteBtn').click(function() {
		if ($('#customerPass').val() == '') {
			alert('비밀번호를 입력하세요.');
		} else if ($('#ConfirmPassword').val() == '') {
			alert('확인 비밀번호를 입력하세요.');
		} else if ($('#ConfirmPassword').val() != $('#customerPass').val()) {
			alert('비밀번호가 일치하지 않습니다. 다시 입력하세요.');
			$('#ConfirmPassword').focus();
		} else {
			$('#deleteCustomerForm').submit();
		}
	});
</script>
</html>