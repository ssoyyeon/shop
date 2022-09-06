<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<%
	//로그인 전이거나 스텝이 아니면 로그인 페이지로 돌아가기
	if(session.getAttribute("id") == null || session.getAttribute("user").equals("Customer")){
		response.sendRedirect(request.getContextPath()+"/noticeList.jsp");
		return;
	} 
	// active가 Y이 아니면 접속 불가
	if(! session.getAttribute("active").equals("Y")){
		response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println(session.getAttribute("active"));
	
	System.out.println("\nupdateNoticeForm");
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 디버깅
	System.out.println("noticeNo : " + noticeNo);
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	
	
%>
<!-- main -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>Notice Detail</b> </h2>
			<hr>
			<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
				<fieldset style=" margin-bottom: 4%;">
					<div>
						<label for="noticeNo">noticeNo</label>
						<input type="text" name="noticeNo" id="noticeNo" class="form-control" value="<%=noticeNo%>" readonly>
					</div>
					<div>
						<label for="noticeTitle">noticeTitle</label>
						<input type="text" name="noticeTitle" id="noticeTitle" class="form-control" value="<%=noticeTitle%>">
					</div>
					<div>
						<label for="noticeContent">noticeContent</label>
						<input type="text" name="noticeContent" id="noticeContent" class="form-control" value="<%=noticeContent%>">
					</div>
					<br>
				</fieldset>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">
					<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-bottom: 4%;">noticeList</button>
				</a> 
				<button type="submit" class="btn" style=" color: white; background-color: black; float: right; margin-bottom: 4%;" id="updateNoticeBtn" >Modify</button>
			</form>
			<br>
		</div>
		<div class="col-lg-2"></div>
		<br>
	</div>
	<div>
		<br> <br> 
		
			
	</div>

</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>