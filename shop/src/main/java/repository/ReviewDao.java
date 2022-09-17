package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Review;

public class ReviewDao {

	// 상품별 고객 리뷰 리스트 : R
	public List<Map<String, Object>> selectReviewListByGoods(Connection conn, int goodsNo) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "SELECT r.order_no orderNo, r.review_content reviewContent,  r.goods_no goodsNo, r.create_date createDate, "
				+ "r.update_date updateDate, o.customer_id customerId FROM review r INNER JOIN orders o USING(order_no) "
				+ "WHERE r.goods_no= ?";
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDAO - selectReviewList - DB 연결");
			// ? 값 setter
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println("ReviewDAO - selectReviewList - stmt : " + stmt);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("createDate", rs.getString("createDate"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("customerId", rs.getString("customerId"));
				list.add(m);
				// 디버깅
				System.out.println("ReviewDao - selectReviewList - list : " + list);
			}
			// 디버깅
			if (list != null) {
				System.out.println("ReviewDao - selectReviewList - 성공!");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// 고객1 리뷰 전체리스트 : R
	public List<Map<String, Object>> selectReviewListById(Connection conn, String customerId) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "SELECT order_no orderNo, review_content reviewContent,  goods_no goodsNo, create_date createDate, update_date updateDate "
				+ "FROM review " + "WHERE order_no in (SELECT order_no  FROM orders where customer_id = ?) ";

		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao - selectReviewListById - DB 연결");
			// ? 값 setter
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("ReviewDao - selectReviewListById - stmt : " + stmt);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("createDate", rs.getString("createDate"));
				m.put("updateDate", rs.getString("updateDate"));
				list.add(m);
				// 디버깅
				System.out.println("ReviewDao - selectReviewListById - list : " + list);
			}
			// 디버깅
			if (list != null) {
				System.out.println("ReviewDao - selectReviewListById - 성공!");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// 전체 리뷰 리스트 조회
	public List<Map<String, Object>> selectReviewList(Connection conn, int ROW_PER_PAGE , int beginRow) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "SELECT r.order_no orderNo, r.review_content reviewContent,  r.goods_no goodsNo, r.create_date createDate, r.update_date updateDate "
				+ ", o.customer_id customerId FROM review r INNER JOIN orders o USING(order_no) ORDER BY r.create_date DESC LIMIT ?,?";
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao - selectReviewList - DB 연결");
			// ? setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, ROW_PER_PAGE);
			// 디버깅
			System.out.println("ReviewDao - selectReviewList - stmt : " + stmt);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("createDate", rs.getString("createDate"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("customerId", rs.getString("customerId"));
				list.add(m);
				// 디버깅
				System.out.println("ReviewDao - selectReviewList - list : " + list);
			}
			// 디버깅
			if (list != null) {
				System.out.println("ReviewDao - selectReviewList - 성공!");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	} // end selectReviewList

	// 고객1이 쓴 상품별 리뷰 리스트 : R
	public List<Map<String, Object>> selectReviewListByIdGoods(Connection conn, int goodsNo, String customerId)
			throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "SELECT order_no orderNo, review_content reviewContent,  goods_no goodsNo, create_date createDate, update_date updateDate "
				+ "FROM review "
				+ "WHERE order_no= (SELECT order_no  FROM orders where customer_id = ? AND goods_no= ?);";
		/*
		 * "SELECT DISTINCT  r.order_no orderNo, r.goods_no goodsNo , r.review_content reviewContent, r.create_date createDate, r.update_date updateDate"
		 * + " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no " +
		 * "INNER JOIN review r ON g.goods_no = r.goods_no " +
		 * "WHERE customer_id=? AND o.goods_no= ?";
		 */
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao - selectReviewListByIdGoods - DB 연결");
			// ? 값 setter
			stmt.setString(1, customerId);
			stmt.setInt(2, goodsNo);
			// 디버깅
			System.out.println("ReviewDao - selectReviewListByIdGoods - stmt : " + stmt);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("createDate", rs.getString("createDate"));
				m.put("updateDate", rs.getString("updateDate"));
				list.add(m);
				// 디버깅
				System.out.println("ReviewDao - selectReviewListByIdGoods - list : " + list);
			}
			// 디버깅
			if (list != null) {
				System.out.println("ReviewDao - selectReviewListByIdGoods - 성공!");
			}
		} finally {
			// DB 자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	} // end selectReviewListByIdGoods

	// D 고객 1 전체 리뷰 삭제
	public int deleteReviewByCustomer(Connection conn, String customerId) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "DELETE FROM review WHERE customer_id=?";
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao - deleteReviewByCustomer - DB 연결");

			// ? 값 setter
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("ReviewDao - deleteReviewByCustomer - stmt : " + stmt);

			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			if (row == 0) {
				System.out.println("고객 1 전체 리뷰 삭제 실패!");
			}
		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	} // end deleteReviewByCustomer

	// D 리뷰 삭제
	public int deleteReview(Connection conn, int goodsNo, String customerId) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "DELETE FROM review WHERE order_no= (SELECT order_no FROM orders WHERE customer_id=? AND goods_no=?)";
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao - deleteReview - DB 연결");

			// ? 값 setter
			stmt.setString(1, customerId);
			stmt.setInt(2, goodsNo);
			// 디버깅
			System.out.println("ReviewDao - deleteReview - stmt : " + stmt);

			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			if (row == 0) {
				System.out.println("리뷰 삭제 실패!");
			}
		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	} // end deleteReview

