<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//디버깅
	System.out.println("\n------------------------------------ deleteNoticeAction - start ------------------------------------------------\n");

	// 요청값 처리
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 디버깅
	System.out.println("noticeNo : " + noticeNo);
	
	// 삭제하기 메서드 호출 
	NoticeService noticeService = new NoticeService();
	int notice = noticeService.deleteNotice(noticeNo);

	if (notice != 0) {
		System.out.println("게시판 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
	}
	//디버깅
	System.out.println("\n------------------------------------ deleteNoticeAction -  end ------------------------------------------------\n");
%>