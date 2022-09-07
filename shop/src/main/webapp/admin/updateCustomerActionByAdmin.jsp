<%@page import="java.util.UUID"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n\n----------------------------------updateCustomerActionByAdmin- start ---------------------------------\n"); 

	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String customerId = request.getParameter("customerId");
	String customerPass = UUID.randomUUID().toString().substring(0, 7);
	// 디버깅
	System.out.println("updateMemberAction - customerId : " + customerId);
	System.out.println("updateMemberAction - password : " + customerPass);
	
	// modifyCustomerPw 매개변수 setter
	Customer paracustomer = new Customer();
	paracustomer.setCustomerId(customerId);
	paracustomer.setCustomerPass(customerPass);
	
	// 메서드 호출 객체 생성
	CustomerService customerService = new CustomerService();
		
	// 멤버 수정 메서드 호출 
	int customer = customerService.modifyCustomerPw(paracustomer);
	
	if (customer != 0) {
		System.out.println("멤버 비밀번호 수정 성공");
		response.sendRedirect(request.getContextPath() + "/admin/customerMemberList.jsp");
	}
	
	//디버깅
	System.out.println("\n----------------------------------updateCustomerActionByAdmin- end -----------------------------------\n"); 
%>