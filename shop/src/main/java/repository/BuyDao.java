package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class BuyDao {

	// 구매할 주문 리스트 조회
	public List<Map<String, Object>> selectBuyByCartList(Connection conn, List<Cart> cartList)
			throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 객체
		List<Map<String, Object>> list = null;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		// 쿼리
		String sql = "SELECT c.goods_no goodsNo, c.cart_quantity cartQuantity, g.goods_price goodsPrice, goods_name goodsName"
				+ " FROM cart c INNER JOIN goods g USING(goods_no) WHERE customer_id = ?  AND goods_no = ?";

		// 디버깅
		System.out.println("BuyDao - selectBuyByCartList 메서드 들어옴11 -------");
		
		// 카트에 들어가 있는 수만큼 리스트 추출
		for (Cart cart : cartList) {
			try {
				// 디버깅
				System.out.println("BuyDao - selectBuyByCartList 메서드 들어옴222 -------");
				// DB 연결
				conn = dbUtil.getConnection();
				// 디버깅
				System.out.println("BuyDao - selectBuyList DB 연결");
				// 쿼리 담기
				stmt = conn.prepareStatement(sql);
				// ?값 설정
				stmt.setString(1, cart.getCustomerId());
				stmt.setInt(2, cart.getGoodsNo());
				// 디버깅
				System.out.println("BuyDao - selectBuyList - stmt : " + stmt);

				// 쿼리 실행
				rs = stmt.executeQuery();

				// list에 값 담기
				while (rs.next()) {
					// 값 설정할 객체 생성
					Map<String, Object> map = new HashMap<>();

					map.put("goodsNo", rs.getInt("goodsNo"));
					map.put("cartQuantity", rs.getInt("cartQuantity"));
					map.put("goodsPrice", rs.getString("goodsPrice"));
					map.put("goodsName", rs.getString("goodsName"));

					list.add(map);
				}
				// 디버깅
				System.out.println("BuyDao - selectBuyList - list : " + list);

			} finally {
				// DB 자원해제
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (stmt != null) {
					try {
						stmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return list;
	} // end selectCartList

}
