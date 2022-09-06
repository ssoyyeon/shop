package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDao {
	// id 중복검사
	public String idCheck(Connection conn, String id) throws SQLException, ClassNotFoundException {
	  String ckId = null;
      PreparedStatement stmt = null;
      ResultSet rs = null;
      String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";
      
      /*
       SELECT t.id
       FROM (SELECT customer_id id FROM customer
             UNION
             SELECT employee_id id FROM employee
             UNION
             SELECT out_id id FROM out_id) t
       WHERE t.id = ?   
       --> null일때 사용가능한 아이디
       */
			stmt = conn.prepareStatement(sql);
			// 디버깅
		    System.out.println("SignDao - idCheck DB 연결");

			// 쿼리값 설정
			stmt.setString(1, id);
			// 디버깅
			System.out.println("idCheck - stmt : " + stmt);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				ckId = rs.getString("t.id");
				// 디버깅
				System.out.println("idCheck - ckId:" + ckId);
			}
			
			// DB 자원해제
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
	
		return ckId;
   } // end idCheck
	
} // end SignDao