<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n-------------------------------------addGoodsForm - start ------------------------------------------------\n");
	//admin이 아닐 경우 접속 불가
	if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
		response.sendRedirect(request.getContextPath() + "/main.jsp");
		return;
	}
	// 디버깅
	System.out.println("id : " + session.getAttribute("id"));
	System.out.println("user : " + session.getAttribute("user"));
	System.out.println("active : " + session.getAttribute("active"));

	//디버깅
	System.out.println("\n-------------------------------------addGoodsForm end ------------------------------------------------\n");
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
				<b>ADD GOODS</b></h2>
			<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp" id="addGoodsForm" method="post" enctype="multipart/form-data" class="form-group">
			
				<hr>
				<br>
				<br>
				<table class="table table-hover table-striped" >
					<tr>
						<td style="width: 50px;"><b>GoodsName</b></td>
						<td><input type="text" name="goods_name" id="goods_name" class="form-control"></td>
					</tr>
					<tr>
						<td style="width: 50px;"><b>GoodsPrice</b></td>
						<td><input type="text" name="goods_price" id="goods_price" class="form-control"></td>
					</tr>
					<tr>
						<td style="width: 50px;"><b>SoldOut</b></td>
						<td><input type="text" name="sold_out" id="sold_out" class="form-control"></td>
					</tr>

					<tr>
						<td style="width: 50px;"><label for="imgFile"><b>ImgFile</b></label></td>
						<td><input type="file" name="imgFile" id="imgFile" class="form-control"></td>
					</tr>
				</table>
				<br>
				<br>
				<button type="button" class="btn" style="background-color:black; color:white; float: right; margin-right: 3%; margin-bottom:5%;" id="addGoodsBtn">Add Goods</button>
			</form>
		</div>
	</div>
</div>
<!-- end main -->
<%@ include file="/inc/footer.jsp"%>

</body>
<script>
	$('#addGoodsBtn').click(function() {
		if ($('#goods_name').val().length < 1) {
			alert('제목을 입력하세요');
		} else if ($('#goods_price').val().length < 1) {
			alert('가격을 입력하세요.');
		} else if ($('#sold_out').val().length < 1) {
			alert('품절여부를 입력하세요.');
		} else if ($('#imgFile').val().length < 1) {
			alert('파일을 업로드하세요');
		} else {
			$('#addGoodsForm').submit();
		}
	});
</script>
</html>