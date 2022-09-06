package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Employee;

public class EmployeeDao {
	
	// admin active 체크
	public String activeCk(Connection conn, String employeeId) throws SQLException, ClassNotFoundException {
		String actionCk = null;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT active FROM employee WHERE employee_id = ?";

		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("EmployeeDao - activeCk DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setString(1, employeeId);
			// 디버깅
			System.out.println("EmployeeDao - activeCk : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				actionCk = rs.getString("active");
			}
		} finally {
			// DB 자원해제
			rs.close();
			stmt.close();
		}
		return actionCk;
	} // end actionCk
	
	// 탈퇴
	// EmployeeService.removeEmployee(Employee paramEmployee)가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws ClassNotFoundException, SQLException {
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "delete from employee where employee_id = ?";
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			// 동일한 conn를 사용해야 하기 때문에 매개변수로 conn을 받아옴.
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("deleteEmployee - DB 연결 성공!");

			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, paramEmployee.getEmployeeId());
			// 디버깅
			System.out.println("deleteEmployee - stmt : " + stmt);

			// 쿼리 실행
			row = stmt.executeUpdate();
			// 디버깅
			System.out.println("deleteEmployee - row : " + row);
		} finally {
			// DB 자원해제
			// conn.close() X -> EmployeeService에서 conn.close() O
			stmt.close();
		}
		return row;
	} // end deleteEmployee

	// emplyee 로그인 / 아이디가 존재하고 active가 Y
	public Employee emplyeeLogin(Connection conn, Employee employee) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 객체
		Employee loginEmplyee = null;
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "select employee_id employeeId, employee_pass employeePass, employee_name employeeName, active from employee where employee_id= ? AND employee_pass= PASSWORD(?)";

		// DB 연결
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("emplyeeLogin DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			// 디버깅
			System.out.println("emplyeeLogin : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				loginEmplyee = new Employee();
				loginEmplyee.setEmployeeId(rs.getString("employeeId"));
				loginEmplyee.setEmployeePass(rs.getString("employeePass"));
				loginEmplyee.setEmployeeName(rs.getString("employeeName"));
				loginEmplyee.setActive(rs.getString("active"));
			}
		} finally {
			// DB 자원해제
			rs.close();
			stmt.close();
		}
		return loginEmplyee;
	} // end emplyeeLogin

	// 회원가입
	// signUpCustomerAction.jsp 호출시
	public int insertEmployee(Connection conn, Employee paramEmployee) throws ClassNotFoundException, SQLException {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "insert INTO employee (employee_id, employee_pass, employee_name, update_date, create_date)"
				+ " values (?, password(?), ?, now(), now() )";
		/*
		 * insert INTO employee (employee_id, employee_pass, employee_name, update_date, create_date)
		 * values (?, password(?), ?, now(), now() )
		 */
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("insertEmployee DB- 연결");

		try {
			// 쿼리 담고 값 설정
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			stmt.setString(3, paramEmployee.getEmployeeName());
			// 디버깅
			System.out.println("insertEmployee - stmt : " + stmt);

			row = stmt.executeUpdate();
			// 디버깅
			if (row != 0) {
				System.out.println("insertEmployee - EmployeeDao 쿼리 성공!");
			}

		} finally {
			// DB 자원해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	} // end insertEmployee
	
	// 관리자 멤버 리스트
	public List<Map<String, Object>> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws ClassNotFoundException, SQLException{
		// 리턴값 반환할 객체
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = "select employee_id employeeId, employee_pass employeePass, employee_name employeeName, create_date createDate, update_date updateDate, active from employee ORDER BY create_date DESC limit ?,?";

		// DB 연결
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("EmployeeDao - selectEmployeeList DB- 연결");

		try {
			// 쿼리 넣기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("selectEmployeeList : " + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("employeeId", rs.getString("employeeId"));
				map.put("employeePass", rs.getString("employeePass"));
				map.put("employeeName", rs.getString("employeeName"));
				map.put("createDate", rs.getString("createDate"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("active", rs.getString("active"));
				list.add(map);
				// 디버깅
				System.out.println("Map<String, Object> map : " + map);
			}
		} finally {
			// DB 자원해제
			rs.close();
			stmt.close();
		}
		return list;
	} // end selectEmployeeList
	
	// 관리자 멤버 수정
	public int updateMember(Connection conn , String employeeId, String active) throws ClassNotFoundException, SQLException {
		// 리턴값 반환 변수
		int memberActive = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		// 쿼리
		String sql = "UPDATE employee SET active= ? WHERE  employee_id = ?";
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("EmployeeDao - modifyMember - DB 연결");
		
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// ? 값 설정
			stmt.setString(1, active);
			stmt.setString(2, employeeId);
			// 디버깅
			System.out.println("EmployeeDao - modifyMember : " + stmt);
			// 쿼리 실행
			memberActive = stmt.executeUpdate();
			// 디버깅	
			 if(memberActive != 0) {
				 System.out.println("EmployeeDao - memberActive " + memberActive);
				 System.out.println("EmployeeDao - modifyMember 성공! ");
			 }
		}finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return memberActive;
	} // end modifyMember
	
	// 마지막 페이지
	public int lastPage(int rowPerPage, int currentPage) throws Exception {
		// 리턴값 반환 변수
		int lastPage = 0;
		// 전체 멤버 수
		int totalRow = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM employee";
		
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("EmployeeDao - DB 연결");
		
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("EmployeeDao - lastPage : " + stmt);
			
			// 전체 행의 수를 구하기 위한 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count(*)");
			}
			
			// 디버깅
			System.out.println("EmployeeDao - totalRow  : " + totalRow );
			System.out.println("EmployeeDao - rowPerPage  : " + rowPerPage );
			// 마지막 페이지 
			lastPage = totalRow / rowPerPage ;
			// 페이지가 rowPerPage로 나눠떨어지지 않아도 페이지 구현을 위해 1개 추가
			if (totalRow % rowPerPage != 0) {
				lastPage += 1;
			}

			// 디버깅
			System.out.println("EmployeeDao - lastPage : " + lastPage);
			
		}finally {
			if(stmt != null) {
				stmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		}
		return lastPage;		
	} // end lastPage
} // end Employee
