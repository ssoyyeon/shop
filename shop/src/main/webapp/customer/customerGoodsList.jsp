<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.GoodsService"%>
<%
//디버깅
System.out.println("\n----------------------------------customerGoodsList- start ------------------------------------------\n");
//인코딩
request.setCharacterEncoding("utf-8");

// 한 페이지당 게시물 수
int rowPerPage = 20;
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
}

// 현재페이지
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

//상품 정렬 분기
String goodsListSort = "Nothing";
//받아오는 GoodsListSort 값이 있다면 
if (request.getParameter("goodsListSort") != null) {
	goodsListSort = request.getParameter("goodsListSort");
}
//디버깅
System.out.println("GoodsListSort : " + goodsListSort);

// 상품 카테고리 정렬 분기
String category = null;
//받아오는 category 값이 있다면 
if (request.getParameter("category") != null) {
	category = request.getParameter("category");
}
//디버깅
System.out.println("category : " + category);

// 상품 카테고리 세분화 정렬 분기
String kind = null;
//받아오는 kindt 값이 있다면 
if (request.getParameter("kind") != null) {
	kind = request.getParameter("kind");
}
//디버깅
System.out.println("kind : " + kind);

// 쿼리 실행을 위한 객체 생성
GoodsService goodsService = new GoodsService();

// 고객 상품 리스트 list = 모델값
List<Map<String, Object>> list = null;
list = goodsService.selectCutomerGoodsListByPage(rowPerPage, currentPage, goodsListSort, category, kind);

// 페이징 마지막 페이지 메서드 호출
int lastPage = goodsService.lastPage(rowPerPage, currentPage);

//디버깅
System.out.println("\n----------------------------------customerGoodsList- end ------------------------------------------\n");
%>
<!-- 분리하면 servlet / 연계기술 forword(request, response) / jsp -->
<!-- 모델값을 전달하기 위한 것, 객체로 전달 request.setAttribute( )   -> request가 끝나면 같이 사라짐 -->
<!--  view : 태그 -->

