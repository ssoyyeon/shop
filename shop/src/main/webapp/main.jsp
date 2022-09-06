<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>

<!-- Start Top Search -->
<div class="top-search">
	<div class="container">
		<div class="input-group">
			<span class="input-group-addon"><i class="fa fa-search"></i></span> <input
				type="text" class="form-control" placeholder="Search"> <span
				class="input-group-addon close-search"><i class="fa fa-times"></i></span>
		</div>
	</div>
</div>
<!-- End Top Search -->

<!-- Start Slider -->
<div id="slides-shop" class="cover-slides" style="margin-top: 5%;">
	<ul class="slides-container">
		<li class="text-center"><img src="images/main1.png" alt="main1">
			<div class="container">
				<div class="row">
					<div class="col-md-12"></div>
				</div>
			</div></li>
		<li class="text-center"><img src="images/main3.png" alt="main2">
			<div class="container">
				<div class="row">
					<div class="col-md-12"></div>
				</div>
			</div></li>
		<li class="text-center"><img src="images/main2.png" alt="main3">
			<div class="container">
				<div class="row">
					<div class="col-md-12"></div>
				</div>
			</div></li>
	</ul>
</div>
<!-- End Slider -->

<!-- Start Categories  -->
<div class="categories-shop" style="margin-left: -12%; margin-top: 3%;">
	<div class="container">
		<div class="row" style="width: 130%;">
			<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<div class="shop-cat-box">
					<img class="img-fluid" src="images/mainTop.png" alt="mainTop"
						style="height: 420px;" /> <a class="btn hvr-hover" href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">view
						more</a>
				</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<div class="shop-cat-box">
					<img class="img-fluid" src="images/mainPants.png" alt="mainPants"
						style="height: 420px;" /> <a class="btn hvr-hover" href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">view
						more</a>
				</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<div class="shop-cat-box">
					<img class="img-fluid" src="images/mainShoes.png" alt="mainShoes"
						style="height: 420px;" /> <a class="btn hvr-hover" href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">view
						more</a>
				</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<div class="shop-cat-box">
					<img class="img-fluid" src="images/mainbags.png" alt="mainbags"
						style="height: 420px;" /> <a class="btn hvr-hover" href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">view
						more</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- End Categories -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>