
<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println(
		"\n------------------------------------ deleteEmployeeAction - start ------------------------------------------------\n");

// 요청값 처리
String employeeId = request.getParameter("employeeId");
// 디버깅
System.out.println("deleteEmployeeAction - employeeId : " + employeeId);

// 삭제할 데이터를 넣기 위한 객체 생성 후 삭제할 데이터값 설정
Employee paramEmployee = new Employee();
paramEmployee.setEmployeeId(employeeId);
// 디버깅
System.out.println("deleteEmployeeAction -  paramEmployee.getEmployeeId() : " + paramEmployee.getEmployeeId());

// EmployeeService를 호출하기 위한 객체 생성 후 호출
EmployeeService employeeSerivce = new EmployeeService();

// 성공시 페이지 재요청하기 위한 변수 선언
boolean removeEmployee = employeeSerivce.removeEmployee(paramEmployee);
// 디버깅
System.out.println("removeEmployee : " + removeEmployee);

// 성공시 페이지 재요청
if (removeEmployee == true) {
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
} else {
	// 디버깅
	System.out.println("removeEmployee : " + removeEmployee);
%>
<script>
	alert("계정 삭제 실패!");
	location.href = "<%=request.getContextPath()%>/admin/adminIndex.jsp";
</script>
<%
}

//디버깅
System.out.println(
		"\n------------------------------------ deleteEmployeeAction - end ------------------------------------------------\n");
%>