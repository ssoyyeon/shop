package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		Connection conn = null;
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://localhost:3306/shop";
		String id = "root";
		String pw = "1234";
		Class.forName(driver);
		conn = DriverManager.getConnection(url,id,pw);
		
		// 디버깅
		System.out.println("\n\n------------------------------------------------------------------------------- DBUtil");
		return conn;
	} // end getConnection
}
