package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.GoodsDao;
import repository.GoodsImgDao;
import repository.NoticeDao;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	// 트래잭션 + action이나 dao가 해서는 안되는 일
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;

	// 상품 삭제
	public int deleteGoods(int goodsNo) throws Exception {
		// 리턴 반환할 변수
		int goods = 0;
		this.goodsImgDao = new GoodsImgDao();
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService - deleteGoods DB 연결 성공!!!!!!!!!!");

			// 자동 커밋 방징
			conn.setAutoCommit(false);

			// 삭제 메서드 호출
			goods = goodsImgDao.removeGoodsImg(conn, goodsNo);

			// goodsImgDao.removeGoodsImg(conn, goodsNo) 성공시
			if (goods != 0) {
				goods = goodsDao.removeGoods(conn, goodsNo);
				// 상품 이미지 삭제를 실패한다면 오류 생성
			} else {
				throw new Exception();
			}
			// 커밋
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			conn.rollback();
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
		return goods;
	} // end deleteGoods
	// 검색어로 상품 검색
	public List<Map<String, Object>> selectCutomerGoodsListBySearch(int rowPerPage, int currentPage, String word) {
		// 리턴값 반환할 객체
		List<Map<String, Object>> map = null;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteUpdate() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println(" GoodsService - selectCutomerGoodsListBySearch - DB 연결");

			// 시작행
			int beginRow = (currentPage - 1) * rowPerPage;
			// 디버깅
			System.out.println(" GoodsService - beginRow : " + beginRow);

			// 메서드를 불러오기 위한 객체 생성 후 호출
			this.goodsDao = new GoodsDao();
			map = goodsDao.selectCutomerGoodsListBySearch(conn, rowPerPage, beginRow, word);

			// 상품리스트 출력 실패시 오류 생성
			if (map == null) {
				throw new Exception();
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
				// DB 자원해제
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	// 고객 상품 리스트 분기
	public List<Map<String, Object>> selectCutomerGoodsListByPage(int rowPerPage, int currentPage, String GoodsListSort,
			String category, String kind) {
		// 리턴값 반환할 객체
		List<Map<String, Object>> map = null;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteUpdate() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println(" GoodsService - selectCutomerGoodsListByPage - DB 연결");

			// 시작행
			int beginRow = (currentPage - 1) * rowPerPage;
			// 디버깅
			System.out.println(" GoodsService - beginRow : " + beginRow);

			// 메서드를 불러오기 위한 객체 생성 후 호출
			this.goodsDao = new GoodsDao();
			map = goodsDao.selectCutomerGoodsListByPage(conn, rowPerPage, beginRow, GoodsListSort, category, kind);

			// 상품리스트 출력 실패시 오류 생성
			if (map == null) {
				throw new Exception();
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
				// DB 자원해제
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	} // end selectCutomerGoodsListByPage

	// 카테고리별 상품 검색
	public List<Map<String, Object>> selectCutomerGoodsListByCategory(int rowPerPage, int currentPage,
			String category) {
		// 리턴값 반환할 객체
		List<Map<String, Object>> map = null;
		// DB 자원
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // excuteUpdate() 실행 시 자동 커밋을 막음
			// 디버깅
			System.out.println(" GoodsService - selectCutomerGoodsListByCategory - DB 연결");

			// 시작행
			int beginRow = (currentPage - 1) * rowPerPage;
			// 디버깅
			System.out.println(" GoodsService - beginRow : " + beginRow);

			// 메서드를 불러오기 위한 객체 생성 후 호출
			this.goodsDao = new GoodsDao();
			map = goodsDao.selectCutomerGoodsListByCategory(conn, rowPerPage, beginRow, category);

			// 상품리스트 출력 실패시 오류 생성
			if (map == null) {
				throw new Exception();
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
				// DB 자원해제
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	} // end selectCutomerGoodsListByCategory

	// 이미지 업로드
	public void addGoods(Goods goods, GoodsImg goodsImg) {
		// 메서드 사용할 객체생성
		DBUtil dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();
		int goodsNo = 0;
		Connection conn = null;

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java addGoods conn : " + conn);

			// 자동 commit 끄기
			conn.setAutoCommit(false);

			goodsNo = goodsDao.insertGoods(conn, goods); // goodsNo가 AI로 자동생성되어 DB입력

			if (goodsNo != 0) { // 0이 아니면 키가 있다는 뜻
				// 키값 setter
				goodsImg.setGoodsNo(goodsNo);

				if (goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception(); // 이미지 입력실패시 강제로 rollback(catch)절 이동
				}
			}
			conn.commit();

			// 디버깅
			System.out.println("상품을 추가하였습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			// Exception 발생시
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}
	
	// 마지막 페이지
	public int lastPage(final int ROW_PER_PAGE) throws Exception {
		int lastPage = 0;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService lastPage - DB 연결");

			// 메서드 호출을 위한 객체 생성
			GoodsDao goodsDao = new GoodsDao();

			// lastPage 구하는 메서드 호출
			lastPage = goodsDao.lastPage(conn, ROW_PER_PAGE);
			// lastPage 실패시 오류 생성
			if (lastPage == 0) {
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
		return lastPage;
	} // end lastPage

	// 고객용 상품별 마지막 페이지
	public int lastPageByCutomer(int rowPerPage, int currentPage, String kind, String category) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("Goodsservice lastPageByCutomer - DB 연결");

			// 시작행
			int beginRow = (currentPage - 1) * rowPerPage;
			// 디버깅
			System.out.println("GoodsService - beginRow : " + beginRow);
			
			// 디버깅
			System.out.println("service lastPage - kind : " + kind);
			System.out.println("service lastPage - category : " + category);
			
			// lastPage를 구하기 위한 메서드 호출
			lastPage = goodsDao.lastPageByCutomer(conn, rowPerPage, beginRow, kind, category);

			// lastPage 쿼리 실행 실패시 오류 생성
			if (lastPage == 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return lastPage;
	} // end lastPageByCutomer

	// 상품 리스트
	public List<Goods> selectGoodsListbyPage(int rowPerPage, int currentPage)
			throws ClassNotFoundException, SQLException {
		List<Goods> list = null;
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			// DB 연결
			conn = dbUtil.getConnection();
			// excuteQuery() 실행 시 자동 커밋을 막음
			conn.setAutoCommit(false);
			// 디버깅
			System.out.println("selectGoodsListbyPage - DB 연결");

			// 시작페이지
			int beginRow = (currentPage - 1) * rowPerPage;
			// 디버깅
			System.out.println("currentPage : " + currentPage);
			System.out.println("beginRow : " + beginRow);
			System.out.println("rowPerPage : " + rowPerPage);

			// 쿼리 실행
			list = goodsDao.selectGoodsListbyPage(conn, rowPerPage, beginRow);

			// list 쿼리 실행 실패시 오류 생성
			if (list == null) {
				throw new Exception();
			}
			// 커밋
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} // end finally

		return list;
	} // end selectGoodsListbyPage

	// 상품 상세보기
	public Map<String, Object> selectGoodsAndImgOne(int goodsNo) {
		Map<String, Object> goodsOne = null;
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("selectGoodsAndImgOne - DB 연결!!!!!!!!!");

			// 상세보기 메서드 호출
			GoodsDao goodsDao = new GoodsDao();
			goodsOne = goodsDao.selectGoodsAndImgOne(conn, goodsNo);

			// 상품 상세보기 실행 실패시 오류 생성
			if (goodsOne == null) {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// DB 자원해제
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			} // end finally
		}
		return goodsOne;
	} // end selectgoodsOne

	// 상품정보 수정하기
	public void modifyGoods(Goods paragoods) {
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		this.goodsImgDao = new GoodsImgDao();

		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("modifyGoods - DB 연결!!!!!!!!!");
			// 자동 커밋 방지
			conn.setAutoCommit(false);

			// 수정하기 메서드 호출
			goodsDao.updateGoods(conn, paragoods);
			/*
			 * goodsImgDao.updateGoodsImg(conn, paragoodsImg);
			 */

			// 상품 상세보기 실행 실패시 오류 생성
			if (goodsDao.updateGoods(conn, paragoods) == 0) {
				throw new Exception();
			}

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// Exception 발생시
			try {
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
		} // end finally
	} // end modifyGoods

} // end GoodsService
