<%@page import="service.ReviewService"%>
<%@page import="service.OrdersService"%>
<%@page import="service.Cartservice"%>
<%@page import="service.CustomerService"%>
<%@page import="repository.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out
		.println("\n----------------------------------deleteCustomerAction - start ---------------------------------");
// 요청값 처리
String customerPass = request.getParameter("customerPass");
String customerId = request.getParameter("customerId");
// 디버깅
System.out.println("deleteCustomerAction - customerPass : " + customerPass);
System.out.println("deleteCustomerAction - customerId : " + customerId);

// 삭제할 데이터를 넣기 위한 객체 생성 후 삭제할 데이터값 설정
Customer paramCustomer = new Customer();
paramCustomer.setCustomerPass(customerPass);
paramCustomer.setCustomerId(customerId);
// 디버깅
System.out.println("deleteCustomerAction -  paramCustomer :" + paramCustomer.getCustomerPass() + " / "
		+ paramCustomer.getCustomerId());

// 메서드를 호출하기 위한 객체 생성 후 호출
CustomerService customerSerivce = new CustomerService();

// 성공시 페이지 재요청하기 위한 변수 선언
int removeCustomer = customerSerivce.removeCustomer(paramCustomer);
// 디버깅
System.out.println("removeCustomer : " + removeCustomer);
// 성공시 페이지 재요청
if (removeCustomer != 0) {
	// 디버깅
	System.out.println("remove 성공");
	session.invalidate(); // 세션 비우기
	response.sendRedirect(request.getContextPath() + "/main.jsp");

}
// 디버깅
System.out
		.println("----------------------------------deleteCustomerAction - start ---------------------------------\n");
%>