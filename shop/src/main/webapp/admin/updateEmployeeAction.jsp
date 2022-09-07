<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------updateMemberAction- start ---------------------------------\n"); 

	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String employeeId = request.getParameter("employeeId");
	String active = request.getParameter("active");
	// 디버깅
	System.out.println("updateMemberAction - employeeId : " + employeeId);
	System.out.println("updateMemberAction - active : " + active);
	
	// 메서드 호출 객체 생성
	EmployeeService employeeService = new EmployeeService();
		
	// 멤버 수정 메서드 호출 
	int employee = employeeService.modifyMember(employeeId,active);
	
	if (employee != 0) {
		System.out.println("멤버 수정 성공");
		response.sendRedirect(request.getContextPath() + "/admin/employeeMemberList.jsp");
	}
	
	//디버깅
	System.out.println("\n----------------------------------updateMemberAction- end ---------------------------------\n"); 
%>