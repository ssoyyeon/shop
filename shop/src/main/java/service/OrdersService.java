package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.OrdersDao;
import vo.Customer;
import vo.Orders;

public class OrdersService {
	private OrdersDao ordersDao;

	// 주문상세보기
	public Map<String, Object> selectOrdersOne(int ordersNo) {
		Map<String, Object> list = new HashMap<>();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("selectOrdersList - DB 연결");
			// 자동 commit 막기
			conn.setAutoCommit(false);

			this.ordersDao = new OrdersDao();
			list = ordersDao.selectOrdersOne(conn, ordersNo);

			conn.commit();
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
	} // end selectOrdersOne
		
	// 관리자용 주문 리스트
	public List<Map<String, Object>> selectOrdersList(int rowPerPage, int currentPage)
			throws ClassNotFoundException, SQLException {
		// 리턴값을 반환할 객체
		List<Map<String, Object>> list = null;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService selectOrdersList - DB 연결");

			// 시작페이지
			int beginRow = (currentPage - 1) * rowPerPage;

			// 객체 생성 후 Dao 메서드 호출
			this.ordersDao = new OrdersDao();
			// 주문 리스트 호출
			list = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			System.out.println(list);

			// 디버깅
			System.out.println("currentPage : " + currentPage);
			System.out.println("beginRow : " + beginRow);
			System.out.println("rowPerPage : " + rowPerPage);

			// 주문내역 출력 실패시 오류 생성
			if (list == null) {
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
	} // end selectOrdersList

	// 관리자 주문 수정하기
	public int updateOrdersList(Map<String, Object> map) {
		// 리턴값을 반환할 객체
		int updateOrders = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService - updateOrdersList - DB 연결");

			// 자동커밋 방지
			conn.setAutoCommit(false);

			// 객체 생성 후 Dao 메서드 호출
			this.ordersDao = new OrdersDao();
			// 주문 리스트 호출
			updateOrders = ordersDao.updateOrdersList(conn, map);

			// 주문상태 변경 실패시 오류 생성
			if (updateOrders == 0) {
				throw new Exception();
			}

			// 업데이트 저장
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				// 다시 돌아가기
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
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
		return updateOrders;
	} // end updateOrdersList

	// 2-1) 고객 한명의 주문 목록(관리자, 고객)
	public List<Map<String, Object>> selectOrdersListByCustomer(String customerId) {
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
			System.out.println("OrdersService - selectOrdersListByCustomer - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.ordersDao = new OrdersDao();
			// 주문 리스트 호출
			list = ordersDao.selectOrdersListByCustomer(conn, customerId);

			// 디버깅
			if (list == null) {
				throw new Exception();
			}
			// 디버깅
			System.out.println("selectOrdersListByCustomer - customerId : " + customerId);
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

	}

	// lastPage 구하기
	public int lastPage(int currentPage, final int ROW_PER_PAGE) {
		// 리턴값을 반환하기 위한 변수
		int lastpage = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			OrdersDao ordersDao = new OrdersDao();

			// lastPage 구하는 메서드 호출
			lastpage = ordersDao.lastPage(conn, ROW_PER_PAGE);

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

	// 고객1 주문 수정하기
	public int modifyCustomerOrder(int orderNo, int orderQuantity) {
		// 리턴값을 반환하기 위한 변수
		int modifyCustomerOrders = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService - modifyCustomerOrder - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.ordersDao = new OrdersDao();
			// 주문 리스트 호출
			modifyCustomerOrders = ordersDao.updateCustomerOrder(conn, orderNo, orderQuantity);

			// 디버깅
			if (modifyCustomerOrders == 0) {
				// 수정 실패시 오류 생성
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
		return modifyCustomerOrders;
	} // end modifyCustomerOrder

	// 고객1 주문 취소하기
	public int removeCustomerOrder(int orderNo) throws ClassNotFoundException, SQLException {
		// 리턴값을 반환하기 위한 변수
		int removeCustomerOrders = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService - removeCustomerOrder - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.ordersDao = new OrdersDao();
			// 주문 취소 메서드 호출
			removeCustomerOrders = ordersDao.deleteCustomerOrder(conn, orderNo);

			// 디버깅
			if (removeCustomerOrders == 0) {
				// 삭제 실패시 오류 생성
				throw new Exception();
			}
			// 디버깅
			System.out.println("removeCustomerOrder - orderNo : " + orderNo);
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
		return removeCustomerOrders;
	} // removeCustomerOrder

	// 상품 주문하기
	public int insertCustomerOrders(Orders order) {
		// 리턴값을 반환하기 위한 변수
		int insertCustomerOrders = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService - insertCustomerOrders - DB 연결");

			// 객체 생성 후 Dao 메서드 호출
			this.ordersDao = new OrdersDao();
			// 주문 리스트 호출
			insertCustomerOrders = ordersDao.insertCustomerOrders(conn, order);
			// 디버깅
			if (insertCustomerOrders == 0) {
				// 주문 실패시 오류 생성
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
		return insertCustomerOrders;
	} // end insertCustomerOrders
} // end removeCustomerOrder
