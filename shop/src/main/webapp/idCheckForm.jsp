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
	<section class="product spad">
		<div class="container">
			<!-- Product Section Begin -->
			<div class="row">
					<!-- id ck form -->
					<form action="<%=request.getContextPath()%>/idCheckAction.jsp"
						method="post" id="idCkCustomerForm">
						<label for="idck">ID 체크</label> 
						<input type="text" name="idck" id="idck">
						<button type="button" id="idCkCustomerBtn">Id 중복검사</button>
					</form>
			</div>
		</div>
	</section>
	<!-- 회원가입 폼 -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-2"></div>
				<div class="col-lg-8">
					<h2>회원가입</h2>
					<form class="form-group" id="addCustomerForm" method="post"
						action="<%=request.getContextPath()%>/customer/signUpCustomerAction.jsp">
						<div class="form-group">
							<label for="customerId">CUSTOMER ID:</label> 
							<!-- 아이디 입력은 직접 입력하지 못하기 readonly --> 
							<input type="text" name="customerId" id="customerId" readonly="readonly" class="form-control">
						</div>
						<div class="form-group">
							<label for="customer_pass">CUSTOMER PASSWORD:</label> 
							<input type="password" class="form-control" id="customer_pass" placeholder="Please enter Your Password" name="customer_pass">
						</div>
						<div class="form-group">
							<label for="customer_name">CUSTOMER NAME:</label> <input
								type="text" class="form-control" id="customer_name"
								name="customer_name" placeholder="Please enter Your Name">
						</div>
						<div class="form-group">
							<label for="customer_address">CUSTOMER ADDRESS:</label> <input
								type="text" class="form-control" id="usr"
								name="customer_address" placeholder="Please enter Your Address">
						</div>
						<div class="form-group">
							<label for="customer_telephone">CUSTOMER TELEPHONE:</label> <input
								type="text" class="form-control" id="customer_telephone"
								name="customer_telephone" placeholder="Please enter Your Telephone Number">
						</div>
						<button type="button" class="btn btn-dark" id = "addBtn" style="float: right;">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</section>
</body>
<%@ include file="/inc/footer.jsp"%>
<script>
$('#idCkCustomerBtn').click(function() {
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
					$('#customerId').val($('#idck').val());
				} else {
					alert('이미 사용중인 아이디 입니다.');
					$('#customerId').val('');
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
	if($('#customer_id').val() == ''){
		alert('아이디를 입력하세요.');
	}else if ($('#customer_pass').val() == '') {
		alert('비밀번호를 입력하세요.');
	}else if($('#customer_name').val() == ''){
		alert('이름을 입력하세요.');
	}else if ($('#customer_address').val() == '') {
		alert('주소를 입력하세요.');
	}else if($('#customer_telephone').val() == ''){
		alert('전화번호를 입력하세요.');
	}else {
		$('#addCustomerForm').submit();
	}
});
</script>
</html>