	// C 리뷰 추가
	public int insertReview(Connection conn, int orderNo, String reviewContent, String customerId) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "INSERT INTO review (review_content, update_date, create_date, goods_no) "
				+ "VALUES (?, Now(), NOW(), (SELECT goods_no FROM orders WHERE customer_id=? AND order_no=? ) )";

		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDAO - insertReview - DB 연결");
			// ? 값 setter
			stmt.setString(1, reviewContent);
			stmt.setString(2, customerId);
			stmt.setInt(3, orderNo);
			// 디버깅
			System.out.println("ReviewDAO - insertReview - stmt : " + stmt);

			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			if (row == 0) {
				System.out.println("리뷰 작성 실패!");
			}
		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	} // end insertReview

	// U 리뷰 수정
	public int updateReview(Connection conn, Review review) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "UPDATE review SET review_content= ?, update_date=now() WHERE order_no= ?";

		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao - updateReview - DB 연결");
			// ? 값 setter
			stmt.setString(1, review.getReviewContent());
			stmt.setInt(2, review.getOrderNo());
			// 디버깅
			System.out.println("ReviewDao - updateReview - stmt : " + stmt);
			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			if (row == 0) {
				System.out.println("리뷰 수정 실패!");
			}
		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	} // end updateReview

	// 마지막 페이지
	public int lastPage(Connection conn, final int ROW_PER_PAGE) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 변수
		int lastPage = 0;
		// 전체 게시물 수
		int totalRow = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM review";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("ReviewDao - lastPage DB 연결 성공!!!!!!!!!!");

		try {
			stmt = conn.prepareStatement(sql);
			// 쿼리 실행
			rs = stmt.executeQuery();

			// 전체 행의 수를 구하기 위한 쿼리 실행
			if (rs.next()) {
				totalRow += rs.getInt("count(*)");
				// 디버깅
				System.out.println("ReviewDao - totalRow  : " + totalRow);
			}

			// 마지막 페이지 구하기
			lastPage = totalRow / ROW_PER_PAGE;
			// 마지막페이지가 ROW_PER_PAGE로 떨어지지 않을 떼
			if (totalRow % ROW_PER_PAGE != 0) {
				lastPage += 1;
			}

			// 디버깅
			System.out.println("ReviewDao - lastPage : " + lastPage);
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
		//
		return lastPage;
	} // end lastPage

}
