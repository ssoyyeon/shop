<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//디버깅
System.out.println("\n----------------------------------goodsListSearchAction - end---------------------------------");
//인코딩
request.setCharacterEncoding("utf-8");

//한 페이지당 게시물 수
int rowPerPage = 20;
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
}

//현재페이지
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}


// 검색어 받아오기
String word = null;
//받아오는 GoodsListSort 값이 있다면 
if (request.getParameter("word") != null) {
	word = request.getParameter("word");
}

//디버깅
System.out.println("word : " + word);

//쿼리 실행을 위한 객체 생성
GoodsService goodsService = new GoodsService();

//검색어로 상품 검색
List<Map<String, Object>> searchList = null;
searchList = goodsService.selectCutomerGoodsListBySearch(rowPerPage, currentPage, word);

//페이징 마지막 페이지 메서드 호출
int lastPage = goodsService.lastPage(rowPerPage);

if(searchList != null){
	System.out.println("검색어로 상픔 보기 성공");
	response.sendRedirect(request.getContextPath()+"/customer/customerGoodsList.jsp?word="+word);
}

//디버깅
System.out.println("----------------------------------goodsListSearchAction - end---------------------------------\n");
%>