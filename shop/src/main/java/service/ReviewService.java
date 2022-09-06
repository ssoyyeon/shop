package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.ReviewDao;
import vo.Review;

public class ReviewService {

	// 상품별 리뷰 리스트 : R
	public List<Map<String, Object>> getReviewListByGoods(int goodsNo) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("getReviewList DB 연결");
			System.out.println("goodsNo :  " + goodsNo);

			// 리뷰 리스트 호출
			list = new ReviewDao().selectReviewListByGoods(conn, goodsNo);

			// 리뷰 리스트 호출 실패시 오류 생성
			if (list == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	} // end getReviewList

	// 고객1 리뷰 전체 리스트 : R
	public List<Map<String, Object>> getReviewListById(String customerId) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("getReviewListById DB 연결");

			// 리뷰 리스트 호출
			list = new ReviewDao().selectReviewListById(conn, customerId);

			// 리뷰 리스트 호출 실패시 오류 생성
			if (list == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	} // end getReviewListById

	// 전체 리뷰 리스트 조회
	public List<Map<String, Object>> getReviewList() throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("getReviewList DB 연결");

			// 리뷰 리스트 호출
			list = new ReviewDao().selectReviewList(conn);

			// 리뷰 리스트 호출 실패시 오류 생성
			if (list == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		
		return list;
	} // end getReviewList

	// 상품별 고객 1 리뷰 리스트 : R
	public List<Map<String, Object>> getReviewListByIdGoods(int goodsNo, String customerId) throws SQLException {
		// 리턴할 객체 생성
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("getReviewListById DB 연결");
			System.out.println("getReviewListById - goodsNo :  " + goodsNo);

			// 리뷰 리스트 호출
			list = new ReviewDao().selectReviewListByIdGoods(conn, goodsNo, customerId);

			// 리뷰 리스트 호출 실패시 오류 생성
			if (list == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	} // end getReviewListByIdGoods

	// 리뷰 삭제 : D
	public int removeReview(int goodsNo, String customerId) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		Connection conn = null;

		try {
			// DB 연결
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("removeReview DB 연결");
			// 리뷰 삭제 메서드 실행
			row = new ReviewDao().deleteReview(conn, goodsNo, customerId);
			// 리뷰 삭제 실패시 오류 생성
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	} // end removeReview

	// U 리뷰 수정
	public int modifyReview(Review review) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("modifyReview DB 연결");
			// 리뷰수정 메서드 실행
			row = new ReviewDao().updateReview(conn, review);

			// 리뷰 수정 실패시 오류 생성
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	} // end modifyReview

	// C 리뷰 추가
	public int addReview(int orderNo, String reviewContent, String customerId) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("addReview DB 연결");
			// 리뷰 추가 메서드 실행
			row = new ReviewDao().insertReview(conn, orderNo, reviewContent, customerId);

			// 리뷰 추가 실패시 오류 생성
			if (row == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	} // end modifyReview

	// 마지막 페이지
	public int lastPage(int rowPerPage, int currentPage) throws Exception {
		int lastPage = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("ReviewService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			ReviewDao reviewDao = new ReviewDao();

			// lastPage 구하는 메서드 호출
			lastPage = reviewDao.lastPage(conn, rowPerPage);
			// lastPage 실패시 오류 생성
			if (lastPage == 0) {
				throw new Exception();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return lastPage;
	} // end lastPage

}
