<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n----------------------------------addGoodsReview - start ---------------------------------");

	//로그인 전이거나 고객이 아니면 로그인 페이지로 돌아가기
	if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Customer"))){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	//디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));

	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	// 변수 처리
	String customerId = ( (String )session.getAttribute("id") );
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	// 디버깅
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("customerId : " + customerId);
	System.out.println("orderNo : " + orderNo);
	
	//디버깅
	System.out.println("----------------------------------addGoodsReview - end ---------------------------------\n");
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
				<b>ADD REVIEW</b></h2>
			<form action="<%=request.getContextPath()%>/customer/addGoodsReviewAction.jsp" id="addGoodsForm" method="post" class="form-group">
			
				<hr>
				<br>
				<br>
				<table class="table table-hover table-striped" >
					<tr>
						<td><b>goodsNo</b></td>
						<td>
							<input type="hidden" name="goodsNo" id="goodsNo" value="<%=goodsNo%>"><%=goodsNo%>
							<input type="hidden" name="orderNo" id="orderNo" value="<%=orderNo%>">
							
						</td>
					</tr>
					<tr>
						<td style="width: 50px;"><b>ReviewContent</b></td>
						<td><textarea rows="5" cols="20" name="reviewContent" id="reviewContent" class="form-control"></textarea> </td>
					</tr>
					
				</table>
				<br>
				<br>
				<button type="button" class="btn btn-success" style="float: right; margin-right: 3%; margin-bottom:5%;" id="addReviewBtn">확인</button>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>

</body>
<script>
	$('#addReviewBtn').click(function() {
		if ($('#reviewContent').val().length < 1) {
			alert('내용을 입력하세요.');
			$('#addGoodsForm').focus();
		} else {
			$('#addGoodsForm').submit();
		}
	});
</script>
</html>