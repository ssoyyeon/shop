package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.DBUtil;
import repository.EmployeeDao;
import repository.NoticeDao;
import repository.OutIdDao;
import vo.Customer;
import vo.Employee;

public class EmployeeService {

	// admin active 체크
	public String activeCk(String employeeId) {
		String actionCk = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("addEmployee - DB 연결");
			// 쿼리 실행할 객체 생성
			EmployeeDao employeeDao = new EmployeeDao();
			// 쿼리 실행
			actionCk = employeeDao.activeCk(conn, employeeId);
			// 아이디 탈퇴 실패했다면 throw를 생성해 던짐.
			if (actionCk == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return actionCk;
	}

	// 회원가입
	// signUpEmployeeAction.jsp 호출시
	public int addEmployee(Employee paramEmployee) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("addEmployee - DB 연결");
			// 쿼리 실행할 객체 생성
			EmployeeDao employeeDao = new EmployeeDao();
			// 쿼리 실행
			row = employeeDao.insertEmployee(conn, paramEmployee);
			// 아이디 탈퇴 실패했다면 throw를 생성해 던짐.
			if (row == 0) {
				throw new Exception();
			} else {
				System.out.println("addEmployee - EmployeeService 성공!");
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				// DB 자원해제
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	} // end addEmployee

	// 회원탈퇴
	public boolean removeEmployee(Employee paramEmployee) {
		// 예외를 보고하는게 throws, 스스로 예외처리가 try,catch
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteUpdate() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println("removeCustomer - DB 연결");

			// 아이디 탈퇴 메서드를 호출하는 객체를 생성하고 실행
			EmployeeDao employeeDao = new EmployeeDao();
			employeeDao.deleteEmployee(conn, paramEmployee);

			// 아이디 탈퇴 성공시에만 탈퇴 아이디 입력
			if (employeeDao.deleteEmployee(conn, paramEmployee) == 1) {
				// 아이디 탈퇴 실패했다면 throw를 생성해 던짐.
				throw new Exception();
			}
			// 탈퇴한 아이디를 넣는 메서드를 호출하는 객체를 생성하고 실행
			OutIdDao outIdDao = new OutIdDao();
			// 탈퇴 아이디 입력에 실패했다면 throw를 생성해 던짐.
			if (outIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			// console에 예외메세지 출력
			e.printStackTrace();
			try {
				// 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; // 탈퇴 실패
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true; // 탈퇴 성공
	} // end removeEmployee

	// employee Login
	public Employee employeeLogin(Employee paramEmployee) throws ClassNotFoundException, SQLException {
		Employee employee = null;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteUpdate() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println("employeeLogin - DB 연결");

			// 쿼리 실행할 객체 생성
			EmployeeDao employeeDao = new EmployeeDao();
			// 로그인 메서드 호출할 객체 생성 후 쿼리 실행
			employee = employeeDao.emplyeeLogin(conn, paramEmployee);

			// 로그인 실패시 throw 예외 생성 후 처리
			if (employeeDao.emplyeeLogin(conn, paramEmployee) == null) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			// console에 예외메세지 출력
			e.printStackTrace();
			try {
				// 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}

		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return employee;
	} // end employeeLogin

	// 관리자 멤버 리스트
	public List<Map<String, Object>> selectEmployeeList(int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null;
		EmployeeDao employeeDao = null;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("selectEmployeeList - DB 연결");

			// 시작하는 행
			int beginRow = (currentPage - 1) * rowPerPage;

			employeeDao = new EmployeeDao();
			list = new ArrayList<Map<String, Object>>();
			// 리스트 조회 메서드 호출할 객체 생성 후 쿼리 실행
			list = employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);

			// 리스트 조회 메서드 실패시 throw 예외 생성 후 처리
			if (list == null) {
				System.out.println(" selectEmployeeList 실패 ");
				throw new Exception();
			}
		} catch (Exception e) {
			// console에 예외메세지 출력
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	} // end selectEmployeeList

	// 관리자 비밀번호 수정
	public int modifyMemberPw(String password, String employeeId) throws ClassNotFoundException, SQLException {
		// 리턴값 반환 변수
		int modifyMemberPw = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("modifyMemberPw - DB 연결");
			
			// 메서드 호출을 위한 객체 생성
			EmployeeDao employeeDao = new EmployeeDao();
			
			// 비밀번호 변경 메서드 호출
			modifyMemberPw = employeeDao.updateMemberPw(conn, password, employeeId);

		} catch (Exception e) {
			// console에 예외메세지 출력
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return modifyMemberPw;
	} // end modifyMemberPw
	
	// 관리자 멤버 수정
	public int modifyMember(String employeeId, String active) throws ClassNotFoundException, SQLException {
		// 리턴값 반환 변수
		int memberActive = 0;
		// DB 자원
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("selectEmployeeList - DB 연결");

			EmployeeDao employeeDao = new EmployeeDao();

			memberActive = employeeDao.updateMember(conn,employeeId,active);

		} catch (Exception e) {
			// console에 예외메세지 출력
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return memberActive;
	}

	// 마지막 페이지
	public int lastPage(int rowPerPage, int currentPage) throws Exception {
		int row = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("EmployeeService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			EmployeeDao employeeDao = new EmployeeDao();

			// lastPage 구하는 메서드 호출
			row = employeeDao.lastPage(rowPerPage, currentPage);

			// lastPage 실패시 오류 생성
			if (row == 0) {
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
		return row;
	} // end lastPage

} // end EmployeeService
