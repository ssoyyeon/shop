package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import repository.DBUtil;
import repository.NoticeDao;
import vo.Notice;

public class NoticeService {
	
	// 공지사항 추가
	public int insertNotice(Notice paranotice) throws Exception {
		int notice = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService - insertNotice DB 연결 성공!!!!!!!!!!");
			
			// 자동 커밋 방징
			conn.setAutoCommit(false);
			
			// 메서드 호출을 위한 객체 생성
			NoticeDao noticeDao = new NoticeDao();
			
			// 메서드 호출			
			notice = noticeDao.addNotice(conn, paranotice);	
			
			// 공지사항 수정하기를 실패한다면 오류 생성
			if (notice == 0) {
				throw new Exception();
			}
			
			// 커밋
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			}catch(Exception e1){
				e1.printStackTrace();
			}
			conn.rollback();
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
		return notice;
	} // end insertNotice
	
	// 공지사항 삭제
	public int deleteNotice(int noticeNo) throws Exception {
		int notice = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService - deleteNotice DB 연결 성공!!!!!!!!!!");
			
			// 자동 커밋 방징
			conn.setAutoCommit(false);
			
			// 메서드 호출을 위한 객체 생성
			NoticeDao noticeDao = new NoticeDao();
			
			// 메서드 호출			
			notice = noticeDao.deleteNotice(conn, noticeNo);	
			
			// 공지사항 수정하기를 실패한다면 오류 생성
			if (notice == 0) {
				throw new Exception();
			}
			
			// 커밋
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			}catch(Exception e1){
				e1.printStackTrace();
			}
			conn.rollback();
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
		return notice;
	} // end deleteNotice
	
	
	// 공지사항 수정
	public int updateNotice(Notice paranotice) throws Exception {
		int notice = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService - noticeListOne DB 연결 성공!!!!!!!!!!");
			// 자동 커밋 방징
			conn.setAutoCommit(false);
			
			// 메서드 호출을 위한 객체 생성
			NoticeDao noticeDao = new NoticeDao();
			
			// 메서드 호출			
			notice = noticeDao.updateNotice(conn, paranotice);
			
			// 공지사항 수정하기를 실패한다면 오류 생성
			if (notice == 0) {
				throw new Exception();
			}
			
			// 커밋
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			}catch(Exception e1){
				e1.printStackTrace();
			}
			conn.rollback();
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
		
		return notice;
	} // end noticeListOne
		
	// 상세보기
	public Notice noticeListOne(int noticeNo) throws Exception { 
		Notice notice = null;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService - noticeListOne DB 연결 성공!!!!!!!!!!");
			
			// 메서드 호출을 위한 객체 생성
			NoticeDao noticeDao = new NoticeDao();
			
			// 메서드 호출			
			notice = noticeDao.noticeListOne(conn, noticeNo);	
			
			// 리스트 추출을 실패한다면 오류 생성
			if (notice == null) {
				throw new Exception();
			}
			
		} catch (ClassNotFoundException e) {
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
		
		return notice;
	}
	
	// 공지사항 리스트
	public List<Map<String, Object>> selectNoticeList(int ROW_PER_PAGE, int currentPage) throws Exception {
		List<Map<String, Object>> list = null;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService - selectNoticeList DB 연결 성공!!!!!!!!!!");

			// 시작하는 행
			int beginRow = (currentPage - 1) * ROW_PER_PAGE;

			// 메서드 호출을 위한 객체 생성
			NoticeDao noticeDao = new NoticeDao();
			// 공지사항 리스트 메서드 호출
			list = noticeDao.selectNoticeList(conn, ROW_PER_PAGE, beginRow);
			System.out.println(list);

			// 디버깅
			System.out.println("currentPage : " + currentPage);
			System.out.println("beginRow : " + beginRow);
			System.out.println("rowPerPage : " + ROW_PER_PAGE);

			// 리스트 추출을 실패한다면 오류 생성
			if (list == null) {
				throw new Exception();
			}
		} catch (ClassNotFoundException e) {
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
		return list;
	} // end selectNoticeList

	// 마지막 페이지
	public int lastPage(final int ROW_PER_PAGE) throws Exception {
		int lastPage = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			NoticeDao noticeDao = new NoticeDao();

			// lastPage 구하는 메서드 호출
			lastPage = noticeDao.lastPage(conn, ROW_PER_PAGE);
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

} // end NoticeService
