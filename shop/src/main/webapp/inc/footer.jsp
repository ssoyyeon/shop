<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Start Footer  -->
<footer>
	<div class="footer-main">
		<div class="container" style="max-width: 80%;">
			<div class="row">
				<div class="col-lg-4 col-md-12 col-sm-12">
				<img
						src="<%=request.getContextPath()%>/images/스우시3.svg" class="logo"
						alt="logoImg" >
				</div>
				<div class="col-lg-4 col-md-12 col-sm-12">
					<div class="footer-link">
						<h4>Menu</h4>
						<ul>
							<%
							if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")) {
							%>
							<li><a
								href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">All
									Goods</a></li>
							<li><a href="<%=request.getContextPath()%>/noticeList.jsp">Notice</a></li>
							<li><a
								href="<%=request.getContextPath()%>/admin/customerMemberList.jsp">CustomerList</a></li>
							<li><a
								href="<%=request.getContextPath()%>/admin/employeeMemberList.jsp">EmployeeList</a></li>
							<li><a
								href="<%=request.getContextPath()%>/admin/reviewListByEmployee.jsp">Customer
									Review</a></li>
							<li><a
								href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">Customer
									Orders</a></li>
							<%
							} else {
							%>
							<li><a
								href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">Goods</a></li>
							<li><a href="<%=request.getContextPath()%>/noticeList.jsp">Notice</a></li>
							<li><a
								href="<%=request.getContextPath()%>/customer/cartList.jsp">Cart</a></li>
							<li><a
								href="<%=request.getContextPath()%>/customer/customerReviewList.jsp">Review</a></li>
							<li><a
								href="<%=request.getContextPath()%>/customer/customerOrdersList.jsp">Orders</a></li>
							<%
							}
							%>

						</ul>
					</div>
				</div>
				<div class="col-lg-4 col-md-12 col-sm-12">
					<div class="footer-link-contact">
						<h4>Contact Us</h4>
						<ul>
							<li>
								<p>
									<i class="fas fa-map-marker-alt"></i>Address: Dongan-gu,
									Anyang-si, <br>Gyeonggi-do <br>
								</p>
							</li>
							<li>
								<p>
									<i class="fas fa-phone-square"></i>Phone: <a
										href="tel:+82-12345678">+82 010 1234 5678</a>
								</p>
							</li>
							<li>
								<p>
									<i class="fas fa-envelope"></i>Email: <a
										href="mailto:20aachi01@gmail.com">20aachi01@gmail.com</a>
								</p>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>
<!-- End Footer  -->

<!-- Start copyright  -->
<div class="footer-copyright">
	<p class="footer-company">
		All Rights Reserved. &copy; 2022 <a href="#">Shop</a> Design By
		: So Yeon</a>
	</p>
</div>
<!-- End copyright  -->

<a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

<!-- ALL JS FILES -->
<script src="<%=request.getContextPath()%>/js/jquery-3.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/popper.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<!-- ALL PLUGINS -->
<script src="<%=request.getContextPath()%>/js/jquery.superslides.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-select.js"></script>
<script src="<%=request.getContextPath()%>/js/inewsticker.js"></script>
<script src="<%=request.getContextPath()%>/js/bootsnav.js."></script>
<script src="<%=request.getContextPath()%>/js/images-loded.min.js"></script>
<script src="<%=request.getContextPath()%>/js/isotope.min.js"></script>
<script src="<%=request.getContextPath()%>/js/owl.carousel.min.js"></script>
<script src="<%=request.getContextPath()%>/js/baguetteBox.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.nicescroll.min.js"></script>
<script src="<%=request.getContextPath()%>/js/form-validator.min.js"></script>
<script src="<%=request.getContextPath()%>/js/contact-form-script.js"></script>
<script src="<%=request.getContextPath()%>/js/custom.js"></script>