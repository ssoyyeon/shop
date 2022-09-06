package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CounterDao;
import repository.DBUtil;

public class CounterService {
	private CounterDao counterDao;

	public void count(){
		// 메서드 호출할 객체
		counterDao = new CounterDao();
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CounterService - count DB 연결 성공!!!!!!!!!!");

			// conn 자동커밋해제
			conn.setAutoCommit(false);

			// Counter 메서드 호출
			counterDao.selectCounterToday(conn);

			if (counterDao.selectCounterToday(conn) == null) {
				// 오늘날짜 카운터가 없으면 1 입력
				counterDao.insertCounter(conn);
			} else {
				// 오늘날짜의 카운터가 있으면 +1 업데이트
				counterDao.updateCounter(conn);
			}

		} catch (Exception e) {
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

	} // end count

	// 총 방문자 수
	public int getTotalCount() {
		// 리턴값 반환할 변수
		int totalCount = 0;
		// 메서드 호출할 객체
		counterDao = new CounterDao();
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CounterService - getTotalCount DB 연결 성공!!!!!!!!!!");

			// conn 자동커밋해제
			conn.setAutoCommit(false);

			// getTotalCount 메서드 호출
			totalCount = counterDao.selectTotalCount(conn);

			// 오늘날짜 카운터가 없으면 1 입력
			if (counterDao.selectCounterToday(conn) == null) {
				counterDao.insertCounter(conn);
			} else {
				// 오늘날짜의 카운터가 있으면 +1 업데이터
				counterDao.updateCounter(conn);
			}

		} catch (Exception e) {
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
		return totalCount;
	} // end getTotalCount

	// 오늘 방문자 수
	public int getTodayCount() {
		// 리턴값 반환할 변수
		int todayCount = 0;
		// 메서드 호출할 객체
		counterDao = new CounterDao();
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CounterService - getTodayCount DB 연결 성공!!!!!!!!!!");

			// conn 자동커밋해제
			conn.setAutoCommit(false);

			// getTodayCount 메서드 호출
			todayCount = counterDao.selectTodayCount(conn);

			if (todayCount == 0) {
				System.out.println("getTodayCount가 없습니다.");
				// 오류 생성 
				throw new Exception();
			}

		} catch (Exception e) {
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
		return todayCount;
	} // end getTodayCount
}