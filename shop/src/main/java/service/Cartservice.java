package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import repository.CartDao;
import repository.DBUtil;
import vo.Cart;

public class Cartservice {
	private CartDao cartDao;

	// 장바구니 리스트
	public List<Map<String, Object>> selectCartList(String customerId) {
		// 리턴값을 반환할 객체
		List<Map<String, Object>> list = new ArrayList<>();
		;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("Cartservice - selectCartList - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.cartDao = new CartDao();
			// 주문 리스트 호출
			list = cartDao.selectCartList(conn, customerId);

			// 디버깅
			if (list == null) {
				// 주문 리스트 호출 실패시 오류 생성
				throw new Exception();
			}
			// 디버깅
			System.out.println("Cartservice - selectCartList - customerId : " + customerId);
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
	} // end CartLsit

	// lastPage 구하기
	public int lastPage(int currentPage, final int ROW_PER_PAGE, String customerId) {
		int lastpage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			this.cartDao = new CartDao();

			// lastPage 구하는 메서드 호출
			lastpage = cartDao.lastPage(conn, ROW_PER_PAGE, customerId);

			// lastPage 실패시 오류 생성
			if (lastpage == 0) {
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
		} // end finally

		return lastpage;
	} // end lastPage

	// 장바구니 수량 수정
	public int modifyCartList(Cart cart) {
		// 리턴값 반환할 변수
		int modifyCart = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("Cartservice - modifycartList - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.cartDao = new CartDao();
			// 주문 리스트 호출
			modifyCart = cartDao.updateCartList(conn, cart);
			// 디버깅
			System.out.println("Cartservice - modifycartList - cart : " + cart);

			// 디버깅
			if (modifyCart == 0) {
				// 수량 수정 실패시 오류 생성
				System.out.println(" 수량 수정 실패 오류 발생");
				throw new Exception();
			}
			// 디버깅
			System.out.println("Cartservice - modifycartList - modifyCart : " + modifyCart);
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
		return modifyCart;
	} // end modifycartList

	// 장바구니 상픔1 상세보기
	public Cart selectCartOne(Cart cart) {
		// 리턴값 반환할 변수
		Cart selectCart = null;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("Cartservice - selectCartOne - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.cartDao = new CartDao();

			// 주문 리스트 호출
			selectCart = cartDao.selectCartOne(conn, cart);

			// 디버깅
			if (selectCart == null) {
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
		return selectCart;
	} // end selectCartOne
	
	// 장바구니 삭제
	public int removecartList(int goodsNo, String customerId) {
		// 리턴값 반환할 변수
		int removeCart = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("Cartservice - removecartList - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.cartDao = new CartDao();
			
			// 디버깅
			System.out.println("Cartservice - removecartList - goodsNo : " + goodsNo);
			System.out.println("Cartservice - removecartList - customerId : " + customerId);

			// 장바구니 삭제 메서드 호출
			removeCart = cartDao.deletecartList(conn,  goodsNo, customerId);
			
			// 디버깅
			if (removeCart == 0) {
				// 수량 수정 실패시 오류 생성
				System.out.println(" 장바구니 삭제 실패 오류 발생");
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
		return removeCart;
	} // end deletecartList
	
	// 장바구니 추가
	public int addcartList(Cart cart) {
		// 리턴값 반환할 변수
		int addCart = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("Cartservice - addcartList - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.cartDao = new CartDao();

			// 주문 리스트 호출
			addCart = cartDao.insertCartList(conn, cart);
			
			// 디버깅
			System.out.println("Cartservice - addcartList - addCart : " + addCart);
			
			// 디버깅
			if (addCart == 0) {
				// 수량 수정 실패시 오류 생성
				System.out.println(" 장바구니 추가 실패 오류 발생");
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
		return addCart;
	} // end addcartList
}
