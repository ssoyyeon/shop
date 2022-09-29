<%@page import="java.util.UUID"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n\n----------------------------------deleteCustomerIdAction- start ---------------------------------"); 

	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println("deleteCustomerIdAction - customerId : " + customerId);
	
	// deleteCustomerById 매개변수 setter
	Customer paracustomer = new Customer();
	paracustomer.setCustomerId(customerId);
	
	// 메서드 호출 객체 생성
	CustomerService customerService = new CustomerService();
		
	// 멤버 수정 메서드 호출 
	int customer = customerService.deleteCustomerById(customerId);
	
	if (customer != 0) {
		System.out.println("멤버 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/admin/customerMemberList.jsp");
	}else {
		// 디버깅
		System.out.println("customer : " + customer);
	%>
	<script>
		alert("계정 삭제 실패!");
		location.href = "<%=request.getContextPath()%>/admin/customerMemberList.jsp";
	</script>
	<%
	}
	
	//디버깅
	System.out.println("----------------------------------deleteCustomerIdAction- end ---------------------------------\n\n"); 
%>