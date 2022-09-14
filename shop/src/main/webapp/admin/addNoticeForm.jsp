<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n-------------------------------------addNoticeForm - start ------------------------------------------------\n");
	// 로그인 전이거나 스텝이 아니면 로그인 페이지로 돌아가기
	if(session.getAttribute("id") == null || session.getAttribute("user").equals("Customer") ){
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	} 
 	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	
	//디버깅
	System.out.println("\n-------------------------------------addNoticeForm - end ------------------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>

<!-- main -->
<div class="container">
	<div class="row">
		<div class="col-lg-2"></div>
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1; padding: 5%;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
				<b>ADD NOTICE</b></h2>
			<form action="<%=request.getContextPath()%>/admin/addNoticeAction.jsp" id="addNoticeForm" method="post" class="form-group">
			
				<hr>
				<br>
				<br>
				<table class="table table-hover table-striped" >
					<tr>
						<td  style="width: 50px;"><b>NoticeTitle</b></td>
						<td><input type="text" name="noticeTitle" id="noticeTitle" class="form-control"></td>
					</tr>
					<tr>
						<td  style="width: 50px;"><b>NoticeContent</b></td>
						<td><textarea rows="5" cols="20" name="noticeContent" id="noticeContent" class="form-control"></textarea> ></td>
					</tr>
					
				</table>
				<br>
				<br>
				<button type="submit" class="btn" style="background-color:black; color:white; float: right; margin-right: 3%; margin-bottom:5%;" id="addNoticeBtn">확인</button>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>

</body>
<script>
	$('#addNoticeBtn').click(function() {
		if ($('#noticeTitle').val().length < 1) {
			alert('제목을 입력하세요');
		} else if ($('#noticeContent').val().length < 1) {
			alert('내용을 입력하세요.');
		} else {
			$('#addNoticeForm').submit();
		}
	});
</script>
</html>