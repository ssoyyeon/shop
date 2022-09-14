<%@page import="repository.EmployeeDao"%>
<%@page import="service.EmployeeService"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 디버깅
	System.out.println("\n-----------------------------------------noticeOne--------------------------------------------");
	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null ) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	// 디버깅
	System.out.println("noticeOne - id : " + session.getAttribute("id"));
	System.out.println("noticeOne - user : " + session.getAttribute("user"));
	
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String employeeId = ((String)session.getAttribute("active"));
	// 디버깅
	System.out.println("noticeNo : " + noticeNo);
	System.out.println("employeeId : " + employeeId);
	
	// 상세보기 메서드 호출 
	NoticeService noticeService = new NoticeService();
	Notice notice = noticeService.noticeListOne(noticeNo);

	if (notice != null) {
		System.out.println("게시판 상세보기 성공");
	}
	
	// 디버깅
	System.out.println("-----------------------------------------noticeOne--------------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Notice Detail</b>
			</h2>
			<hr>
			<br> <br>
			<table class="table table-striped" style="text-align: center;">
				<tr>
					<td><b>noticeNo</b></td>
					<td><%=noticeNo%></td>
				</tr>
				<tr>
					<td><b>noticeTitle</b></td>
					<td><%=notice.getNoticeTitle()%></td>
				</tr>
				<tr>
					<td><b>noticeContent</b></td>
					<td><%=notice.getNoticeContent()%></td>
				</tr>
				<tr>
					<td><b>createDate</b></td>
					<td><%=notice.getCreateDate()%></td>
				</tr>
			</table>
			<br>
		</div>
		<div class="col-lg-2"></div>
		<br>
	</div>
	<div>
		<br> <br> 
<%
		if(session.getAttribute("user").equals("Employee")){
%>
		<a href="<%=request.getContextPath()%>/noticeList.jsp">
			<button type="submit" class="btn btn" style="float: right;  background-color:black; color:white;">noticeList</button>
		</a> 
			<a href="<%=request.getContextPath()%>/admin/deleteNoticeForm.jsp?noticeNo=<%=noticeNo%>">
				<button type="submit" class="btn btn" style="float: right;  background-color:black; color:white;">Delete</button>
			</a> 
			<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=noticeNo%>&noticeTitle=<%=notice.getNoticeTitle()%>&noticeContent=<%=notice.getNoticeContent()%>">
				<button type="submit" class="btn btn" style="float: right;  background-color:black; color:white;">Modify</button>
			</a> 
			
<% 
		}else{
%>		
		<a href="<%=request.getContextPath()%>/noticeList.jsp">
			<button type="submit" class="btn btn" style="float: right; background-color:black; color:white;">noticeList</button>
		</a> 
<%
		}
%>
	</div>

</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>