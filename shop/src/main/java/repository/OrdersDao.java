package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Customer;
import vo.Orders;

public class OrdersDao {

	// 5-2) 주문상세보기
	public Map<String, Object> selectOrdersOne(Connection conn, int ordersNo)
			throws SQLException, ClassNotFoundException {
		// 리턴값 반환 객체
		Map<String, Object> map = null;
		// 쿼리 담을 객체
		PreparedStatement stmt = null;
		// 쿼리 실행 객체
		ResultSet rs = null;
		// DB 연결 객체
		DBUtil dbUtil = new DBUtil();
		// 실행할 쿼리
		String sql = "SELECT o.order_no ordersNo, o.create_date orderDate, o.order_price orderPrice , o.order_quantity orderQuantity,"
				+ " o.order_addr orderAddress, o.detail_addr detailAddress, o.order_state orderState, o.update_date updateDate,"
				+ " g.goods_no goodsNo , g.goods_name goodsName , c.customer_id customerId , gi.content_type orderImg" + " FROM orders o"
				+ " INNER JOIN goods g ON o.goods_no = g.goods_no"
				+ " INNER JOIN customer c ON o.customer_id = c.customer_id"
				+ " INNER JOIN goods_img gi ON g.goods_no = gi.goods_no" + " WHERE o.order_no = ?";
		/*
		 * SELECT o.order_no ordersNo, o.create_date createDate, o.order_price
		 * orderPrice , o.order_quantity orderQuantity, o.order_address orderAddress,
		 * o.order_state orderState, o.update_date updateDate, g.goods_no goodsNo ,
		 * c.customer_id , gi.content_type FROM orders o INNER JOIN goods g ON
		 * o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id =
		 * c.customer_id INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE
		 * o.order_no = 1;
		 */
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - selectOrdersOne DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setInt(1, ordersNo);
			// 디버깅
			System.out.println("OrdersDao - selectOrdersOne stmt : " + stmt);

			// 주문 상세보기 쿼리 실행
			rs = stmt.executeQuery();
			// 받아올 값 설정
			if (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("ordersNo", rs.getString("ordersNo"));
				map.put("detailAddress", rs.getString("detailAddress"));
				map.put("orderDate", rs.getString("orderDate"));
				map.put("orderPrice", rs.getString("orderPrice"));
				map.put("orderQuantity", rs.getString("orderQuantity"));
				map.put("goodsNo", rs.getString("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("orderState", rs.getString("orderState"));
				map.put("orderDate", rs.getString("orderDate"));
				map.put("orderPrice", rs.getString("orderPrice"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderAddress", rs.getString("orderAddress"));
				map.put("orderImg", rs.getString("orderImg"));
				// 디버깅
				System.out.println(map);
			}

			// 디버깅
			if (map != null) {
				System.out.println("OrdersDao - selectOrdersOne 성공");
			}

		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		}

		return map;
	} // end selectOrdersOne

	// 5-3) 고객 1 주문상세보기
	public Map<String, Object> ordersCustomerOne(Connection conn, String customerId)
			throws SQLException, ClassNotFoundException {
		// 리턴값 반환 객체
		Map<String, Object> map = null;
		// 쿼리 담을 객체
		PreparedStatement stmt = null;
		// 쿼리 실행 객체
		ResultSet rs = null;
		// DB 연결 객체
		DBUtil dbUtil = new DBUtil();
		// 실행할 쿼리
		String sql = "SELECT o.order_no ordersNo, o.create_date orderDate, o.order_price orderPrice , o.order_quantity orderQuantity,"
				+ " o.order_addr orderAddress, o.detail_addr detailAddress, o.order_state orderState, o.update_date updateDate,"
				+ " g.goods_no goodsNo , c.customer_id customerId , gi.content_type orderImg" + " FROM orders o"
				+ " INNER JOIN goods g ON o.goods_no = g.goods_no"
				+ " INNER JOIN customer c ON o.customer_id = c.customer_id"
				+ " INNER JOIN goods_img gi ON g.goods_no = gi.goods_no" + " WHERE c.customer_id = ?";
		/*
		 * SELECT o.order_no ordersNo, o.create_date createDate, o.order_price
		 * orderPrice , o.order_quantity orderQuantity, o.order_address orderAddress,
		 * o.order_state orderState, o.update_date updateDate, g.goods_no goodsNo ,
		 * c.customer_id , gi.content_type FROM orders o INNER JOIN goods g ON
		 * o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id =
		 * c.customer_id INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE
		 * o.order_no = 1;
		 */
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - ordersCustomerOne DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("OrdersDao - ordersCustomerOne stmt : " + stmt);

			// 주문 상세보기 쿼리 실행
			rs = stmt.executeQuery();
			// 받아올 값 설정
			while (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("ordersNo", rs.getString("ordersNo"));
				map.put("detailAddress", rs.getString("detailAddress"));
				map.put("orderDate", rs.getString("orderDate"));
				map.put("orderPrice", rs.getString("orderPrice"));
				map.put("orderQuantity", rs.getString("orderQuantity"));
				map.put("goodsNo", rs.getString("goodsNo"));
				map.put("orderState", rs.getString("orderState"));
				map.put("orderDate", rs.getString("orderDate"));
				map.put("orderPrice", rs.getString("orderPrice"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderAddress", rs.getString("orderAddress"));
				map.put("orderImg", rs.getString("orderImg"));
				// 디버깅
				System.out.println(map);
			}

			// 디버깅
			if (map != null) {
				System.out.println("OrdersDao - ordersCustomerOne 성공");
			}

		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		}

		return map;
	} // end ordersCustomerOne

	// lastPage 페이지 구하기 메서드
	public int lastPage(Connection conn, final int ROW_PER_PAGE) throws ClassNotFoundException, SQLException {
		int lastpage = 0;
		int totalRow = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM orders";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
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

	// 5-1) 전체 주문 목록(관리자)
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow)
			throws ClassNotFoundException, SQLException {
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT o.order_no orderNo, g.goods_no goodsNo, o.customer_id customerId, o.order_price orderPrice, "
				+ " o.order_addr orderAddress,  o.detail_addr detailAddress, o.order_quantity orderQuantity, o.order_state orderState, o.update_date updateDate, o.create_date createDate"
				+ " FROM orders o INNER JOIN goods g" + " ON o.goods_no = g.goods_no"
				+ " ORDER BY o.create_date DESC LIMIT ?, ?";

		System.out.println(sql);

		/*
		 * SELECT o.orders_no g.goods_no o.customerId o.orderPrice o.orderAddress
		 * o.orderQuantity o.orderState o.updateDate o.createDate FROM orders o INNER
		 * JOIN goods g ON o.goods_no = g.goods_no ORDER BY create_date DESC LIMIT ?, ?
		 */
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("selectOrdersList - DB 연결");
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("selectOrdersList - stmt : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();

			// 데이터 설정
			while (rs.next()) {
				Map<String, Object> orders = new HashMap<String, Object>();
				orders.put("customer_id", rs.getString("customerId"));
				orders.put("orders_no", rs.getInt("orderNo"));
				orders.put("goods_no", rs.getInt("goodsNo"));
				orders.put("order_address", rs.getString("orderAddress"));
				orders.put("detail_address", rs.getString("detailAddress"));
				orders.put("order_price", rs.getString("orderPrice"));
				orders.put("order_quantity", rs.getShort("orderQuantity"));
				orders.put("order_state", rs.getString("orderState"));
				orders.put("update_date", rs.getString("updateDate"));
				orders.put("create_date", rs.getString("createDate"));
				list.add(orders);
				// 디버깅
				System.out.println("selectOrdersList orders : " + orders);
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	} // end selectOrdersList

	// 2-1) 고객 한명의 주문 목록(관리자, 고객)
	public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId)
			throws SQLException, ClassNotFoundException {
		// 리턴값 주문 목록을 받아 올 객체
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT o.order_no orderNo, g.goods_no goodsNo, o.customer_id customerId, o.order_price orderPrice, "
				+ " o.order_addr orderAddress, o.detail_addr detailAddress, o.order_quantity orderQuantity, o.order_state orderState, o.update_date updateDate, o.create_date createDate"
				+ " FROM orders o INNER JOIN goods g" + " ON o.goods_no = g.goods_no WHERE customer_id = ?"
				+ " ORDER BY o.create_date DESC";
		/*
		 * SELECT o.order_no odersNo, g.goods_no goodsNo, o.customer_id customerId ,
		 * o.order_price orderPrice, o.order_address orderAddress, o.order_quantity
		 * orderQuantity, o.order_state orderState, o.update_date updateDate,
		 * o.create_date createDate FROM orders o INNER JOIN goods g ON o.goods_no =
		 * g.goods_no WHERE customer_id = ? ORDER BY o.create_date DESC LIMIT ?, ?
		 */
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("selectOrdersListByCustomer - DB 연결");
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("selectOrdersListByCustomer - stmt : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				// 값 설정할 객체
				Map<String, Object> map = new HashMap<>();
				map.put("orderNo", rs.getString("orderNo"));
				map.put("goodsNo", rs.getString("goodsNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderPrice", rs.getString("orderPrice"));
				map.put("orderAddress", rs.getString("orderAddress"));
				map.put("detailAddress", rs.getString("detailAddress"));
				map.put("orderQuantity", rs.getString("orderQuantity"));
				map.put("orderState", rs.getString("orderState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				// 설정한 값을 반환할 객체에 넣어줌
				list.add(map);
				// 디버깅
				System.out.println("고객 한명의 주문 목록 : " + list);
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	} // end selectOrdersListByCustomer

	// 관리자 주문 수정하기
	public int updateOrdersList(Connection conn, Map<String, Object> map) throws ClassNotFoundException, SQLException {
		// 리턴값 주문 목록을 받아 올 객체
		int updateOrders = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리문
		String sql = "UPDATE orders SET order_state = ?, update_date = now() WHERE  order_no = ?";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("updateOrdersList - DB 연결");
		System.out.println(map);
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, (String) map.get("orderState"));
			stmt.setInt(2, (int) map.get("ordersNo"));
			// 디버깅
			System.out.println("updateOrdersList - orderState : " + map.get("orderState"));
			System.out.println("updateOrdersList - ordersNo : " + map.get("ordersNo"));
			System.out.println("updateOrdersList - stmt : " + stmt);

			// 쿼리 실행
			updateOrders = stmt.executeUpdate();
			// 디버깅
			System.out.println("updateOrdersList - updateOrders : " + updateOrders);

		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}

		return updateOrders;
	}

	// 고객1 주문 수정하기
	public int updateCustomerOrder(Connection conn, int orderNo, int orderQuantity)
			throws ClassNotFoundException, SQLException {
		// 리턴값 주문 목록을 받아 올 객체
		int updateCustomerOrders = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리문
		String sql = "UPDATE orders SET order_quantity = ?  WHERE  order_no = ?";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - updateCustomerOrder - DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setInt(1, orderQuantity);
			stmt.setInt(2, orderNo);
			// 디버깅
			System.out.println("OrdersDao - updateCustomerOrder - stmt : " + stmt);

			// 쿼리 실행
			updateCustomerOrders = stmt.executeUpdate();
			// 디버깅
			System.out.println("updateOrdersList - updateOrders : " + updateCustomerOrders);

		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return updateCustomerOrders;
	} // end updateCustomerOrder

	// 고객1 주문 취소하기
	public int deleteCustomerOrder(Connection conn, int orderNo) throws ClassNotFoundException, SQLException {
		// 리턴값 주문 목록을 받아 올 객체
		int deleteCustomerOrders = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리문
		String sql = "DELETE from orders WHERE  order_no = ?";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - deleteCustomerOrder - DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setInt(1, orderNo);
			// 디버깅
			System.out.println("OrdersDao - deleteCustomerOrder - stmt : " + stmt);

			// 쿼리 실행
			deleteCustomerOrders = stmt.executeUpdate();
		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return deleteCustomerOrders;
	} // end deleteCustomerOrder

	// 상품 주문하기
	public int insertCustomerOrders(Connection conn, Orders order) throws ClassNotFoundException, SQLException {
		// 리턴값 주문 목록을 받아 올 객체
		int insertCustomerOrders = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리문
		String sql = "INSERT INTO orders (goods_no, customer_id, order_price, order_addr,detail_addr, order_quantity, order_state, update_date, create_date)"
				+ " VALUES (?, ?, ?, ?, ?, ?, '배송전', now(), now())";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("OrdersDao - insertCustomerOrders - DB 연결");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setInt(1, order.getGoodsNo());
			stmt.setString(2, order.getCustomerId());
			stmt.setString(3, order.getOrderPrice());
			stmt.setString(4, order.getOrderAddr());
			stmt.setString(5, order.getDetailAddr());
			stmt.setInt(6, order.getOrderQuantity());
			// 디버깅
			System.out.println("OrdersDao - insertCustomerOrders - stmt : " + stmt);

			// 쿼리 실행
			insertCustomerOrders = stmt.executeUpdate();

		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return insertCustomerOrders;
	} // end insertCustomerOrders
}
