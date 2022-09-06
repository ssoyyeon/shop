<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 요청값 처리
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employee_pass");
	String employeeName = request.getParameter("employee_name");
	// 디버깅
	System.out.println("\n------------------------------------------------addEmployeeAction ");
	System.out.println("addEmployeeAction - employeeId : " + employeeId);
	System.out.println("addEmployeeAction - employeePass : " + employeePass);
	System.out.println("addEmployeeAction - employeeName : " + employeeName);
	
	// 값 설정할 객체 생성 후 setter
	Employee employeeAdd = new Employee(); 
	employeeAdd.setEmployeeId(employeeId);
	employeeAdd.setEmployeePass(employeePass);
	employeeAdd.setEmployeeName(employeeName);
	//디버깅
	System.out.println("addEmployeeAction - employeeAdd : " + employeeAdd);
	
	// 메서드 호출할 객체 생성
	EmployeeService employeeService = new EmployeeService();
	int row = employeeService.addEmployee(employeeAdd);
	
	// 회원가입 성공시 View 재요청
	if(row != 0){
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	}
%>