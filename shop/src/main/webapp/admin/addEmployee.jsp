<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
	// 요청값 처리
	String idck = request.getParameter("idck");
	// 디버깅
	System.out.println("Id : " + idck);
%>
<body>
	<!-- 회원가입 폼 -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-2"></div>
				<div class="col-lg-8">
					<h2>Sign Up</h2>
					<hr>
					<!-- id ck form -->
					<div>
						<label for="idck"  class="mr-sm-2">ID Duplicate</label> 
						<input type="text" name="idck" id="idck"  class="form-control mb-2 mr-sm-2" placeholder="Please enter Your Id"><br>
						<button type="button" id="idCkEmployeeBtn"  class="btn btn-outline-secondary" style="float: right;">check</button><br>
					</div>
					<form class="form-group" id="addEmployeeForm" method="post"
						action="<%=request.getContextPath()%>/admin/signUpEmployeeAction.jsp">
						<div class="form-group">
							<label for="employeeId" style="float: left" >EMPLOYEE ID</label> 
							<!-- 아이디 입력은 직접 입력하지 못하기 readonly --> 
							<input type="text" name="employeeId" id="employeeId" readonly="readonly" class="form-control">
						</div>
						<div class="form-group">
							<label for="employee_pass" style="float: left">EMPLOYEE PASSWORD</label> 
							<input type="password" class="form-control" id="employee_pass" placeholder="Please enter Your Password" name="employee_pass">
						</div>
						<div class="form-group">
							<label for="employee_name" style="float: left">EMPLOYEE NAME</label> 
							<input type="text" class="form-control" id="employee_name"
								name="employee_name" placeholder="Please enter Your Name">
						</div>
						<button type="button" class="btn btn-outline-secondary" id = "addBtn" style="float: right;">join</button>
						<br><br>
					</form>
				</div>
			</div>
		</div>
	</section>
</body>
<%@ include file="/inc/footer.jsp"%>
<script>
$('#idCkEmployeeBtn').click(function() {
	if ($('#idck').val().length < 4) {
		alert('id는 4자이상!');
	} else {
		// 비동기 호출	
		$.ajax({
			url : '/shop/idckController',
			type : 'post',
			data : {
				idck : $('#idck').val()
			},
			success : function(json) {
				// alert(json);
				if (json == 'yes') {
					$('#employeeId').val($('#idck').val());
				} else {
					alert('이미 사용중인 아이디 입니다.');
					$('#employeeId').val('');
				}
			},
			//요청실패시 실행될 콜백함수
			error : function(err) {
				alert('요청 실패');
				console.log(err);
			}
		});
	}
});

$('#addBtn').click(function() {
	if ($('#employee_pass').val() == '') {
		alert('비밀번호를 입력하세요.');
	}else if($('#employee_name').val() == ''){
		alert('이름을 입력하세요.');
	}else {
		$('#addEmployeeForm').submit();
	}
});
</script>
</html>