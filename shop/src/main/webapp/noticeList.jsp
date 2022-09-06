<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@page import="java.util.*"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 한 페이지 당 보여질 게시물 수
	final int rowPerPage = 10;
	
	// 현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅
	System.out.println("NoticeList - currentPage : " + currentPage);
	
	// 메서드 호출을 위한 객체 생성
	NoticeService noticeService = new NoticeService();
	
	// 마지막 페이지 메서드 호출 
	int lastPage = noticeService.lastPage(rowPerPage, currentPage);
	// 디버깅
	System.out.println("NoticeList - lastPage : " + lastPage);
	
	// 공지사항 리스트 호출
	List<Map<String, Object>> list = new ArrayList<>();
	list = noticeService.selectNoticeList(rowPerPage, currentPage);
	// 디버깅
	System.out.println("NoticeList - list : " + list);
	
	if (list != null) {
		System.out.println("noticeList 출력 성공!");
	}
%>

<%@ include file="/inc/header.jsp"%>
<body>
	<div class="container">
		<div class="row">
			<!-- 메인페이지 -->
			<div class="col-lg-12"
				style="margin-top: 10%; background-color: #E9EDF1; text-align: center;">

				<h2 style="font-size: 40px; margin-top: 5%;">
					<b>NOTICE LIST</b>
				</h2>
				<%
				//admin이 아닐 경우 공지사항 추가 접속 불가
				if (session.getAttribute("id") != null && session.getAttribute("user").equals("Employee")
						&& session.getAttribute("active").equals("Y")) {
				%>

				<p>
					<a href="<%=request.getContextPath()%>/admin/addNoticeForm.jsp">
						<button type="submit" class="btn btn-success"
							style="float: right; margin-bottom: 3%; margin-right: 5%;">Add
							Notice</button>
					</a>
				</p>
				<%
				}
				%>

				<table class="table table-striped">
					<thead class="thead-light">
						<tr>
							<th><b>NoticeNo</b></th>
							<th><b>NoticeTitle</b></th>
							<th><b>CreateDate</b></th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Map<String, Object> n : list) {
						%>
						<tr>
							<td><%=n.get("noticeNo")%></td>
							<td><a
								href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=n.get("noticeNo")%>&employeeId=<%=session.getAttribute("id")%>">
									<%=n.get("noticeTitle")%>
							</a></td>
							<td><%=n.get("createDate")%></td>
						</tr>
						<%
						}
						%>

					</tbody>
				</table>
				<br> <br>
			</div>
		</div>
		<!--  end row -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<!-- 페이징 -->
		<div class="container" style="text-align: center; margin-top: 5%;">
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%=currentPage - 1%>">
				<button type="submit" class="btn btn-secondary">Pre</button>
			</a>
			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%=currentPage - 1%>">
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
				href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%=currentPage + 1%>">
				<button type="submit" class="btn btn-dark">Next</button>
			</a>

			<%
			} else {
			%>
			<a
				href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%=currentPage%>">
				<button type="submit" class="btn btn-dark" disabled="disabled">Next</button>
			</a>
			<%
			}
			%>
		</div>
		<!--  end 페이징 -->
	</div>
	<!-- end container -->
	<%@ include file="/inc/footer.jsp"%>
</body>
</html>