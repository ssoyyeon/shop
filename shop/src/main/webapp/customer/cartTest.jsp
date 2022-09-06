<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header -->
<%@ include file="/inc/header.jsp"%>
<body>
	<!-- Start Cart  -->
	<div class="cart-box-main">
		<div class="container">
			<div class="row">
				<div class="col-lg-9">
					<div class="table-main table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th>goodsImages</th>
									<th>goodsName</th>
									<th>goodsPrice</th>
									<th>Quantity</th>
									<th>Total</th>
									<th>Remove</th>
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
									<td class="quantity-box"><input type="number" size="4"
										value="1" min="0" step="1" class="c-input-text qty text"></td>
									<td class="total-pr">
										<p>$ 80.0</p>
									</td>
									<td class="remove-pr"><a
										href="<%=request.getContextPath()%>/customer/deleteCarListForm.jsp">
											<i class="fas fa-times"></i>
									</a></td>
								</tr>

							</tbody>
						</table>
					</div>
					<div class="update-box">
						<a
							href="<%=request.getContextPath()%>/customer/updateCartQuantity.jsp">
							<button type="submit" class="btn btn-warning"
								style="color: white;">Modify</button>
						</a> <input value="Update Cart" type="submit">
					</div>
				</div>

			<div class="col-lg-3 col-sm-12">
				<div class="order-box">
					<h3>Order summary</h3>
					<div class="d-flex">
						<h4>Sub Total</h4>
						<div class="ml-auto font-weight-bold">$ 130</div>
					</div>
					<div class="d-flex">
						<h4>Discount</h4>
						<div class="ml-auto font-weight-bold">$ 40</div>
					</div>
					<hr class="my-1">
					<div class="d-flex">
						<h4>Coupon Discount</h4>
						<div class="ml-auto font-weight-bold">$ 10</div>
					</div>
					<div class="d-flex">
						<h4>Tax</h4>
						<div class="ml-auto font-weight-bold">$ 2</div>
					</div>
					<div class="d-flex">
						<h4>Shipping Cost</h4>
						<div class="ml-auto font-weight-bold">Free</div>
					</div>
					<hr>
					<div class="d-flex gr-total">
						<h5>Grand Total</h5>
						<div class="ml-auto h5">$ 388</div>
					</div>
					<hr>
				</div>
			</div>
			<div class="col-12 d-flex shopping-box">
				<a href="checkout.html" class="ml-auto btn hvr-hover">Checkout</a>
			</div>
		</div>
			</div>
	</div>
	</div>
	<!-- End Cart -->
	<!-- footer -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>