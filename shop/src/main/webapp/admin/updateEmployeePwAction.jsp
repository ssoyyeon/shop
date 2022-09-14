<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n\n----------------------------------updateEmployeePwAction- start ---------------------------------\n"); 
	
	// 요청값 처리
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	// 디버깅
	System.out.println("updateMemberAction - employeeId : " + employeeId);
	System.out.println("updateMemberAction - employeePass : " + employeePass);

	// 메서드 호출 객체 생성
	EmployeeService employeeService = new EmployeeService();
	
	// 멤버 수정 메서드 호출 
	int employeeS = employeeService.modifyMemberPw(employeePass, employeeId);
	
	if (employeeS != 0) {
		System.out.println("멤버 비밀번호 수정 성공");
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
	}
	
	//디버깅
	System.out.println("\n----------------------------------updateEmployeePwAction- end -----------------------------------\n"); 
%>