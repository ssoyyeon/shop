<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n\n----------------------------------updateCustomerAction- start ------------------------------------\n"); 

	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String customerId = request.getParameter("customerId");
	String customerAddr = request.getParameter("customerAddr");
	String detailAddr = request.getParameter("detailAddr");
	String customerTelephone = request.getParameter("customerTelephone");
	// 디버깅
	System.out.println("updateMemberAction - customerId : " + customerId);
	System.out.println("updateMemberAction - detailAddr : " + detailAddr);
	System.out.println("updateMemberAction - customerAddr : " + customerAddr);
	System.out.println("updateMemberAction - customerTelephone : " + customerTelephone);
	
	// modifyCustomerPw 매개변수 setter
	Customer paracustomer = new Customer();
	paracustomer.setCustomerId(customerId);
	paracustomer.setDetailAddress(detailAddr);
	paracustomer.setCustomerTelephone(customerTelephone);
	paracustomer.setCustomerAddress(customerAddr);
	
	// 메서드 호출 객체 생성
	CustomerService customerService = new CustomerService();
		
	// 멤버 수정 메서드 호출 
	int customer = customerService.modifyCustomer(paracustomer);
	
	if (customer != 0) {
		System.out.println("고객 정보 수정 성공");
		response.sendRedirect(request.getContextPath() + "/customer/customerIndex.jsp");
	}
	
	//디버깅
	System.out.println("\n----------------------------------updateCustomerAction- end ------------------------------------\n"); 
%>