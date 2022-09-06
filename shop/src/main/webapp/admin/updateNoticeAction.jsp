<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\nupdateNoticeAction");
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	//요청값 처리
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	//디버깅
	System.out.println("updateNoticeAction - noticeNo : " + noticeNo);
	
	// 넘겨받은 값 setter
	Notice paraNotice = new Notice();
	paraNotice.setNoticeNo(noticeNo);
	paraNotice.setNoticeTitle(request.getParameter("noticeTitle"));
	paraNotice.setNoticeContent(request.getParameter("noticeContent"));
	//디버깅
	System.out.println("updateNoticeAction -  : paraNotice " + paraNotice);
		
	//상세보기 메서드 호출 
	NoticeService noticeService = new NoticeService();
	int notice = noticeService.updateNotice(paraNotice);
	
	if (notice != 0) {
		System.out.println("공지사항 수정 성공");
		response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
	}
%>