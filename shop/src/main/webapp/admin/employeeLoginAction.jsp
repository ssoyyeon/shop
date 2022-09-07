<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="vo.Employee"%>
<%@page import="repository.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n------------------------------------ employeeLoginAction - start ------------------------------------------------\n");

	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	// 디버깅
	System.out.println("employeeLoginAction - employeeId : " + employeeId);
	System.out.println("employeeLoginAction - employeePass : " + employeePass);
	
	// 데이터를 넣을 객체 생성 후 setter값 설정
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	employee.setEmployeeName(employeePass);
	
	// 매서드 불러올 객체 생성 후 실행
	EmployeeService employeeService = new EmployeeService();
	Employee loginEmployee = employeeService.employeeLogin(employee);
			
	// 디버깅 후 페이지 이동
	if (loginEmployee != null) {
		System.out.println("로그인 성공!");
		session.setAttribute("user", "Employee");
		session.setAttribute("id", loginEmployee.getEmployeeId());
		session.setAttribute("name",loginEmployee.getEmployeeName());
		session.setAttribute("active",loginEmployee.getActive());
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		
		System.out.println("session.getAttribute() ---------------- 디버깅");
		System.out.println("user : " + session.getAttribute("user"));
		System.out.println("id : " + session.getAttribute("id"));
		System.out.println("name : " + session.getAttribute("name"));
		System.out.println("active : " + session.getAttribute("active"));
		System.out.println("end employeeLoginAction ");
		System.out.println("-----------------------------------------------------------------------------------------\n");
	} else {
		System.out.println("로그인 실패!");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	}
	
	//디버깅
	System.out.println("\n------------------------------------ employeeLoginAction - end ------------------------------------------------\n");
%>