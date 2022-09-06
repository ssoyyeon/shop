<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	// 디버깅
	System.out.println("addNoticeAction - noticeTitle : " + noticeTitle);
	System.out.println("addNoticeAction - noticeContent : " + noticeContent);
	
	// 값 넘겨주기
	Notice paranotice = new Notice();
	paranotice.setNoticeTitle(noticeTitle);
	paranotice.setNoticeContent(noticeContent);
	
	// 추가하기 메서드 호출 
	NoticeService noticeService = new NoticeService();
	int notice = noticeService.insertNotice(paranotice);
			
	if (notice != 0) {
		System.out.println("게시판 삭제 성공");
		response.sendRedirect(request.getContextPath() + "/noticeList.jsp");
	}
%>