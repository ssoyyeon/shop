package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.DBUtil;
import repository.SignDao;

public class SignService {
	private SignDao signDao;
	/*
	 * 아이디 중복검사 return : true이면 사용가능한 아이디 false이면 사용불가능한 아이디
	 */
	public boolean idCheck(String id) {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		// SignDao 객체 생성
		this.signDao = new SignDao();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("SignService - idCheck DB 연결");

			if (signDao.idCheck(conn, id) == null) {
				result = true;
				// 디버깅
				System.out.println("SignService - signDao.idCheck(conn, id) : " + result);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	} // end idCheck
} // end SignService