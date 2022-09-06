package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.CustomerDao;
import repository.DBUtil;
import repository.OrdersDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {

	// 고객1 개인정보
	public Customer selecCustomerOne(String customerId) throws Exception {
		// 리턴값 반환할 객체
		Customer customer = new Customer();
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService - selectCustomerOne - DB 연결");

			// 메서드 호출을 위한 객체 생성
			CustomerDao customerDao = new CustomerDao();

			customer = customerDao.getCustomerOne(conn, customerId);

			// 비밀번호 수정 실패시 오류 생성
			if (customer == null) {
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
		return customer;
	} // end selecCustomerOne

	// 고객 강제 탈퇴
	public int deleteCustomerById(String customerId) throws Exception {
		// 리턴값 반환할 변수
		int customer = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService deleteCustomerById - DB 연결");

			// 자동커밋 방지
			conn.setAutoCommit(false);
			
			// 메서드 호출을 위한 객체 생성
			CustomerDao customerDao = new CustomerDao();
			// 탈퇴 메서드 실행
			customer = customerDao.removeCustomerById(conn, customerId);

			// 탈퇴한 아이디를 넣는 메서드를 호출하는 객체를 생성하고 실행
			OutIdDao outIdDao = new OutIdDao();
			// 탈퇴 아이디 입력 실패했다면 throw 예외 생성 후 처리
			if (outIdDao.insertOutId(conn, customerId) == 0) {
				throw new Exception();
			}
			// 비밀번호 수정 실패시 오류 생성
			if (customer == 0) {
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
		return customer;
	} // end deleteCustomerById

	// 비밀번호 수정
	public int modifyCustomerPw(Customer paracustomer) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService modifyCustomerPw - DB 연결");

			// 메서드 호출을 위한 객체 생성
			CustomerDao customerDao = new CustomerDao();

			row = customerDao.updateCustomerPw(conn, paracustomer);

			// 비밀번호 수정 실패시 오류 생성
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
	} // end modifyCustomerPw

	// 마지막 페이지
	public int lastPage(int rowPerPage, int currentPage) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			CustomerDao customerDao = new CustomerDao();

			// lastPage 구하는 메서드 호출
			row = customerDao.lastPage(rowPerPage, currentPage);

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

	// 고객 정보 수정
	// 비밀번호 수정
	public int modifyCustomer(Customer paracustomer) throws Exception {
		// 리턴값 반환할 변수
		int row = 0;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService modifyCustomer - DB 연결");

			// 메서드 호출을 위한 객체 생성
			CustomerDao customerDao = new CustomerDao();

			row = customerDao.updateCustomer(conn, paracustomer);

			// 고객 정보 수정 실패시 오류 생성
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
	} // end modifyCustomer
	
	// 고객 리스트
	public List<Map<String, Object>> selecCustomerList(int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null;
		CustomerDao customerDao = null;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("selecCustomerList - DB 연결");

			// 시작하는 행
			int beginRow = (currentPage - 1) * rowPerPage;

			customerDao = new CustomerDao();
			list = new ArrayList<Map<String, Object>>();
			// 리스트 조회 메서드 호출할 객체 생성 후 쿼리 실행
			list = customerDao.selecCustomerList(conn, rowPerPage, beginRow);

			// 리스트 조회 메서드 실패시 throw 예외 생성 후 처리
			if (list == null) {
				System.out.println(" selecCustomerList 실패 ");
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

	// 회원탈퇴
	// 탈퇴하기 위해서는 외래키로 묶여있는 cart, orders 먼저 삭제 해야 함.
	public boolean removeCustomer(Customer paramCustomer) {
		// 예외를 보고하는게 throws, 스스로 예외처리가 try,catch
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteUpdate() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println("removeCustomer - DB 연결");

			// cart 삭제 메서드 호출
			/*
			 * // 장바구니 삭제 메서드 호출 CartDao.deletecartList(conn, getgoodsNo, customerId);
			 * 
			 * // orders 삭제 메서드 호출 OrdersDao.deleteCustomerOrder(conn, orderNo);
			 */
			// customer 메서드를 호출하는 객체를 생성
			CustomerDao customerDao = new CustomerDao();

			// 실행
			customerDao.deleteCustomer(conn, paramCustomer);
			// 디버깅
			System.out.println("remove result" + customerDao.deleteCustomer(conn, paramCustomer));

			// 아이디 탈퇴 실패했다면 throw를 생성해 던짐.
			if (customerDao.deleteCustomer(conn, paramCustomer) == 0) {
				throw new Exception();
			} else { // 탈퇴 성공시
				// 탈퇴한 아이디를 넣는 메서드를 호출하는 객체를 생성하고 실행
				OutIdDao outIdDao = new OutIdDao();
				// 탈퇴 아이디 입력 실패했다면 throw 예외 생성 후 처리
				if (outIdDao.insertOutId(conn, paramCustomer.getCustomerId()) == 0) {
					throw new Exception();
				}
			}
			// 디버깅
			System.out.println("removeCustomer - paramCustomer.getCustomerId() : " + paramCustomer.getCustomerId());
			
			// 커밋
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
	} // end remeveCustomer

	// loginAction.jsp 호출
	public Customer customerLogin(Customer paramCustomer) throws ClassNotFoundException, SQLException {
		Customer customer = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteQuery() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println("customerLogin - DB 연결");

			// 쿼리 실행할 객체 생성
			CustomerDao customerDao = new CustomerDao();
			// 로그인 메서드 호출할 객체 생성 후 쿼리 실행
			customer = customerDao.customerLogin(conn, paramCustomer);

			// 로그인 실패시 throw 예외 생성 후 처리
			if (customerDao.customerLogin(conn, paramCustomer) == null) {
				throw new Exception();
			}
			// 커밋
			conn.commit();
		} catch (Exception e) {
			// console에 예외메세지 출력
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				// conn.rollback() 오류 시 console에 예외메세지 출력
				e1.printStackTrace();
			}
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return customer;
	} // end customerLogin

	// 회원가입
	// signUpCustomerAction.jsp 호출시
	public int addCustomer(Customer paramCustomer) throws SQLException {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("addCustomer - DB 연결");
			// 쿼리 실행할 객체 생성
			CustomerDao customerDao = new CustomerDao();
			// 쿼리 실행
			row = customerDao.insertCustomer(conn, paramCustomer);
			// 아이디 탈퇴 실패했다면 throw를 생성해 던짐.
			if (row == 0) {
				throw new Exception();
			} else {
				System.out.println("addCustomer - CustomerService 성공!");
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
	} // end addCustomer

} // end CustomerService