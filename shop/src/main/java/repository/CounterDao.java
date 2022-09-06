package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CounterDao {
	
	// 오늘 방문자
	public String selectCounterToday(Connection conn) throws ClassNotFoundException, SQLException {
		// 리턴값 반환 변수
		String result = null;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "SELECT counter_date FROM counter WHERE counter_date = CURDATE()";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CounterDao - selectCounterToday DB 연결 성공!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao - stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("counter_date");
				// 디버깅
				System.out.println("result : " + result);
			}
		}finally {
			// DB 자원해제
			if(rs != null) { try{rs.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return result;	
	}
	
	// 오늘날짜에 카운트가 없으면 카운트 생성
	public void insertCounter(Connection conn) throws ClassNotFoundException, SQLException {
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "INSERT INTO counter(counter_date,counter_num) VALUES(CURDATE(),1)";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CounterDao - insertCounter DB 연결 성공!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao - stmt : " + stmt);
			
			// 쿼리 실행
			stmt.executeUpdate();
			// 디버깅
			if(stmt.executeUpdate() != 0) {
				System.out.println("insertCounter 성공!" );
			}
		}finally {
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
	} // end insertCounter
	
	// 카운트가 있을 경우 방문자 수 변경
	public void updateCounter(Connection conn) throws ClassNotFoundException, SQLException {
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "UPDATE counter SET counter_num = counter_num + 1 WHERE counter_date = CURDATE()";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CounterDao - insertCounter DB 연결 성공!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao - stmt : " + stmt);
			
			// 쿼리 실행
			stmt.executeUpdate();
			// 디버깅
			if(stmt.executeUpdate() != 0) {
				System.out.println("updateCounter 성공!" );
			}
		}finally {
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
	} // end updateCounter
	
	
	// IndexController에서 호출
	// 전체 접속자 수
	// SELECT SUM(counter_num) FROM counter; 
	public int selectTotalCount(Connection conn) throws ClassNotFoundException, SQLException {
		// 리턴값 반환 변수
		int result = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT SUM(counter_num) FROM counter";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CounterDao - selectTotalCount DB 연결 성공!!!");
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao - selectTotalCount - stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("SUM(counter_num)");
				// 디버깅
				System.out.println("전체 접속자 수 : " + result);
			}
		}finally {
			// DB 자원해제
			if(rs != null) { try{rs.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return result;
	} // end selectTotalCount
	
	// 오늘 접속자 수
	// SELECT counter_num FROM counter WHERE counter_date = CURDATE();
	public int selectTodayCount(Connection conn) throws ClassNotFoundException, SQLException {
		// 리턴값 반환 변수
		int result = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT counter_num FROM counter WHERE counter_date = CURDATE()";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CounterDao - selectTodayCount DB 연결 성공!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao - selectTodayCount - stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("counter_num");
				// 디버깅
				System.out.println("오늘 접속자 수 : " + result);
			}
		}finally {
			// DB 자원해제
			if(rs != null) { try{rs.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
		return result;
	} // end selectTodayCount
}