<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 디버깅
System.out.println(
		"\n----------------------------------customerReivewList - start -------------------------------------\n");

//로그인 전이거나 고객이 아니면 로그인 페이지로 돌아가기
if (session.getAttribute("id") == null || !(session.getAttribute("user").equals("Customer"))) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
//디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
String customerId = ((String) session.getAttribute("id"));
// 디버깅
System.out.println("customerReivewList - customerId : " + customerId);

// 쿼리 실행을 위한 객체 생성
ReviewService reviewService = new ReviewService();

// 고객 1인 리뷰 list = 모델값
List<Map<String, Object>> list = new ArrayList<>();
list = reviewService.getReviewListById(customerId);
// 리뷰 조회 성공 시 디버깅
if (list != null) {
	System.out.println("고객 1인 리뷰 list 조회 성공");
}
// 디버깅
System.out.println(
		"\n----------------------------------customerReivewList - end --------------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- 분리하면 servlet / 연계기술 forword(request, response) / jsp -->
<!-- 모델값을 전달하기 위한 것, 객체로 전달 request.setAttribute( )   -> request가 끝나면 같이 사라짐 -->
<!--  view : 태그 -->

<!-- for/ if 대체 기술 -> 커스텀 태그(JSTL & EL) JSP -->
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 로그인이 되어있지 않으면 리뷰리스트 보여주지 않음 -->
		<%
		// 리뷰가 비었다면
		if (session.getAttribute("id") == null || list.isEmpty()) {
		%>
		<div class="col-lg-12"
			style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">
			<h2 style="font-size: 40px; margin-top: 5%; height: 213px;">
				<b>리뷰가 없습니다.</b>
			</h2>
			<a href="<%=request.getContextPath()%>/main.jsp"
				style="margin-bottom: 5%;">
				<button type="button" class="btn btn-dark"
					style="margin-bottom: 5%;">홈으로 가기</button>
			</a>
		</div>
		<%
		} else {
		%>
		<!-- 메인페이지 -->
		<div class="col-lg-12"
			style="margin-bottom: 6%; margin-top: 5%; background-color: #E9EDF1;">
			<h2
				style="font-size: 40px; text-align: center; margin-top: 5%; margin-bottom: 5%;">
				<strong><%=customerId%>'s ReviewList</strong>
			</h2>
			<hr>
			<table class="table table-hover table-striped"
				style="text-align: center;">
				<thead>
					<tr>
						<th><b>orderNo</b></th>
						<th><b>goodsNo</b></th>
						<th><b>reviewContent</b></th>
						<th><b>createDate </b></th>
						<th><b>updateDate </b></th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<td><a
							href="<%=request.getContextPath()%>/customer/customerOrdersOne.jsp?orderNo=<%=o.get("orderNo")%>&goodsNo=<%=o.get("goodsNo")%>">
								<%=o.get("orderNo")%>
						</a></td>
						<td><%=o.get("goodsNo")%></td>
						<td><%=o.get("reviewContent")%></td>
						<td><%=o.get("createDate")%></td>
						<td><%=o.get("updateDate")%></td>
						<td><a
							href="<%=request.getContextPath()%>/customer/updateReviewForm.jsp?orderNo=<%=o.get("orderNo")%>&goodsNo=<%=o.get("goodsNo")%>">
								<button type="submit" class="btn"
									style="background-color: black; color: white;">Modify</button>
						</a><a
							href="<%=request.getContextPath()%>/customer/deleteReviewAction.jsp?orderNo=<%=o.get("orderNo")%>&goodsNo=<%=o.get("goodsNo")%>">
								<button type="submit" class="btn"
									style="background-color: black; color: white;">Delete</button>
						</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<%
		}
		%>
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>