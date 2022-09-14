<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println("\n---------------------------------customerMyPage start------------------------------------------\n");

//customer가 아닐 경우 접속 불가
if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));
%>
<%@ include file="/inc/header.jsp"%>
<!-- Start My Account  -->
<div class="my-account-box-main">
	<div class="container">
		<div class="my-account-page">
			<div class="row">
				<div class="col-lg-4 col-md-12">
					<div class="account-box">
						<div class="service-box">
							<div class="service-icon">
								<a
									href="<%=request.getContextPath()%>/customer/customerIndex.jsp"><i
									class="fa fa-lock"></i> </a>
							</div>
							<div class="service-desc">
								<h4>My Info</h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="account-box">
						<div class="service-box">
							<div class="service-icon">
								<a
									href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp">
									<i class="fa fa-gift"></i>
								</a>
							</div>
							<div class="service-desc">
								<h4>My Orders</h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="account-box">
						<div class="service-box">
							<div class="service-icon">
								<a href="<%=request.getContextPath()%>/customer/cartList.jsp"> <i class="fa fa-shopping-bag"></i>
								</a>
							</div>
							<div class="service-desc">
								<h4>My Cart</h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="account-box">
						<div class="service-box">
							<div class="service-icon">
								<a href="<%=request.getContextPath()%>/customer/customerReviewList.jsp"> <i class="far fa-comments"></i>
								</a>
							</div>
							<div class="service-desc">
								<h4>My Review</h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="account-box">
						<div class="service-box">
							<div class="service-icon">
								<a href="<%=request.getContextPath()%>/contact.jsp"> <i class="fas fa-headset"></i>
								</a>
							</div>
							<div class="service-desc">
								<h4>Contact Us</h4>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-12">
					<div class="account-box">
						<div class="service-box">
							<div class="service-icon">
								<a href="<%=request.getContextPath()%>/noticeList.jsp"> <i class="fas fa-bullhorn"></i>
								</a>
							</div>
							<div class="service-desc">
								<h4>Notice</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- End My Account -->
<%@ include file="/inc/footer.jsp"%>
</body>
</html>