<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 디버깅
System.out.println("\n----------------------------------reivewListByEmployee - start ---------------------------------\n");

//admin이 아닐 경우 접속 불가
if (session.getAttribute("id") == null || ((String) session.getAttribute("user")).equals("customer")) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
	return;
}
// active가 Y이 아니면 접속 불가
if (!session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
	return;
}
// 디버깅
System.out.println("id : " + session.getAttribute("id"));
System.out.println("user : " + session.getAttribute("user"));
System.out.println("active : " + session.getAttribute("active"));

// 인코딩
request.setCharacterEncoding("utf-8");

// 요청값 처리
String customerId = ((String) session.getAttribute("id"));
// 디버깅
System.out.println("reivewListByEmployee - customerId : " + customerId);

// 현재 페이지 구하기
int currentPage = 1;
// 받아오는 페이지가 있을 경우
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
// 디버깅
System.out.println("reivewListByEmployee - currentPage : " + currentPage);

// 페이지 당 보여질 행 갯수
final int ROW_PER_PAGE = 10;

// 쿼리 실행을 위한 객체 생성
ReviewService reviewService = new ReviewService();

// lastPage 구하는 메서드 호출
int lastPage = reviewService.lastPage(ROW_PER_PAGE);
// 디버깅
System.out.println("reivewListByEmployee - lastPage : " + lastPage);

// 전체 리뷰 list = 모델값
List<Map<String, Object>> list = new ArrayList<>();
list = reviewService.getReviewList(currentPage, ROW_PER_PAGE);
// 리뷰 조회 성공 시 디버깅
if (list != null) {
	System.out.println("고객 전체 리뷰 list 조회 성공");
}
// 디버깅
System.out.println("\n----------------------------------reivewListByEmployee - end ---------------------------------\n");
%>
<%@ include file="/inc/header.jsp"%>
<!-- 분리하면 servlet / 연계기술 forword(request, response) / jsp -->
<!-- 모델값을 전달하기 위한 것, 객체로 전달 request.setAttribute( )   -> request가 끝나면 같이 사라짐 -->
<!--  view : 태그 -->

<!-- for/ if 대체 기술 -> 커스텀 태그(JSTL & EL) JSP -->
<!-- 메인내용 -->
<div class="container">
	<div class="row">
		<!-- 메인페이지 -->
		<div class="col-lg-12" style="margin-bottom: 6%; margin-top: 5%; background-color: #E9EDF1;">
			<h2 style="font-size: 40px; text-align: center; margin-top: 5%; margin-bottom: 5%;">
				<strong>Total ReviewList</strong>
			</h2>
			<hr>
			<table class="table table-hover table-striped" style="text-align: center;">
				<thead>
					<tr>
						<th><b>orderNo</b></th>
						<th><b>goodsNo</b></th>
						<th><b>reviewContent</b></th>
						<th><b>customerId</b></th>
						<th><b>createDate </b></th>
						<th><b>updateDate </b></th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> o : list) {
					%>
					<tr>
						<%
						// 주문한 상품이 없는 경우
						if (list == null) {
						%>
						<td style="font-size: 30px; margin-top: 10%;">주문한 상품이 없습니다.</td>
						<%
						}
						%>
						<td><%=o.get("orderNo")%>
						</td>
						<td><a href="<%=request.getContextPath()%>/admin/adminGoodsOne.jsp?goodsNo=<%=o.get("goodsNo")%>"> <%=o.get("goodsNo")%></a></td>
						<td><%=o.get("reviewContent")%></td>
						<td><a href="<%=request.getContextPath()%>/admin/customerOrderOne.jsp?customerId=<%=o.get("customerId")%>"><%=o.get("customerId")%></a></td>
						<td><%=o.get("createDate")%></td>
						<td><%=o.get("updateDate")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div><!-- OrderList end -->
				<!-- 페이징 -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<div class="container" style="text-align: center; margin-top: 5%;">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/reviewListByEmployee.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary">Pre</button>
			</a>
			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/reviewListByEmployee.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary" disabled="disabled">Pre</button>
			</a>
			<%
			}
			if (currentPage < lastPage) {
			// 디버깅
			System.out.println("lastPage : " + lastPage);
			System.out.println("currentPage : " + currentPage);
			%>
			<a
				href="<%=request.getContextPath()%>/admin/reviewListByEmployee.jsp?currentPage=<%=currentPage + 1%>">
				<button type="submit" class="btn btn-dark">Next</button>
			</a>

			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/reviewListByEmployee.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
			</a>
			<%
			}
			%>
		</div>
		<!--  end 페이징 -->
	</div>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>