<!-- for/ if 대체 기술 -> 커스텀 태그(JSTL & EL) JSP -->
<%@ include file="/inc/header.jsp"%>
<!-- Start Shop Page  -->
<div class="shop-box-inner">
	<div class="container" style="max-width: 55%;">
		<div class="row">
			<!--  start sidebar -->
			<div class="col-xl-3 col-lg-3 col-sm-12 col-xs-12 sidebar-shop-left">
				<div class="product-categori">
					<div class="filter-sidebar-left">
						<div class="title-left">
							<h3 style="font-size: 20px; text-align: center;">Categories</h3>
						</div>
						<div class="list-group list-group-collapse list-group-sm list-group-tree"
							id="list-group-men" data-children=".sub-men">
							<div class="list-group-collapse sub-men">
								<a class="list-group-item list-group-item-action"
									href="#sub-men1" data-toggle="collapse" aria-expanded="true"
									aria-controls="sub-men1"> Clothing 
								</a>
								<div class="collapse show" id="sub-men1"
									data-parent="#list-group-men">
									<div class="list-group">
										<a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&category=<%=category%>&kind=<%=kind%>"
											class="list-group-item list-group-item-action active">All Clothing
										</a> 
										<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=top"
											class="list-group-item list-group-item-action">Top &
											T-shirt
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=jersey"
											class="list-group-item list-group-item-action">Jersey 
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=pants"
											class="list-group-item list-group-item-action">Pants 
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=ck"
											class="list-group-item list-group-item-action">Socks</a>
									</div>
								</div>
							</div>
							<div class="list-group-collapse sub-men">
								<a class="list-group-item list-group-item-action"
									href="#sub-men2"
									data-toggle="collapse" aria-expanded="true"
									aria-controls="sub-men2">Shoes 
								</a>
								<div class="collapse show" id="sub-men2"
									data-parent="#list-group-men">
									<div class="list-group">
										<a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=shoes"
											class="list-group-item list-group-item-action active">
											All Shoes
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=running"
											class="list-group-item list-group-item-action"> Running
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=sports"
											class="list-group-item list-group-item-action"> Training
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=walking"
											class="list-group-item list-group-item-action"> Walking
										</a> <a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=sandals"
											class="list-group-item list-group-item-action"> Sandals
										</a>
									</div>
								</div>
							</div>
							<div class="list-group-collapse sub-men">
								<a class="list-group-item list-group-item-action"
									href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=<%=goodsListSort%>&kind=<%=kind%>&category=bags">Bags 
								</a>
							</div>
						</div>
					</div>
					<hr style="border:1px solid; color:black;">
				</div>
			</div>
			<!--  end side bar -->
			<!--  end side bar -->
			<!--  end side bar -->

			<!-- start GoodsList -->
			<!-- start GoodsList -->
			<!-- start GoodsList -->
			<div class="col-xl-9 col-lg-9 col-sm-12 col-xs-12 shop-content-right"
				style="background-color: #dee2e6; text-align: center;">
				<div class="right-product-box"
					style="margin-top: 1%; margin-right: 1%;">
					<div class="product-item-filter row">
						<div class="col-12 col-sm-8 text-center text-sm-left">
							<div class="toolbar-sorter-right"
								style="background-color: white; width: 130%;">
								<div class="dropdown active"
									style="background-color: black; color: white; font-size: large;">
									<a href="#" class="nav-link dropdown-toggle arrow"
										data-toggle="dropdown"><b style="color: white;">Sort
											by</b></a>
									<ul class="dropdown-menu">
										<li><a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=Nothing&category=<%=category%>&kind=<%=kind%>">
												<b>Nothing</b>
										</a></li>
										<li><a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=Best&category=<%=category%>&kind=<%=kind%>">
												<b>Best Selling</b>
										</a></li>
										<li><a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=Latest&category=<%=category%>&kind=<%=kind%>">
												<b>Latest</b>
										</a></li>
										<li><a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=High&category=<%=category%>&kind=<%=kind%>">
												<b>High Price → Low Price</b>
										</a></li>
										<li><a
											href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?goodsListSort=Low&category=<%=category%>&kind=<%=kind%>">
												<b>Low Price → High Price</b>
										</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="col-12 col-sm-4 text-center text-sm-right">
							<ul class="nav nav-tabs ml-auto">
								<li><a class="nav-link active" href="#grid-view"
									data-toggle="tab"> <i class="fa fa-th"></i>
								</a></li>
								<li><a class="nav-link" href="#list-view" data-toggle="tab">
										<i class="fa fa-list-ul"></i>
								</a></li>
							</ul>
						</div>
					</div>
					<div
						class="col-xl-9 col-lg-9 col-sm-12 col-xs-12 shop-content-right">
						<table
							style="width: 135%; background-color: #E9EDF1; margin-bottom: 5%; margin-top: 5%;">
							<tr>
								<%
								int i = 1;
								for (Map<String, Object> m : list) {
								%>
								<td>
									<div>
										<a
											href="<%=request.getContextPath()%>/customer/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>">
											<img
											src='<%=request.getContextPath()%>/upload/<%=m.get("filename")%>'
											style="width: 170px; height: 150px; padding: 4%;">
										</a>
									</div>
									<div><%=m.get("goodsName")%></div>
									<div><%=m.get("goodsPrice")%></div> <!-- 품절 여부 --> <%
 if (m.get("soldOut").equals("Y")) {
 %>
									<div>
										<b style="color: red;">SoldOut</b>
									</div> <%
 }
 %>
								</td>
								<%
								if (i % 4 == 0) {
								%>
							</tr>
							<tr>
								<%
								}
								i++;
								}

								int tdCnt = 4 - (list.size() % 4);
								if (tdCnt == 4) {
								tdCnt = 0;
								}

								for (int j = 0; j < tdCnt; j++) {
								%>
								<td>&nbsp;</td>
								<%
								}
								%>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- end GoodsList -->
			<!-- end GoodsList -->
			<!-- end GoodsList -->

		</div>
		<!-- end row -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<div class="container"
			style="text-align: center; margin-top: 5%; margin-left: 24%;">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary">Pre</button>
			</a>
			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage - 1%>">
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
				href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage + 1%>">
				<button type="submit" class="btn btn-dark">Next</button>
			</a>

			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
			</a>
			<%
			}
			%>
		</div>
		<!--  end 페이징 -->
	</div>
</div>
<!-- End Shop Page -->

<%@ include file="/inc/footer.jsp"%>
</body>
</html>