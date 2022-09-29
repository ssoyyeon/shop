package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		// 서버에 올라가는 파일입니다.
		Connection conn = null;
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://43.201.54.237:3306/shop";
		String id = "root";
		String pw = "305318";
		Class.forName(driver);
		conn = DriverManager.getConnection(url,id,pw);
		
		// 디버깅
		System.out.println("\n\n------------------------------------------------------------------------------- DBUtil");
		return conn;
	} // end getConnection
}
