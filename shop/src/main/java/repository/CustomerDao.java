package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Customer;

public class CustomerDao {
	
	// 고객 스스로 탈퇴
	public int removeCustomer(Connection conn , String customerId, String customerPass) throws SQLException, ClassNotFoundException {
		// 리턴값 반환할 변수
		int customer = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "DELTE FROM customer WHERE customer_id = ? and customer_pass = password(?)";

		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CustomerDao - removeCustomer DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, customerId);
			stmt.setString(2, customerPass);
			// 디버깅
			System.out.println("CustomerDao - removeCustomer : " + stmt);
			
			// 뭐리 실행
			customer = stmt.executeUpdate();
			// 디버깅

			if(customer != 0){
			System.out.println("CustomerDao - removeCustomer 삭제 성공");
			}else {
				System.out.println("customer : " + customer + "삭제 실패");
			}
		} finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return customer;
	} // end removeCustomer
	
	
	// 고객 강제 탈퇴
	public int removeCustomerById(Connection conn , String customerId) throws SQLException, ClassNotFoundException {
		// 리턴값 반환할 변수
		int customer = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "DELTE FROM customer WHERE customer_id = ?";
		
		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CustomerDao - removeCustomerById DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("removeCustomerById : " + stmt);
			
			// 뭐리 실행
			customer = stmt.executeUpdate();
			// 디버깅

			if(customer != 0){
			System.out.println("CustomerDao - removeCustomerById 삭제 성공");
			}else {
				System.out.println("customer : " + customer + "삭제 실패");
			}
		} finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return customer;
	} // end removeCustomerById
	
	// 비밀번호 수정
	public int updateCustomerPw(Connection conn , Customer paracustomer) throws SQLException, ClassNotFoundException {
		// 리턴값 반환할 변수
		int pw = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "UPDATE customer SET customer_pass= password(?) WHERE customer_id= ?";
		
		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CustomerDao - updateCustomerPw DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, paracustomer.getCustomerPass());
			stmt.setString(2, paracustomer.getCustomerId());
			// 디버깅
			System.out.println("updateCustomerPw : " + stmt);
			
			// 뭐리 실행
			pw = stmt.executeUpdate();
			// 디버깅

			if(pw != 0){
			System.out.println("CustomerDao - updateCustomerPw 비밀번호 변경 성공");
			}else {
				System.out.println("pw : " + pw);
			}
		} finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return pw;
	} // end updateCustomerPw
	
	// 고객 리스트
	public List<Map<String, Object>> selecCustomerList(Connection conn, int rowPerPage, int beginRow) throws ClassNotFoundException, SQLException{
		// 리턴값 반환할 객체
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "select customer_id customerId, customer_pass customerPass, customer_name customerName, customer_addr customerAddress,"
				+ " detail_addr detailAddress, customer_telephone customerTelephone, create_date createDate, update_date updateDate"
				+ " from customer ORDER BY create_date DESC LIMIT ?,?;";

		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CustomerDao - selecCustomerList DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("selecCustomerList : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("customerId", rs.getString("customerId"));
				map.put("customerPass", rs.getString("customerPass"));
				map.put("customerName", rs.getString("customerName"));
				map.put("createDate", rs.getString("createDate"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("customerAddress", rs.getString("customerAddress"));
				map.put("detailAddress", rs.getString("detailAddress"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
				list.add(map);
				// 디버깅
				System.out.println("Map<String, Object> map : " + map);
			}
		} finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		}
		return list;
	} // end selectEmployeeList
		
	// 고객1 정보수정
		public int updateCustomer(Connection conn , Customer paracustomer) throws SQLException, ClassNotFoundException {
			// 리턴값 반환할 변수
			int pw = 0;
			// DB 자원
			DBUtil dbUtil = new DBUtil();
			PreparedStatement stmt = null;
			// 쿼리
			String sql = "UPDATE customer SET customer_addr=?, detail_addr= ?, customer_telephone=? WHERE customer_id = ?";
			
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerDao - updateCustomer DB- 연결");

			try {
				// 쿼리 넣기
				stmt = conn.prepareStatement(sql);
				// ? 값 설정
				stmt.setString(1, paracustomer.getCustomerAddress());
				stmt.setString(2, paracustomer.getDetailAddress());
				stmt.setString(3, paracustomer.getCustomerTelephone());
				stmt.setString(4, paracustomer.getCustomerId());
				// 디버깅
				System.out.println("CustomerDao - updateCustomer : " + stmt);
				
				// 뭐리 실행
				pw = stmt.executeUpdate();
				// 디버깅

				if(pw != 0){
				System.out.println("CustomerDao - updateCustomer 고객 정보 변경 성공");
				}else {
					System.out.println("pw : " + pw);
				}
			} finally {
				// DB 자원해제
				if(stmt != null) {
					stmt.close();
				}
			}
			return pw;
		} // end updateCustomer
	
	// 고객1 개인정보
	public Customer getCustomerOne(Connection conn, String customerId) throws SQLException, ClassNotFoundException {
		// 리턴값 반환할 객체
		Customer customer = new Customer();
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "select customer_id customerId, customer_pass customerPass, customer_name customerName, customer_addr customerAddress,"
				+ "  detail_addr detailAddress, customer_telephone customerTelephone, create_date createDate, update_date updateDate"
				+ " from customer WHERE customer_id= ?";

		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CustomerDao - selecCustomerOne DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("selectCustomerOne : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setDetailAddress(rs.getString("detailAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setUpdateDate(rs.getString("updateDate"));
				customer.setCreateDate(rs.getString("createDate"));
			}
		} finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		}
		return customer;
	} // end selecCustomerOne
	
	// 마지막 페이지
	public int lastPage(int rowPerPage, int currentPage) throws Exception {
		// 리턴값 반환 변수
		int lastPage = 0;
		// 전체 멤버 수
		int totalRow = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "SELECT count(*) FROM customer";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("CustomerDao - DB 연결");
		
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CustomerDao - lastPage : " + stmt);
			
			// 전체 행의 수를 구하기 위한 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count(*)");
			}
			
			// 디버깅
			System.out.println("CustomerDao - totalRow  : " + totalRow );
			System.out.println("CustomerDao - rowPerPage  : " + rowPerPage );
			// 마지막 페이지 
			lastPage = totalRow / rowPerPage ;
			// 페이지가 rowPerPage로 나눠떨어지지 않아도 페이지 구현을 위해 1개 추가
			if (totalRow % rowPerPage != 0) {
				lastPage += 1;
			}

			// 디버깅
			System.out.println("CustomerDao - lastPage : " + lastPage);
			
		}finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		}
		return lastPage;		
	} // end lastPage
		
	// 탈퇴
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		PreparedStatement stmt = null;
		String sql = "delete from customer where customer_id = ? and customer_pass = password(?)";
		DBUtil dbUtil = new DBUtil();
		
		// DB 연결
		// 동일한 conn를 사용해야 하기 때문에 매개변수로 conn을 받아옴.
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("deleteCustomer - DB 연결 성공!");

		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			// 디버깅
			System.out.println("deleteCustomer - customerId : " + paramCustomer.getCustomerId());
			System.out.println("deleteCustomer - customerPass : " + paramCustomer.getCustomerPass());
			System.out.println("deleteCustomer - stmt : " + stmt);

			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			System.out.println("deleteCustomer - row : " + row);

		} finally {
			// DB 자원해제
			// conn.close() X -> CustomerService에서 conn.close() O
			if(stmt != null) { stmt.close(); }
		}
		return row;
	} // end deleteCustomer

	// CustomerService가 호출 - 로그인
	public Customer customerLogin(Connection conn, Customer customer) throws ClassNotFoundException, SQLException {
		// 새로 받아오는 객체
		Customer loginCustomer = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select customer_id customerId, customer_pass customerPass, customer_name customerName from customer where customer_id= ? AND customer_pass= PASSWORD(?)";
		DBUtil dbUtil = new DBUtil();
		
		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("customerLogin DB- 연결");
		
		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			// 디버깅
			System.out.println("customerLogin : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customerId"));
				loginCustomer.setCustomerPass(rs.getString("customerPass"));
				loginCustomer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			// DB 자원해제
			rs.close();
			stmt.close();	
		}
		return loginCustomer;
	} // end customerLogin
	
	// 회원가입
	// signUpCustomerAction.jsp 호출시
	public int insertCustomer(Connection conn, Customer paramCustomer) throws ClassNotFoundException, SQLException {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		String sql = "insert INTO customer (customer_id, customer_pass, customer_name, customer_addr, detail_addr, customer_telephone, update_date, create_date)"
				+ " values (?, password(?), ?, ?, ?, ?, now(), now() )";
	    /*
		insert INTO 
		customer (customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) 
		values (?, password(?), ?, ?, ?, now(), now() )
		*/
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("addCustomer DB- 연결");
		
		try {
			// 쿼리 담고 값 설정
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getDetailAddress());
			stmt.setString(6, paramCustomer.getCustomerTelephone());
			// 디버깅
			System.out.println("addCustomer - stmt : " + stmt);
			
			row = stmt.executeUpdate();
			// 디버깅
			if(row != 0) {
				System.out.println("addCustomer - CustomerDao 쿼리 성공!");
			}
			
		}finally {
			// DB 자원해제
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	} // end addCutomer
} // end CustomerDao
