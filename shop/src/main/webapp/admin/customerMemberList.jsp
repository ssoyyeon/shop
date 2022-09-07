<%@page import="service.CustomerService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n------------------------------------ customerMemberList - start ------------------------------------------------\n");

	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}

	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 변수 가져오기
	String customerId = ((String)session.getAttribute("id"));
	// 디버깅
	System.out.println("customerId : " + customerId);
	
	// 현재 페이지 구하기
	int currentPage = 1;
	// 받아오는 페이지가 있을 경우
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅
	System.out.println("customerMemberList - currentPage : " + currentPage);
	
	// 페이지 당 보여질 행 갯수
	final int rowPerPage = 10;
	
	// 메서드 호출을 위한 객체 생성
	CustomerService cutomerService = new CustomerService();

	// lastPage 구하는 메서드 호출
	int lastPage = cutomerService.lastPage(rowPerPage, currentPage);
	// 디버깅
	System.out.println("customerMemberList - lastPage : " + lastPage);
	
	// 멤버리스트 메서드
	List<Map<String, Object>> list = new ArrayList<>();
	list = cutomerService.selecCustomerList(rowPerPage, currentPage);
	// 디버깅
	System.out.println("customerMemberList - list : " + list);
	
	if (list == null) {
		System.out.println("customerMemberList 출력 실패!");
	}
	
	// 디버깅
	System.out.println("\n----------------------------------employeeMemberList- end -----------------------------------\n"); 
%>
<%@ include file="/inc/header.jsp"%>
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<!-- 메인페이지 -->
		<div class="col-lg-12"  style="margin-bottom: 6%; margin-top: 6%; background-color: #E9EDF1;">
			<h2 style="font-size:40px; text-align:center; margin-top: 5%;"><b>CUSTOMER LIST</b></h2>
			<br>
			<hr>
			<table class="table table-hover table-striped" style="text-align: center;">
				<thead>
					<tr>
						<th>customerId</th>
						<th>customerName</th>
						<th>customerAddress</th>
						<th>customerTelephone</th>
						<th>createDate</th>
						<th>updateDate</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<td>
						<a href="<%=request.getContextPath()%>/admin/customerOrderOne.jsp?customerId=<%=o.get("customerId")%>">
							<%=o.get("customerId")%>
						</a>
						</td>
						<td><%=o.get("customerName")%></td>
						<td><%=o.get("customerAddress")%></td>
						<td><%=o.get("customerTelephone")%></td>
						<td><%=o.get("createDate")%></td>
						<td><%=o.get("updateDate")%></td>
					</tr>
					<%
					}
					%>
				</tbody> 
			</table>
		</div> <!-- class="col-lg-12"  -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<div class="container" style="text-align: center;">
<%
			if (currentPage > 1) {
%>
				<a
					href="<%=request.getContextPath()%>/admin/customerMemberList.jsp?currentPage=<%=currentPage - 1%>">
					<button type="submit" class="btn btn-secondary">Pre</button>
				</a>
<%
			}else{

%>
				<a href="<%=request.getContextPath()%>/admin/customerMemberList.jsp?currentPage=<%=currentPage - 1%>">
					<button type="submit" class="btn btn-secondary" disabled="disabled">Pre</button>
				</a>
<%				
				
			}
			if (currentPage < lastPage) {
			// 디버깅
			System.out.println("lastPage : " + lastPage);
			System.out.println("currentPage : " + currentPage);
%>
				<a
					href="<%=request.getContextPath()%>/admin/customerMemberList.jsp?currentPage=<%=currentPage + 1%>">
					<button type="submit" class="btn btn-dark">Next</button>
				</a>

<%
			}else{
%>				
				<a
				href="<%=request.getContextPath()%>/admin/customerMemberList.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
				</a>
<%			
			}
%>
		</div> <!--  end 페이징 -->	
	</div> <!-- end row -->
</div>	<!-- end container -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>