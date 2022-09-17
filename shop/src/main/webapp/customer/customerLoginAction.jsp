<%@page import="service.CustomerService"%>
<%@page import="repository.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n----------------------------customerLoginAction start-------------------------------------\n");
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	// 디버깅
	System.out.println("customerLoginAction - customerId : " + customerId);
	System.out.println("customerLoginAction - customerPass : " + customerPass);
	
	// 데이터를 넣을 객체 생성 후 setter값 설정
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// CustomerService를 호출하기 위한 객체 생성 후 호출
	CustomerService customerService = new CustomerService();
	
	Customer loginCustomer = customerService.customerLogin(customer);
	
	// 디버깅 후 페이지 이동
	if(loginCustomer != null){
		System.out.println("로그인 성공!");
		session.setAttribute("user", "Customer");
		session.setAttribute("id", loginCustomer.getCustomerId());
		session.setAttribute("pw", loginCustomer.getCustomerPass());
		session.setAttribute("name", loginCustomer.getCustomerName());
		response.sendRedirect(request.getContextPath() + "/customer/customerIndex.jsp");

		System.out.println("-------------- session.getAttribute() ----------------");
		System.out.println("customer user : " + session.getAttribute("user") );
		System.out.println("customer id : " + session.getAttribute("id") );
		System.out.println("customer pw : " + session.getAttribute("pw") );
		System.out.println("customer name : " + session.getAttribute("name") );
		
	}else{
		System.out.println("로그인 실패!");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	}
	
	// 디버깅
	System.out.println("\n----------------------------customerLoginAction end---------------------------------------\n");
%>