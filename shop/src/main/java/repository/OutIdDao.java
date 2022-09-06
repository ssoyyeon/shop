package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class OutIdDao {
	// 탈퇴 회원의 아이디를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String customerId) throws ClassNotFoundException, SQLException {
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "insert into outid (out_id , out_date) values ( ?,now() )";
		DBUtil dbUtil = new DBUtil();
		
		try {
			// DB 연결
			// 동일한 conn를 사용해야 하기 때문에 매개변수로 conn을 받아옴.
			conn = dbUtil.getConnection();
			
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("insertOutId - stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			System.out.println("insertOutId - row : " + row);
		}finally {
			// DB 자원해제
			// conn.close() X  -> CustomerService에서 conn.close() O
			stmt.close();
		}
		return row;
	} // end insertOutId

} // end OutIdDao
