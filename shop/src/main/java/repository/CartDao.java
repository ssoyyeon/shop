package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class CartDao {
	private DBUtil dbUtil = new DBUtil();

	// 장바구니 리스트
	public List<Map<String, Object>> selectCartList(Connection conn, String customerId)
			throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 객체
		List<Map<String, Object>> list = new ArrayList<>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		this.dbUtil = new DBUtil();
		// 쿼리
		String sql = "SELECT goods_no goodsNo, customer_id customerId, cart_quantity cartQuantity, update_date updateDate, create_date createDate"
				+ " FROM cart WHERE customer_id = ? ";

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CartDao - selectCartList DB 연결");
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 쿼리값 설정
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("CartDao - selectCartList - stmt : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("customerId", customerId);
				map.put("cartQuantity", rs.getInt("cartQuantity"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				list.add(map);
				// 디버깅
				System.out.println("CartDao - selectCartList - list : " + list);
			}
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
		return list;
	} // end selectCartList

	// 장바구니 상픔1 상세보기
	public Cart selectCartOne(Connection conn, Cart cart) throws ClassNotFoundException, SQLException{
		// 리턴값 반환할 변수
		Cart selectCart = null;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		this.dbUtil = new DBUtil();
		// 쿼리
		String sql = "SELECT goods_no goodsNo, customer_id customerId,"
				+ " cart_quantity cartQuantity, update_date updateDate, create_date createDate"
				+ " FROM cart WHERE customer_id = ? AND goods_no = ? ";

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CartDao - selectCartOne DB 연결");
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 쿼리값 설정
			stmt.setString(1, cart.getCustomerId());
			stmt.setInt(2, cart.getGoodsNo());
			// 디버깅
			System.out.println("CartDao - selectCartOne - stmt : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				selectCart = new Cart();
				selectCart.setCartQuantity(rs.getInt("cartQuantity"));
				selectCart.setCreateDate(rs.getString("createDate"));
				selectCart.setCustomerId(rs.getString("customerId"));
				selectCart.setGoodsNo(rs.getInt("goodsNo"));
				selectCart.setUpdateDate(rs.getString("updateDate"));
			}
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
		return selectCart;
	} // end selectCartOne
	
	// 장바구니 추가
	public int insertCartList(Connection conn, Cart cart) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 변수
		int cartList = 0;
		// DB 자원
		PreparedStatement stmt = null;
		this.dbUtil = new DBUtil();
		// 쿼리
		String sql = "INSERT INTO cart (goods_no, customer_id, cart_quantity, update_date, create_date) "
				+ "VALUES (?, ?, ?, now(), now())";

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CartDao - insertCartList DB 연결");
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 쿼리값 설정
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			
			// 쿼리 실행
			cartList = stmt.executeUpdate();
			// 디버깅
			System.out.println("CartDao - insertCartList - stmt : " + stmt);
		} finally {
			// DB 자원해제
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return cartList;
	} // end insertCartList

	// 장바구니 수량 수정
	public int updateCartList(Connection conn, Cart cart) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 변수
		int cartList = 0;
		// DB 자원
		PreparedStatement stmt = null;
		this.dbUtil = new DBUtil();
		// 쿼리
		String sql = "UPDATE cart SET cart_quantity= ?, update_date = now() WHERE goods_no = ? AND  customer_id = ? ";

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CartDao - updatecartList DB 연결");
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 쿼리값 설정
			stmt.setInt(1, cart.getCartQuantity());
			stmt.setInt(2, cart.getGoodsNo());
			stmt.setString(3, cart.getCustomerId());
			
			// 쿼리 실행
			cartList = stmt.executeUpdate();
			// 디버깅
			System.out.println("CartDao - updatecartList - stmt : " + stmt);
		} finally {
			// DB 자원해제
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return cartList;
	} // end updatecartList

	// lastPage 페이지 구하기 메서드
	public int lastPage(Connection conn, final int ROW_PER_PAGE, String customerId)
			throws ClassNotFoundException, SQLException {
		int lastpage = 0;
		int totalRow = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM cart WHERE customer_id=?";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ?값 setter
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("OrdersDao - lastPage : " + stmt);

			// 전체 행의 수를 구하기 위한 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count(*)");
			}

			// 디버깅
			System.out.println("OrdersDao - totalRow  : " + totalRow);
			System.out.println("OrdersDao - ROW_PER_PAGE  : " + ROW_PER_PAGE);
			// 마지막 페이지
			lastpage = totalRow / ROW_PER_PAGE;
			// 페이지가 rowPerPage로 나눠떨어지지 않아도 페이지 구현을 위해 1개 추가
			if (totalRow % ROW_PER_PAGE != 0) {
				lastpage += 1;
			}

			// 디버깅
			System.out.println("OrdersDao - lastPage : " + lastpage);

		} finally {
			if (stmt != null) {
				stmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		}
		return lastpage;
	} // end lastPage
	
	// 장바구니 삭제
	public int deletecartList(Connection conn , int goodsNo, String customerId) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 변수
		int cartList = 0;
		// DB 자원
		PreparedStatement stmt = null;
		this.dbUtil = new DBUtil();
		// 쿼리
		String sql = "DELETE FROM cart WHERE goods_no = ? AND  customer_id = ? ";

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CartDao - deletecartList DB 연결");
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 쿼리값 설정
			stmt.setInt(1, goodsNo);
			stmt.setString(2, customerId);
			
			// 쿼리 실행
			cartList = stmt.executeUpdate();
			// 디버깅
			System.out.println("CartDao - deletecartList - stmt : " + stmt);
			
		} finally {
			// DB 자원해제
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return cartList;
	} // end deletecartList
}
