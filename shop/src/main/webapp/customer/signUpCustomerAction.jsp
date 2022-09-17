<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n-------------------------------------------signUpCustomerAction start--------------------------------------\n ");
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 요청값 처리
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customer_pass");
	String customerName = request.getParameter("customer_name");
	String customerAddress = request.getParameter("customer_address");
	String detailAddress = request.getParameter("detail_address");
	String customerTelephone = request.getParameter("customer_telephone");
	System.out.println("addCustomerAction - CustomerId : " + customerId);
	System.out.println("addCustomerAction - CustomerPass : " + customerPass);
	System.out.println("addCustomerAction - CustomerName : " + customerName);
	System.out.println("addCustomerAction - CustomerAddress : " + customerAddress);
	System.out.println("addCustomerAction - detailAddress : " + detailAddress);
	System.out.println("addCustomerAction - CustomerTelephone : " + customerTelephone);
	
	// 값 설정할 객체 생성 후 setter
	Customer customerAdd = new Customer(); 
	customerAdd.setCustomerId(customerId);
	customerAdd.setCustomerPass(customerPass);
	customerAdd.setCustomerAddress(customerAddress);
	customerAdd.setDetailAddress(detailAddress);
	customerAdd.setCustomerName(customerName);
	customerAdd.setCustomerTelephone(customerTelephone);
	//디버깅
	System.out.println("addCustomerAction - customerAdd : " + customerAdd);
	
	// 메서드 호출할 객체 생성
	CustomerService customerService = new CustomerService();
	int row = customerService.addCustomer(customerAdd);
	
	// 회원가입 성공시 View 재요청
	if(row != 0){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	}
	// 디버깅
	System.out.println("\n--------------------------------------------signUpCustomerAction end------------------------------------------\n ");
%>