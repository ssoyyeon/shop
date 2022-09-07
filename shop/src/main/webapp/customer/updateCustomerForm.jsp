<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println("\n-------------------------------------updateCustomerForm - start ------------------------------------------------\n");
//customer가 아닐 경우 접속 불가
if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
String customerId = ((String) session.getAttribute("id"));
// 디버깅
System.out.println("customerId : " + customerId);

// 고객1 개인정보 수정 메서드 호출할 객체
CustomerService customerService = new CustomerService();
// 고객1 개인정보 받아올 객체
Customer customer = new Customer();
// 고객1 개인정보 받아오기
customer = customerService.selecCustomerOne(customerId);
// 디버깅
if (customer != null) {
	System.out.println("고객 1 정보 출력 성공!");
}
//디버깅
System.out.println("\n----------------------------------updateCustomerForm - end ---------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Modify Account</b>
			</h2>
			<br>
			<hr>
			<form action="<%=request.getContextPath()%>/customer/updateCustomerAction.jsp" id="modifyBtn">
				<table class="table table-hover table-striped"
					style="text-align: center; margin-bottom: 3%;" class="form-group">
					<tr>
						<th style="width: 40%;">customerId</th>
						<td><input type="hidden" id="customerId" name="customerId"
							readonly="readonly" class="form-control" value="<%=customerId%>"><%=customerId%></td>
					</tr>
					<tr>
						<th style="width: 40%;">customerName</th>
						<td><input type="hidden" id="customerName"
							name="customerName" readonly="readonly" class="form-control"><%=session.getAttribute("name")%>
						</td>
					</tr>
					<tr>
						<th style="width: 40%;">customerAddr</th>
						<td><input type="text" id="customerAddr" name="customerAddr"
							value="<%=customer.getCustomerAddress()%>" class="form-control"></td>
					</tr>
					<tr>
						<th style="width: 40%;">customerTelephone</th>
						<td><input type="text" id="customerTelephone"
							name="customerTelephone"
							value="<%=customer.getCustomerTelephone()%>" class="form-control">
						</td>
					</tr>
				</table>
				<button class="btn btn-warning" type="submit" style="color: white; float: right; margin-left: 70%; margin-bottom: 5%;" id="updateCustomerBtn">Modify</button>
			</form>
		</div>

	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
<!-- 
<script>
	$('#modifyBtn').click(function() {
		if ($('#customerAddr').val() == '') {
			alert('주소를 입력하세요.');
			$('#customerAddr').focus();
		} else if ($('#customerTelephone').val() == '') {
			alert('전회번호를 입력하세요.');
			$('#customerTelephone').focus();
		} else {
			$('#updateCustomerBtn').submit();
		}
	});
</script>
 -->
</html>