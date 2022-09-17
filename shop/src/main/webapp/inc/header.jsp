<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<!-- Basic -->

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>NNike</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">

<!-- chart -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js">
	
</script>
<!-- Site Icons -->
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/images/favicon.ico"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="<%=request.getContextPath()%>/images/apple-touch-icon.png">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<!-- Responsive CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/custom.css">

<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script
	src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

</head>
<body>
	<!-- Start Main Top -->
	<div class="main-top">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
					<div class="right-phone-box">
						<p>
							Call US :- <a href="#"> +82 010 1234 5678</a>
						</p>
					</div>
					<div class="text-slid-box" style="text-align: center;">
						<div id="offer-box" class="carouselTicker">
							<ul class="offer-box">
								<li><i class="fab fa-opencart"></i> Off 10%! Shop Women's
									Top!!</li>
								<li><i class="fab fa-opencart"></i> Off 30%! Shop Sale!</li>
								<li><i class="fab fa-opencart"></i> Off 10%! Shop Kids
									Shoes</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
					<div class="our-link" style="float: right;">
						<div class="our-link">
							<ul>
								<!-- Menu- home -->
								<li><a href="<%=request.getContextPath()%>/main.jsp">HOME</a></li>
								<%
								// Menu- home 
								if (session.getAttribute("id") == null) {
								%>
								<li><a href="<%=request.getContextPath()%>/loginForm.jsp">LOGIN</a></li>
								<li class="dropdown active"><a href="#"
									class="nav-link dropdown-toggle arrow" data-toggle="dropdown">SIGN UP</a>
									<ul class="dropdown-menu">
										<li>
											<a href="<%=request.getContextPath()%>/admin/addEmployee.jsp" style="color:black;">employee</a>
										</li>
										<li>
											<a href="<%=request.getContextPath()%>/customer/addCustomer.jsp" style="color:black;">customer</a>
										</li>
									</ul>
								</li>
								<%
								}
								// Menu- index
								if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) {
								%>
								<li><a
									href="<%=request.getContextPath()%>/admin/adminIndex.jsp">My
										Account</a></li>
								<%
								} else if (session.getAttribute("id") != null && session.getAttribute("user").equals("Customer")) {
								%>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerMyPage.jsp">
										My Page</a></li>
								<%
								}
								// Menu- member 
								if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) {
								%>
								<li><a
									href="<%=request.getContextPath()%>/admin/customerMemberList.jsp">CUSTOMER
								</a></li>
								<li><a
									href="<%=request.getContextPath()%>/admin/employeeMemberList.jsp">EMPLOYEE
								</a></li>
								<%
								}
								if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) {
								 %>
								<!-- Menu- goods -->
								<li><a
									href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">GOODS
								</a></li>
								<%
								 } 
								if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) { 
								%>
								<li><a
									href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">ORDER
								</a></li>
								<%
								}
								if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) { 
								%>
								<li><a
									href="<%=request.getContextPath()%>/admin/reviewListByEmployee.jsp">REVIEW</a></li>
								<%
								}
								if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) { 
								%>
								<li><a href="<%=request.getContextPath()%>/noticeList.jsp">NOTICE</a></li>
								<%
								}
								if (session.getAttribute("id") != null){
								%>
								<li><a href="<%=request.getContextPath()%>/logout.jsp">LOGOUT
								</a></li>
								<%
								}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Main Top -->
	<!-- Start Main Top -->
	<header class="main-header">
		<!-- Start Navigation -->
		<nav
			class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav"
			style="background-color: white;">
			<div class="container">
				<!-- Start Header Navigation -->
				<div class="navbar-header">
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbar-menu" aria-controls="navbars-rs-food"
						aria-expanded="false" aria-label="Toggle navigation">
						<i class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand" href="index.html"><img
						src="<%=request.getContextPath()%>/images/스우시3.svg" class="logo"
						alt="logoImg" width=100 height=100 style="margin-left: -230%;"></a>

				</div>
				<!-- End Header Navigation -->

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="navbar-menu">
					<ul class="nav navbar-nav ml-auto" style="margin-right: 19%;"
						data-in="fadeInDown" data-out="fadeOutUp">
						<li class="dropdown active"><a href="#"
							class="nav-link dropdown-toggle arrow" data-toggle="dropdown">All
								Goods</a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=-&category=clothing">clothing</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=-&category=Shoes">Shoes</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=-&category=Bag">Bags</a></li>
							</ul></li>
						<li class="dropdown active"><a href="#"
							class="nav-link dropdown-toggle arrow" data-toggle="dropdown">Women</a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=w&category=clothing">clothing</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=w&category=Shoes">Shoes</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=wl&category=Bag">Bags</a></li>
							</ul></li>
						<li class="dropdown active"><a href="#"
							class="nav-link dropdown-toggle arrow" data-toggle="dropdown">Men</a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=m&category=clothing">clothing</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=m&category=Shoes">Shoes</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=m&category=Bag">Bags</a></li>
							</ul></li>
						<li class="dropdown active"><a href="#"
							class="nav-link dropdown-toggle arrow" data-toggle="dropdown">Kids</a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=kids&category=clothing">Clothing</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=kids&category=Shoes">Shoes</a></li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=kids&category=Bag">Bags</a></li>
							</ul></li>
						<li class="dropdown active"><a href="#"
							class="nav-link dropdown-toggle arrow" data-toggle="dropdown">Sale</a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=sale&category=clothing">Clothing</a>
								</li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=sale&category=shoes">Shoes</a>
								</li>
								<li><a
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?kind=sale&category=bag">Bags</a>
								</li>
							</ul></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
				<!-- Start Atribute Navigation -->
				<div class="attr-nav"
					style="margin-left: 210px; margin-right: -250px;">
					<ul>
						<%
						//오늘 방문자수, 총 방문자수 메서드 호출을 위한 객체 생성
						CounterService counterService = new CounterService();
						// 총 방문자수
						int totalCounter = counterService.getTotalCount();
						// 오늘 방문자수
						int todayCounter = counterService.getTodayCount();
						// 현재 접속자 수
						int currentCount = (Integer) (application.getAttribute("currentCounter"));
						// 디버깅
						System.out.println(application.getAttribute("currentCounter"));
						%>
						<li><i class="fa fa-user-o"></i> <b>Total : <%=totalCounter%></b></li>
						<br>
						<li><i class="fa fa-user-o"></i> <b> Today : <%=todayCounter%></b></li>
						<br>
						<li><i class="fa fa-user-o"></i> <b>Current : </b><%=currentCount%></li>
					</ul>
				</div>
				<!-- End Atribute Navigation -->
			</div>
			<%
			//	}
			%>
		</nav>
		<!-- End Navigation -->
	</header>
	<!-- End Main Top -->
	<!-- Start Top Search -->
	<div class="top-search">
		<div class="container">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-search"></i></span>
				<input type="text" class="form-control" placeholder="Search">
				<span class="input-group-addon close-search"><i
					class="fa fa-times"></i></span>
			</div>
		</div>
	</div>
	<!-- End Top Search -->
	<hr>