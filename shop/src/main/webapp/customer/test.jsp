<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Start header  -->
<%@ include file="/inc/header.jsp"%>
<!-- end header  -->
<body>
	<!-- Start All Title Box -->
	<div class="all-title-box">
		<div class="container">
			<div class="row">
				<div class="col-lg-12" style="backgound-color: white;">
					<h2 style="font-size: 55px;">Wishlist</h2>
				</div>
			</div>
		</div>
	</div>
	<!-- End All Title Box -->
	<!-- Start Wishlist  -->
	<div class="wishlist-box-main">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="table-main table-responsive">
						<table class="table">
							<thead>
								<tr style="width: 120px; text-align: center">
									<th><b>goodseNo</b></th>
									<th><b>goodsImg</b></th>
									<th><b>goodsName</b></th>
									<th><b>goodsPrice</b></th>
									<th><b>soldOut</b></th>
									<th><b>createDate</b></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="thumbnail-img"><a href="#"> <img
											class="img-fluid" src="images/img-pro-01.jpg" alt="" />
									</a></td>
									<td class="name-pr"><a href="#"> Lorem ipsum dolor sit
											amet </a></td>
									<td class="price-pr">
										<p>$ 80.0</p>
									</td>
									<td class="quantity-box">In Stock</td>
									<td class="add-pr"><a class="btn hvr-hover" href="#">Add
											to Cart</a></td>
									<td class="remove-pr"><a href="#"> <i
											class="fas fa-times"></i>
									</a></td>
								</tr>
								<tr>
									<td class="thumbnail-img"><a href="#"> <img
											class="img-fluid" src="images/img-pro-02.jpg" alt="" />
									</a></td>
									<td class="name-pr"><a href="#"> Lorem ipsum dolor sit
											amet </a></td>
									<td class="price-pr">
										<p>$ 60.0</p>
									</td>
									<td class="quantity-box">In Stock</td>
									<td class="add-pr"><a class="btn hvr-hover" href="#">Add
											to Cart</a></td>
									<td class="remove-pr"><a href="#"> <i
											class="fas fa-times"></i>
									</a></td>
								</tr>
								<tr>
									<td class="thumbnail-img"><a href="#"> <img
											class="img-fluid" src="images/img-pro-03.jpg" alt="" />
									</a></td>
									<td class="name-pr"><a href="#"> Lorem ipsum dolor sit
											amet </a></td>
									<td class="price-pr">
										<p>$ 30.0</p>
									</td>
									<td class="quantity-box">In Stock</td>
									<td class="add-pr"><a class="btn hvr-hover" href="#">Add
											to Cart</a></td>
									<td class="remove-pr"><a href="#"> <i
											class="fas fa-times"></i>
									</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Wishlist -->
	<!-- Start Footer  -->
	<%@ include file="/inc/footer.jsp"%>
	<!-- end Footer  -->
	<a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

	<!-- ALL JS FILES -->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- ALL PLUGINS -->
	<script src="js/jquery.superslides.min.js"></script>
	<script src="js/bootstrap-select.js"></script>
	<script src="js/inewsticker.js"></script>
	<script src="js/bootsnav.js."></script>
	<script src="js/images-loded.min.js"></script>
	<script src="js/isotope.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/baguetteBox.min.js"></script>
	<script src="js/form-validator.min.js"></script>
	<script src="js/contact-form-script.js"></script>
	<script src="js/custom.js"></script>
</body>

</html>