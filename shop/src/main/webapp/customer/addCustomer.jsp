<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
	//디버깅
	System.out.println("\n----------------------------------addCustomer - end ---------------------------------\n");
	// 요청값 처리
	String idck = request.getParameter("idck");
	// 디버깅
	System.out.println(" addCustomer - Id : " + idck);
	// 디버깅
	System.out.println("\n----------------------------------addCustomer - end ---------------------------------\n");
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
					<div>
					<!-- id ck form -->
						<label for="idck"  class="mr-sm-2">ID Duplicate</label> 
						<input type="text" name="idck" id="idck"  class="form-control mb-2 mr-sm-2" placeholder="Please enter Your Id">
						<button type="button" id="idCkCustomerBtn"  class="btn btn-outline-secondary" style="float: right;">check</button><br>
					</div>	
						
					<form class="form-group" id="addCustomerForm" method="post"
						action="<%=request.getContextPath()%>/customer/signUpCustomerAction.jsp">
						<div class="form-group">
							<label for="customerId" style="float: left" >customerId</label> 
							<!-- 아이디 입력은 직접 입력하지 못하기 readonly --> 
							<input type="text" name="customerId" id="customerId" readonly="readonly" class="form-control">
						</div>
						<div class="form-group">
							<label for="customer_pass" style="float: left">CustomerPass</label> 
							<input type="password" class="form-control" id="customer_pass" placeholder="Please enter Your Password" name="customer_pass">
						</div>
						<div class="form-group">
							<label for="customer_name" style="float: left">CustomerName</label> <input
								type="text" class="form-control" id="customer_name"
								name="customer_name" placeholder="Please enter Your Name">
						</div>
						<div class="form-group">
							<label for="customer_address" style="float: left">CustomerAddress</label> 

							<input type="text" id="roadAddress" class="form-control" 
								name="customer_address" placeholder="Please enter Your Address">
								<span id="guide" style="color: #999; display: none"></span> 
						</div>
						<div class="form-group">
							<label for="detail_address" style="float: left">DetailAddress</label> 
							<input type="text" id="detailAddress" class="form-control" name="detail_address" placeholder="Please enter Your Address">
							<!-- 주소 검색 API -->
							<input type="button" onclick="execDaumPostcode()" value="Search Address" class="btn btn-outline-secondary"  style="float: right; margin-top:1%;  ">
						</div>
						<div class="form-group"  style="margin-top:5%;">
							<label for="customer_telephone" style="float: left">CustomerTelephone</label> <input
								type="text" class="form-control" id="customer_telephone"
								name="customer_telephone" placeholder="Please enter Your Telephone Number">
						</div>
						<button type="button" class="btn btn-outline-secondary"  id = "addBtn" style="float: right;">join</button>
						<br><br>
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
	if ($('#customer_pass').val() == '') {
		alert('비밀번호를 입력하세요.');
	}else if($('#customer_name').val() == ''){
		alert('이름을 입력하세요.');
	}else if ($('#customer_address').val() == '') {
		alert('주소를 입력하세요.');
	}else if ($('#detail_address').val() == '') {
		alert('상세주소를 입력하세요.');
	}else if($('#customer_telephone').val() == ''){
		alert('전화번호를 입력하세요.');
	}else {
		$('#addCustomerForm').submit();
	}
});
</script>
<script
src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById("roadAddress").value = roadAddr;

					// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
					if (roadAddr !== '') {
						document.getElementById("extraAddress").value = extraRoadAddr;
					} else {
						document.getElementById("extraAddress").value = '';
					}

					var guideTextBox = document.getElementById("guide");
					// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
					if (data.autoRoadAddress) {
						var expRoadAddr = data.autoRoadAddress
								+ extraRoadAddr;
						guideTextBox.innerHTML = '(예상 도로명 주소 : '
								+ expRoadAddr + ')';
						guideTextBox.style.display = 'block';

					} else {
						guideTextBox.innerHTML = '';
						guideTextBox.style.display = 'none';
					}
				}
			}).open();
}
</script>
</html>