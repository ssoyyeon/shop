package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Notice;

public class NoticeDao {
	
	// 공지사항 추가
	public int addNotice(Connection conn, Notice paranotice) throws Exception {
		int notice = 0;
		
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		String sql = "INSERT INTO notice (notice_title , notice_content, update_date, create_date) VALUES (?, ?, NOW(), NOW())";	
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("NoticeDao - addNotice DB 연결 성공!!!!!!!!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setString(1, paranotice.getNoticeTitle());
			stmt.setString(2, paranotice.getNoticeContent());
			// 디버깅
			System.out.println("NoticeDao - addNotice - stmt : " + stmt);

			// 쿼리 실행
			notice = stmt.executeUpdate();
			// 디버깅
			if(notice == 0) {
				System.out.println("NoticeDao - addNotice 오류");
			}
		} finally {
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return notice;
	} // addtNotice
	
	// 공지사항 삭제
	public int deleteNotice(Connection conn, int noticeNo) throws ClassNotFoundException, SQLException {
		int notice = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		String sql = "DELETE FROM notice WHERE notice_no = ?";	
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("NoticeDao - deleteNotice DB 연결 성공!!!!!!!!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setInt(1, noticeNo);
			// 디버깅
			System.out.println("NoticeDao - deleteNotice - stmt : " + stmt);

			// 쿼리 실행
			notice = stmt.executeUpdate();
			// 디버깅
			if(notice == 0) {
				System.out.println("NoticeDao - deleteNotice 오류");
			}
		} finally {
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return notice;
	} // end deleteNotice
		

	// 공지사항 수정
	public int updateNotice(Connection conn, Notice paranotice) throws ClassNotFoundException, SQLException {
		int notice = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		String sql = "UPDATE notice SET notice_title = ?, notice_content=?, update_date= now() WHERE notice_no = ?";	
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("NoticeDao - updateNotice DB 연결 성공!!!!!!!!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setString(1, paranotice.getNoticeTitle());
			stmt.setString(2, paranotice.getNoticeContent());
			stmt.setInt(3, paranotice.getNoticeNo());
			// 디버깅
			System.out.println("NoticeDao - updateNotice - stmt : " + stmt);

			// 쿼리 실행
			notice = stmt.executeUpdate();
			// 디버깅
			if(notice == 0) {
				System.out.println("NoticeDao - updateNotice 오류");
			}		
		} finally {
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return notice;
	}
	
	// 공지사항 상세보기
	public Notice  noticeListOne(Connection conn, int noticeNo) throws ClassNotFoundException, SQLException { 
		Notice notice = null;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, create_date createDate"
				+ " FROM notice WHERE notice_no= ?";
		/*
		 * SELECT notice_no noticeNo, notice_title noticeTitle, notice_content
		 * noticeContent, create_date createDate FROM notice WHERE notice_no= ?
		 */

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("NoticeDao - selectNoticeList DB 연결 성공!!!!!!!!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setInt(1, noticeNo);
			// 디버깅
			System.out.println("NoticeDao - stmt : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setCreateDate(rs.getString("createDate"));
				// 디버깅 
				System.out.println("noticeListOne - notice : " + notice);
			}else {
				System.out.println("noticeListOne - notice 오류!");
			}
		} finally {
			// DB 자원해제
			if (rs != null) { try { rs.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return notice;
	} // end noticeListOne

	// 공지사항 리스트
	public List<Map<String, Object>> selectNoticeList(Connection conn, int ROW_PER_PAGE, int beginRow)
			throws SQLException, ClassNotFoundException {
		List<Map<String, Object>> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = " SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, create_date createDate"
				+ " FROM notice ORDER BY notice_no DESC LIMIT ?,?";
		/*
		 * SELECT notice_no noticeNo, notice_title noticeTitle, notice_content
		 * noticeContent, create_date createDate FROM notice ORDER BY notice_no DESC
		 * LIMIT ?,?
		 */
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("NoticeDao - selectNoticeList DB 연결 성공!!!!!!!!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setInt(1, beginRow);
			stmt.setInt(2, ROW_PER_PAGE);
			// 디버깅
			System.out.println("NoticeDao - stmt : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("noticeNo", rs.getInt("noticeNo"));
				map.put("noticeTitle", rs.getString("noticeTitle"));
				map.put("createDate", rs.getString("createDate"));
				map.put("noticeContent", rs.getString("noticeContent"));
				map.put("createDate", rs.getString("createDate"));
				list.add(map);
				// 디버깅
				System.out.println("Map<String, Object> map : " + map);
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
	} // end selectNoticeList

	// 마지막 페이지
	public int lastPage(Connection conn, final int ROW_PER_PAGE) throws ClassNotFoundException, SQLException  {
		// 리턴값 반환할 변수
		int lastPage = 0;
		// 전체 게시물 수 
		int totalRow = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM notice";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("NoticeDao - lastPage DB 연결 성공!!!!!!!!!!");

		try {
			stmt = conn.prepareStatement(sql);
			// 쿼리 실행
			rs = stmt.executeQuery();

			// 전체 행의 수를 구하기 위한 쿼리 실행
			if (rs.next()) {
				totalRow += rs.getInt("count(*)");
				// 디버깅
				System.out.println("NoticeDao - totalRow  : " + totalRow);
			}

			// 마지막 페이지 구하기
			lastPage = totalRow / ROW_PER_PAGE;
			// 마지막페이지가 rowPerPage로 떨어지지 않을 떼
			if (totalRow % ROW_PER_PAGE != 0) {
				lastPage += 1;
			}

			// 디버깅
			System.out.println("NoticeDao - lastPage : " + lastPage);
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



} // end NoticeDao
