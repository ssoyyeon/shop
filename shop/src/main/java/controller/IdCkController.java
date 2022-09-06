package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class IdCkController extends HttpServlet {
	private SignService signService;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 인코딩
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		// 클라이언트에 전송할 데이터 종류 설정
		response.setContentType("application/json");
		
		
		// 요청값 처리
		String idck = request.getParameter("idck");
		//디버깅
	    System.out.println("doPost - idck : " + idck );
	    
	    // SignService 객체 생성 후 id에 signService 리턴값 넣기
	 	this.signService = new SignService();
	    boolean id = this.signService.idCheck(idck);
	    // 디버깅
		System.out.println("doPost - id : " + id);
	    
	    // Gson : json 구조 java 객체
	    Gson gson = new Gson();
	    String jsonStr = "";
	    
	    if(id == true) {
	    	jsonStr = "yes";
	    }else {
	    	jsonStr = "no";
	    }
	    
	    jsonStr = gson.toJson(jsonStr);
	    
	    PrintWriter out = response.getWriter();
	    out.write(jsonStr);
	    out.flush(); // 비움
	    out.close(); // 닫음

	} // end doPost
} // end IdCkController
