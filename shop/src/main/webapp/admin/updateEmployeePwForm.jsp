<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//디버깅
	System.out.println("\n------------------------------------ updateEmployeePwForm - start ------------------------------------------------\n");

	// admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 변수 가져오기
	String employeeId = request.getParameter("employeeId");
	// 디버깅
	System.out.println("employeeId : " + employeeId);

	//디버깅
	System.out.println("\n------------------------------------ updateEmployeePwForm -  end------------------------------------------------\n");
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
				<b>PASSWORD UPDATE</b></h2>
			<form action="<%=request.getContextPath()%>/admin/updateEmployeePwAction.jsp" id="updateEemployeePwForm" method="post" class="form-group">
				<hr>
				<br>
				<br>
				<fieldset>
						<input type="hidden" name="employeeId" value="<%=employeeId %>">
						<label for="employeePass"><b>Password</b></label>
						<input type="password" name="employeePass" id="employeePass" class="form-control" placeholder="Please enter Your Password">
						<label for="confirmPassword"><b>Confirm password</b></label>
						<input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Please enter Your Password">
				
				</fieldset>
				<br>
				<br>
			</form>
		</div>
		<button type="button" id="modifyBtn" class="btn" style=" color: white; background-color: black; float: right; margin-left: 93%; margin-top:5%;">Modify</button>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
<script>
$('#modifyBtn').click(function() {
	if ($('#employeePass').val() == '') {
		alert('비밀번호를 입력하세요.');
		$('#employeePass').focus();
	}else if($('#confirmPassword').val() == ''){
		alert('확인 비밀번호를 입력하세요.');
		$('#confirmPassword').focus();
	}else if($('#confirmPassword').val() != $('#employeePass').val()){
		alert('비밀번호가 일치하지 않습니다. 다시 입력하세요.');
		$('#confirmPassword').focus();
	}else {
		$('#updateEemployeePwForm').submit();
	}
});
</script>
</html>