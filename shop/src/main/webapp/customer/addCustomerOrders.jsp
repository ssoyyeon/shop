<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Cart"%>
<%@page import="service.Cartservice"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="repository.GoodsDao"%>
<%@page import="java.util.Map"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
System.out.println("\n-----------------------addCutomerOrders start--------------------------------");

//customer가 아닐 경우 접속 불가
if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = ((String) session.getAttribute("id"));
String customerName = ((String) session.getAttribute("name"));
// 디버깅
System.out.println("goodsNo : " + goodsNo);
System.out.println("customerId : " + customerId);
System.out.println("customerName : " + customerName);

// 메서드 호출을 위한 객체 생성
Cartservice cartService = new Cartservice();

// 장바구니 상품1 상세보기 호출할 객체 생성
Cart cartList = new Cart();

// 장바구니 상품1 상세보기 호출
// cartList = cartService.selectCartOne(customerId, goodsNo);

// 디버깅
if (cartList != null) {
	System.out.println("장바구니 상품1 상세보기 출력 성공!");
}

// 고객 정보 가져오기
CustomerService customerService = new CustomerService();
Customer customer = customerService.selecCustomerOne(customerId);

// 디버깅
System.out.println("addCutomerOrders - customer : " + customer);

if (customer != null) {
	System.out.println("고객 정보 출력 성공!");
}

System.out.println("\n-----------------------addCutomerOrders end--------------------------------");
%>
<!--  header  -->
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="site-section" style="margin-top: 8%;">
	<div class="container">
		<div class="row">
			<div class="col-md-6 mb-5 mb-md-0">
				<h2 class="h3 mb-3 text-black">Orderer Information</h2>
				<div class="p-3 p-lg-5 border">
					<div class="form-group row">
						<div class="col-md-12">
							<label for="customerName" class="text-black">Name <span
								class="text-danger">*</span></label> <input type="text"
								class="form-control" id="customerName" name="customerName"
								value="<%=customerName%>" readonly>
						</div>
					</div>
					<div class="form-group ">
						<label for="customerTelephone" class="text-black">Phone <span
							class="text-danger">*</span></label> <input type="text"
							class="form-control" id="customerTelephone"
							name="customerTelephone"
							value="<%=customer.getCustomerTelephone()%>" readonly>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label for="customerAddress" class="text-black">CustomerAddress
								<span class="text-danger">*</span>
							</label> <input type="text" id="roadAddress" class="form-control"
								name="roadAddress" placeholder="Please enter Your Address">
							<span id="guide" style="color: #999; display: none"></span>
						</div>
					</div>

					<div class="form-group" style=" margin-bottom: 7%;">
						<label for="detailAddress" class="text-black">DetailAddress
							<span class="text-danger">*</span>
						</label> <input type="text" id="detailAddress" class="form-control"
							name="detail_address" placeholder="Please enter Your Address">
						<!-- 주소 검색 API -->
						<input type="button" onclick="execDaumPostcode()"
							value="Search Address" class="btn btn-outline-secondary"
							style="float: right; margin-top: 5%;">
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="col-md-12">
					<h2 class="h3 mb-3 text-black">Your Order</h2>
					<div class="p-3 p-lg-5 border">
						<table class="table site-block-order-table mb-5">
							<thead>
								<th>Product</th>
								<th>Total</th>
							</thead>
							<!-- 		
								<tbody>
									<tr>
										<td>주문 번호 <strong class="mx-2">x</strong> 주문 수량 <%=cartList.getCartQuantity()%>
										</td>
										
									
															<td><%-- 
											<%
												<td><%=cartList.get%></td>
											// 상품 가격 
											int Goodsprice = selectGoods.get("goodsPrice");
											// 수량
											int orderQuantity = selectGoods.get("orderQuantity");
											//	총액 = 상품 가격 * 수량 
											int subPrice =   Goodsprice * orderQuantity;
											%> <%=subPrice%> --%>
										</td>
 -->
							</tr>
							<tr>
								<td>Polo Shirt <strong class="mx-2">x</strong> 1
								</td>
								<td>$100.00</td>
							</tr>
							<tr>
								<td class="text-black font-weight-bold"><strong>Cart
										Subtotal</strong></td>
								<td class="text-black">$350.00</td>
							</tr>
							<tr>
								<td class="text-black font-weight-bold"><strong>Order
										Total</strong></td>
								<td class="text-black font-weight-bold"><strong>$350.00</strong></td>
							</tr>
							</tbody>
						</table>
						<div class="payment_item">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option5" name="selector">
                                    <label for="f-option5">Check payments</label>
                                    <div class="check"></div>
                                </div>
                                <p>Please send a check to Store Name, Store Street, Store Town, Store State / County,
                                    Store Postcode.</p>
                            </div>
                            <div class="payment_item active">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option6" name="selector">
                                    <label for="f-option6">Paypal </label>
                                    <img src="img/product/card.jpg" alt="">
                                    <div class="check"></div>
                                </div>
                                <p>Pay via PayPal; you can pay with your credit card if you don’t have a PayPal
                                    account.</p>
                            </div>
                            <div class="creat_account">
                                <input type="checkbox" id="f-option4" name="selector">
                                <label for="f-option4">I’ve read and accept the </label>
                                <a href="#">terms & conditions*</a>
                            </div>
						<div class="form-group">
							<button class="btn btn-primary btn-lg py-3 btn-block"
								style="background-color: #6f6f6f; border-color: #6f6f6f; margin-top: 7%; margin-bottom: 7%;">
								Order</button>
						</div>

					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- </form> -->
</div>
<!-- end main -->
<!-- footer -->
<%@ include file="/inc/footer.jsp"%>
</body>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById("roadAddress").value = roadAddr;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>
</html>