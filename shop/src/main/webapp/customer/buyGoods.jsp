<%@page import="service.BuyService"%>
<%@page import="java.util.HashMap"%>
<%@page import="vo.Orders"%>
<%@page import="java.util.Arrays"%>
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
// 디버깅
System.out.println("\n---------------------------------buyGoods start------------------------------------------\n");

//customer가 아닐 경우 접속 불가
if (session.getAttribute("id") == null || (!((String) session.getAttribute("user")).equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 변수 가져오기
String customerId = ((String) session.getAttribute("id"));
//디버깅
System.out.println("customerId : " + customerId);

// 메서드를  호출 위한 객체생성
BuyService buyService = new BuyService();

// 리턴할 객체 생성
List<Map<String, Object>> list = null;

// 리스트 준비
List<Cart> cartList = new ArrayList<>();
// 주문 리스트 넣어주기
if((session.getAttribute("cartList") != null)){
cartList = ((List<Cart>) request.getAttribute("cartList"));
//디버깅
System.out.println( request.getAttribute("cartList"));

list = buyService.getBuyByCartList(cartList);
}
// 고객 정보 가져오기
CustomerService customerService = new CustomerService();
Customer customer = customerService.selecCustomerOne(customerId);

// 디버깅
System.out.println("addCutomerOrders - customer : " + customer);

if (customer != null) {
	System.out.println("고객 정보 출력 성공!");
}

// 디버깅
System.out.println("\n---------------------------------buyGoods end------------------------------------------\n");
%>
<!--  header  -->
<%@ include file="/inc/header.jsp"%>
<!-- main -->
<div class="site-section" style="margin-top: 8%;">
	<div class="container">
		<form
			action="<%=request.getContextPath()%>/customer/buyGoodsAction.jsp"
			method="post">
			<div class="row">
				<div class="col-md-6 mb-5 mb-md-0">
					<h2 class="h3 mb-3 text-black">Orderer Information</h2>
					<div class="p-3 p-lg-5 border">
						<div class="form-group row">
							<div class="col-md-12">
								<label for="customerName" class="text-black">Name <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="customerName" name="customerName"
									value="<%=customer.getCustomerName()%>" readonly>
							</div>
						</div>
						<div class="form-group ">
							<label for="customerTelephone" class="text-black">Phone <span
								class="text-danger">*</span></label> <input type="text"
								class="form-control" id="customerTelephone"
								name="customerTelephone"
								value="<%=customer.getCustomerTelephone()%>" readonly>
						</div>

						<!-- address -->
						<label for="Address" class="text-black">Address</label> <input
							type="text" id="sample2_address"
							placeholder="Please enter Your Address" class="form-control"
							name="orderAddress"><br> <input type="text"
							id="sample2_detailAddress" readonly
							placeholder="Please enter Your DetailAddress"
							class="form-control" name="detailAddress"> <input
							type="hidden" id="sample2_extraAddress" placeholder="참고항목">
						<input type="hidden" id="sample2_postcode" placeholder="우편번호">
						<input type="button" onclick="sample2_execDaumPostcode()"
							value="Search" style="margin-left: 90%; margin-top: 5%;"><br>

						<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
						<div id="layer"
							style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
							<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
								id="btnCloseLayer"
								style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
								onclick="closeDaumPostcode()" alt="닫기 버튼">
						</div>

					</div>
				</div>
				<div class="col-md-6">
					<div class="col-md-12">
						<h2 class="h3 mb-3 text-black">Your Order</h2>
						<div class="p-3 p-lg-5 border">
							<table class="table site-block-order-table mb-5">
								<thead>
									<tr>
										<th>Product</th>
										<th>Total</th>
									</tr>
								</thead>

								<tbody>
									<%
									for (Map<String, Object> m : list) {
									%>
									<tr>
										<td><%=m.get("goodsName")%><strong class="mx-2">x</strong>
											<%=m.get("cartQuantity")%></td>


										<td><%=m.get("goodsPrice")%>won <input type="hidden"
											name="orderPrice" value="<%=m.get("goodsPrice")%>"></td>
									</tr>
									<%
									}
									%>
									<%-- 
											<%
												<td><%=cartList.get%></td>
											// 상품 가격 
											int Goodsprice = selectGoods.get("goodsPrice");
											// 수량
											int orderQuantity = selectGoods.get("orderQuantity");
											//	총액 = 상품 가격 * 수량 
											int subPrice =   Goodsprice * orderQuantity;
											%> <%=subPrice%> --%>
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
									<input type="radio" id="f-option5" name="selector"> <label
										for="f-option5">Check payments</label>
									<div class="check"></div>
								</div>
								<p>Please send a check to Store Name, Store Street, Store
									Town, Store State / County, Store Postcode.</p>
							</div>
							<div class="payment_item active">
								<div class="radion_btn">
									<input type="radio" id="f-option6" name="selector"> <label
										for="f-option6">Paypal </label> <img
										src="img/product/card.jpg" alt="">
									<div class="check"></div>
								</div>
								<p>Pay via PayPal; you can pay with your credit card if you
									don’t have a PayPal account.</p>
							</div>
							<div class="creat_account">
								<input type="checkbox" id="f-option4" name="selector"> <label
									for="f-option4">I’ve read and accept the </label> <a href="#">terms
									& conditions*</a>
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
		</form>
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
	// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');

	function closeDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_layer.style.display = 'none';
	}

	function sample2_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample2_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample2_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample2_postcode').value = data.zonecode;
						document.getElementById("sample2_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample2_detailAddress")
								.focus();

						// iframe을 넣은 element를 안보이게 한다.
						// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
						element_layer.style.display = 'none';
					},
					width : '100%',
					height : '100%',
					maxSuggestItems : 5
				}).embed(element_layer);

		// iframe을 넣은 element를 보이게 한다.
		element_layer.style.display = 'block';

		// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		initLayerPosition();
	}

	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition() {
		var width = 300; //우편번호서비스가 들어갈 element의 width
		var height = 400; //우편번호서비스가 들어갈 element의 height
		var borderWidth = 5; //샘플에서 사용하는 border의 두께

		// 위에서 선언한 값들을 실제 element에 넣는다.
		element_layer.style.width = width + 'px';
		element_layer.style.height = height + 'px';
		element_layer.style.border = borderWidth + 'px solid';
		// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
				+ 'px';
		element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
				+ 'px';
	}
</script>
</html>