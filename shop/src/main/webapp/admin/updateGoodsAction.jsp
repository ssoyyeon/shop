<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="service.GoodsService"%>
<%@ page import="vo.Goods"%>
<%@ page import="vo.GoodsImg"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 디버깅
	System.out.println("\n-------------------------------updateGoodsAction start-------------------------------------------\n");
	// cos 라이브러리 사용하기
	String dir = request.getServletContext().getRealPath("/upload");
	// 디버깅
	System.out.println("addGoodsAction.jsp dir : " + dir);
	
	// 파일사이즈 (용량)
	int max = 10 * 1024 * 1024; // 1024byte -> 1kbyte, 1024kbyte -> 1mbyte
	
	// 원래 request에 래핑 (request, 경로, 파일사이즈, 인코딩, 이름재설정)
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "UTF-8", new DefaultFileRenamePolicy());
	
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 상품정보 변경 요청값 처리
	int goodsNo = Integer.parseInt(mRequest.getParameter("goodsNo"));
	String goodsName = mRequest.getParameter("goodsName");
	String goodsPrice = mRequest.getParameter("goodsPrice");
	String soldOut = mRequest.getParameter("soldOut");
	// 디버깅
	System.out.println("updateGoodsAction - goodsNo : " + goodsNo);
	System.out.println("updateGoodsAction - goodsName : " + goodsName);
	System.out.println("updateGoodsAction - goodsPrice : " + goodsPrice);
	System.out.println("updateGoodsAction - soldOut : " + soldOut);
	
	// 이미지 변경 요청값
	String contentType = mRequest.getContentType("imgFile");
	String originFilename = mRequest.getOriginalFileName("originFilename");
	String filename = mRequest.getFilesystemName("imgFile");
	// 디버깅
	System.out.println("updateGoodsAction - originFilename : " + originFilename);
	System.out.println("updateGoodsAction - filename : " + filename);
	System.out.println("updateGoodsAction - contentType : " + contentType);
	
	// 상품 객체에 담기
	Goods goods = new Goods();
	// goods setter
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	// 디버깅
	System.out.println("updateGoodsAction - goods : " + goods);
	
	
	// 메서드실행
	GoodsService goodsService = new GoodsService();
	// goodsService.modifyGoods(goods, goodsImg);
	goodsService.modifyGoods(goods);

	// 수정 후 페이지 재요청
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	// 디버깅
	System.out.println("\n-------------------------------updateGoodsAction end-------------------------------------------\n");
%>