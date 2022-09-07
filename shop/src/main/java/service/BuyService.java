package service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import repository.BuyDao;
import repository.DBUtil;
import vo.Cart;

public class BuyService {

	// 구매할 주문 리스트 조회
	public List<Map<String, Object>> getBuyByCartList(List<Cart> cartList) {
		// 리턴값 반환할 객체
		List<Map<String, Object>> list = null;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("BuyService - getBuyList - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			BuyDao buyDao = new BuyDao();
			// 주문 리스트 호출
			list = buyDao.selectBuyByCartList(conn, cartList);

			// 디버깅
			if (list == null) {
				// 주문 리스트 호출 실패시 오류 생성
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		return list;
	} // end getBuyList
}
