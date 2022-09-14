<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n------------------------------cutomerIndex start---------------------------------------\n");
	// 로그인 전이거나 고객이 아니면 로그인 페이지로 돌아가기
	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Customer"))){
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	} 
	//디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String customerId = ( (String)session.getAttribute("id") );
	// 디버깅
	System.out.println("customerId : " + customerId);
	
	// 고객1 개인정보 메서드 호출할 객체
	CustomerService customerService = new CustomerService();
	// 고객1 개인정보 받아올 객체
	Customer customer = new Customer();
	// 고객1 개인정보 받아오기
	customer = customerService.selecCustomerOne(customerId);
	// 디버깅
	if( customer != null){
		System.out.println("고객 1 정보 출력 성공!");
	}

	// 디버깅
	System.out.println("\n------------------------------cutomerIndex end----------------------------------------\n");
%>    
<%@ include file="/inc/header.jsp"%>
	<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>My Account</b>
			</h2>
			<br>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center; margin-bottom: 5%;">
				<tr>
					<th style="width: 40%;">customerId</th>
					<td><%=session.getAttribute("id")%>(<%=session.getAttribute("user")%>)</td>
				</tr>
				<tr>
					<th style="width: 40%;">customerName</th>
					<td><%=session.getAttribute("name")%></td>
				</tr>
				<tr>
					<th style="width: 40%;">customerAddress</th>
					<td><%=customer.getCustomerAddress() %></td>
				</tr>
				<tr>
					<th style="width: 40%;">detailAddress</th>
					<td><%=customer.getDetailAddress()%></td>
				</tr>	
				<tr>
					<th style="width: 40%;">customerTelephone</th>
					<td><%=customer.getCustomerTelephone() %></td>
				</tr>
				<tr>
					<th style="width: 40%;">createDate</th>
					<td><%=customer.getCreateDate() %></td>
				</tr>
				<tr>
					<th style="width: 40%;">updateDate</th>
					<td><%=customer.getUpdateDate() %></td>
				</tr>
			</table>
		</div>
		<div style="float: right; margin-top: 7%; margin-left: 75%;">
			<a href="<%=request.getContextPath()%>/customer/updateCustomerForm.jsp?customerId=<%=customerId%>">
				<button class="btn btn" type="submit" style="color:white;background-color:black;">ModifyAccount</button>
			</a>
			<a href="<%=request.getContextPath()%>/customer/deleteCustomerForm.jsp?customerId=<%=customerId%>">
				<button class="btn btn" type="submit"  style="color:white;background-color:black;">DeleteAccount</button>
			</a>
		</div>
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>