package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;
import vo.Review;

public class GoodsDao {

	// 상품 삭제
	public int removeGoods(Connection conn, int goodsNo) throws Exception {
		// 리턴 반환 변수
		int goods = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		String sql = "DELETE FROM goods WHERE goods_no = ?";

		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("GoodsDao - removeGoods DB 연결 성공!!!!!!!!!!");
		try {
			stmt = conn.prepareStatement(sql);
			// ?값 설정
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println("GoodsDao - removeGoods - stmt : " + stmt);

			// 쿼리 실행
			goods = stmt.executeUpdate();
			// 디버깅
			if (goods == 0) {
				System.out.println("GoodsDao - removeGoods 오류");
			} else {
				System.out.println("GoodsDao - removeGoods 삭제 성공");
			}
		} finally {
			// DB 자원해제
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return goods;
	} // end removeGoods

	// 상품정보 수정하기
	public int updateGoods(Connection conn, Goods paragoods) throws SQLException {
		// 리턴 반환 변수
		int goods = 0;
		PreparedStatement stmt = null;
		String sql = "UPDATE goods SET goods_name = ?, goods_price = ? , update_date = now(), sold_out = ? where goods_no = ?";
		/*
		 * UPDATE goods SET goods_name = ?, goods_price = ? , update_date = now(),
		 * sold_out = ? where goods_no = ?;
		 */
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("GoodsDao - updateGoods - DB 연결 성공!");
			// ? 값 설정
			stmt.setString(1, paragoods.getGoodsName());
			stmt.setString(2, paragoods.getGoodsPrice());
			stmt.setString(3, paragoods.getSoldOut());
			stmt.setInt(4, paragoods.getGoodsNo());

			// 디버깅
			System.out.println("updateGoods - stmt : " + stmt);

			goods = stmt.executeUpdate();

		} finally {
			// DB 자원해제
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return goods;
	} // end updateGoods

	// 검색어로 상품 검색
	public List<Map<String, Object>> selectCutomerGoodsListBySearch(Connection conn, int rowPerPage, int beginRow,
			String word) throws SQLException {
		// 리턴 반환 객체
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
				+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
				+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
				+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
				+ " WHERE goods_name LIKE ?" + " ORDER BY IFNULL(t.sumNum, 0) DESC limit ?,?";

		// 디버깅
		System.out.println("selectCutomerGoodsListBySearch : " + word);

		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("GoodsDao - selectCutomerGoodsListBySearch - DB 연결 성공!");
			// ? 값 설정
			stmt.setString(1, "%" + word + "%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 디버깅
			System.out.println("selectCutomerGoodsListBySearch - stmt : " + stmt);

			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getString("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getString("goodsPrice"));
				map.put("filename", rs.getString("filename"));
				map.put("soldOut", rs.getString("soldOut"));
				list.add(map);
				// 디버깅
				System.out.println("selectCutomerGoodsListBySearch - list : " + list);
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	} // end selectCutomerGoodsListBySearch

	// 카테고리별 상품 검색
	public List<Map<String, Object>> selectCutomerGoodsListByCategory(Connection conn, int rowPerPage, int beginRow,
			String category) throws SQLException {
		// 리턴 반환 객체
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리
		String sql = null;

		if (category != null) {
			sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
					+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
					+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
					+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
					+ " WHERE goods_name LIKE '%?%'" + " ORDER BY IFNULL(t.sumNum, 0) DESC limit ?,?";
		} else {

		}
		// 디버깅
		System.out.println("selectCutomerGoodsListByCategory : " + category);

		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("GoodsDao - selectCutomerGoodsListByCategory - DB 연결 성공!");
			// ? 값 설정
			stmt.setString(1, category);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 디버깅
			System.out.println("selectCutomerGoodsListByCategory - stmt : " + stmt);

			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getString("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getString("goodsPrice"));
				map.put("filename", rs.getString("filename"));
				map.put("soldOut", rs.getString("soldOut"));
				list.add(map);
				// 디버깅
				System.out.println("selectCutomerGoodsListByCategory - list : " + list);
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	} // end selectCutomerGoodsListByCategory

	// 고객 전체 상품리스트 페이지에서 사용 - customerGoodsList.jsp
	public List<Map<String, Object>> selectCutomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow,
			String goodsListSort, String category, String kind) throws SQLException {
		// 리턴 반환 객체
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;

		// 디버깅
		System.out.println("GoodsListSort : " + goodsListSort);
		System.out.println("category : " + category);
		System.out.println("kind : " + kind);

		// 카테고리 o 종류 o
		if (category != null && kind != null) {
			// GoodsListSort 값에 따라서 쿼리가 달라짐
			if (goodsListSort.equals("Best")) {
				// 판매순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? and goods_name like ? ORDER BY IFNULL(t.sumNum, 0) DESC limit ?,?";
			} else if (goodsListSort.equals("High")) {
				// 높은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? and goods_name like ? ORDER BY goodsPrice DESC limit ?,?";
			} else if (goodsListSort.equals("Low")) {
				// 낮은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? and goods_name like ? ORDER BY goodsPrice ASC limit ?,?";
			} else if (goodsListSort.equals("Latest")) {
				// 최근 등록순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, g.create_date createDate, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? and goods_name like ? ORDER BY createDate DESC limit ?,?";
			} else {
				// GoodsListSort == 'all'
				// 상품 번호순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? and goods_name like ? ORDER BY goodsNo ASC LIMIT ?,?";
			}

			try {
				stmt = conn.prepareStatement(sql);
				// 디버깅
				System.out.println("GoodsDao - selectCutomerGoodsListByPage - DB 연결 성공!");
				// ? 값 설정
				stmt.setString(1, "%" + category + "%");
				stmt.setString(2, "%" + kind + "%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
				// 디버깅
				System.out.println("selectCutomerGoodsListByPage - stmt : " + stmt);

				rs = stmt.executeQuery();

				while (rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("goodsNo", rs.getString("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getString("goodsPrice"));
					map.put("filename", rs.getString("filename"));
					map.put("soldOut", rs.getString("soldOut"));
					list.add(map);
					// 디버깅
					System.out.println("selectCutomerGoodsListByPage - list : " + list);
				}
			} finally {
				// DB 자원해제
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			}
		}
		// 카테고리 o 종류 x
		else if (category != null && kind == null) {
			// GoodsListSort 값에 따라서 쿼리가 달라짐
			if (goodsListSort.equals("Best")) {
				// 판매순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ?  ORDER BY IFNULL(t.sumNum, 0) DESC limit ?,?";
			} else if (goodsListSort.equals("High")) {
				// 높은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY goodsPrice DESC limit ?,?";
			} else if (goodsListSort.equals("Low")) {
				// 낮은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY goodsPrice ASC limit ?,?";
			} else if (goodsListSort.equals("Latest")) {
				// 최근 등록순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, g.create_date createDate, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY createDate DESC limit ?,?";
			} else {
				// GoodsListSort == 'all'
				// 상품 번호순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY goodsNo ASC LIMIT ?,?";
			}

			try {
				stmt = conn.prepareStatement(sql);
				// 디버깅
				System.out.println("GoodsDao - selectCutomerGoodsListByPage - DB 연결 성공!");
				// ? 값 설정
				stmt.setString(1, "%" + category + "%");
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
				// 디버깅
				System.out.println("selectCutomerGoodsListByPage - stmt : " + stmt);

				rs = stmt.executeQuery();

				while (rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("goodsNo", rs.getString("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getString("goodsPrice"));
					map.put("filename", rs.getString("filename"));
					map.put("soldOut", rs.getString("soldOut"));
					list.add(map);
					// 디버깅
					System.out.println("selectCutomerGoodsListByPage - list : " + list);
				}
			} finally {
				// DB 자원해제
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			}
		}
		// 카테고리 x 종류 o
		else if (category == null && kind != null) {
			// GoodsListSort 값에 따라서 쿼리가 달라짐
			if (goodsListSort.equals("Best")) {
				// 판매순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ?  ORDER BY IFNULL(t.sumNum, 0) DESC limit ?,?";
			} else if (goodsListSort.equals("High")) {
				// 높은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY goodsPrice DESC limit ?,?";
			} else if (goodsListSort.equals("Low")) {
				// 낮은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY goodsPrice ASC limit ?,?";
			} else if (goodsListSort.equals("Latest")) {
				// 최근 등록순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, g.create_date createDate, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY createDate DESC limit ?,?";
			} else {
				// GoodsListSort == 'all'
				// 상품 번호순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " where goods_name like ? ORDER BY goodsNo ASC LIMIT ?,?";
			}

			try {
				stmt = conn.prepareStatement(sql);
				// 디버깅
				System.out.println("GoodsDao - selectCutomerGoodsListByPage - DB 연결 성공!");
				// ? 값 설정
				stmt.setString(1, "%" + kind + "%");
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
				// 디버깅
				System.out.println("selectCutomerGoodsListByPage - stmt : " + stmt);

				rs = stmt.executeQuery();

				while (rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("goodsNo", rs.getString("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getString("goodsPrice"));
					map.put("filename", rs.getString("filename"));
					map.put("soldOut", rs.getString("soldOut"));
					list.add(map);
					// 디버깅
					System.out.println("selectCutomerGoodsListByPage - list : " + list);
				}
			} finally {
				// DB 자원해제
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			}
		}
		// 카테고리 x 종류 x
		else if (category == null && kind == null) {
			// GoodsListSort 값에 따라서 쿼리가 달라짐
			if (goodsListSort.equals("Best")) {
				// 판매순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " ORDER BY IFNULL(t.sumNum, 0) DESC limit ?,?";
			} else if (goodsListSort.equals("High")) {
				// 높은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " ORDER BY goodsPrice DESC limit ?,?";
			} else if (goodsListSort.equals("Low")) {
				// 낮은 가격순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " ORDER BY goodsPrice ASC limit ?,?";
			} else if (goodsListSort.equals("Latest")) {
				// 최근 등록순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, g.create_date createDate, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " ORDER BY createDate DESC limit ?,?";
			} else {
				// goodsListSort == 'all'
				// 상품 번호순
				sql = "SELECT g.goods_no goodsNo, g.sold_out soldOut, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename"
						+ ", ifNull(t.sumNum, 0) sumNum" + " FROM goods g LEFT JOIN"
						+ " (SELECT goods_no, Sum(order_quantity) sumNum" + " FROM orders GROUP BY goods_no) t"
						+ " ON g.goods_no = t.goods_no" + " INNER JOIN goods_img gi" + " ON g.goods_no = gi.goods_no"
						+ " ORDER BY goodsNo ASC LIMIT ?,?";
			}

			try {
				stmt = conn.prepareStatement(sql);
				// 디버깅
				System.out.println("GoodsDao - selectCutomerGoodsListByPage - DB 연결 성공!");
				// ? 값 설정
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				// 디버깅
				System.out.println("selectCutomerGoodsListByPage - stmt : " + stmt);

				rs = stmt.executeQuery();

				while (rs.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("goodsNo", rs.getString("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getString("goodsPrice"));
					map.put("filename", rs.getString("filename"));
					map.put("soldOut", rs.getString("soldOut"));
					list.add(map);
					// 디버깅
					System.out.println("selectCutomerGoodsListByPage - list : " + list);
				}
			} finally {
				// DB 자원해제
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			}
		}
		return list;
	} // end selectCutomerGoodsListByPage

	// 반환값 : key값 (jdbc api)
	public int insertGoods(Connection conn, Goods goods) throws SQLException {
		// 리턴 반환 변수
		int keyId = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date, sold_out) VALUES (?,?,now(),now(),?)";
		try {
			// 쿼리 실행
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			// RETURN_GENERATED_KEYS == 1 --> 1), 2)의 쿼리 실행
			// 1) insert
			// 2) select last_ai_kwy from...
			// ? 값 설정
			stmt.setString(1, goods.getGoodsName());
			stmt.setString(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			// 디버깅
			System.out.println("\ninsertGoods - stmt : " + stmt);

			stmt.executeUpdate();
			rs = stmt.getGeneratedKeys(); // select last_key
			if (rs.next()) {
				keyId = rs.getInt(1);
			}
		} finally {
			// DB 자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		// 디버깅
		System.out.println("\ninsertGoods - keyId : " + keyId);
		return keyId;
	} // end insertGoods

	// lastPage 페이지 구하기 메서드
	public int lastPageByCutomer(Connection conn, int rowPerPage, int beginRow, String kind, String category)
			throws ClassNotFoundException, SQLException {
		// 리턴 반환 변수
		int lastPage = 0;
		// 전체 행의 수
		int totalRow = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		String sql = null;

		conn = dbUtil.getConnection();
		// 디버깅
		System.err.println("goodsDao - lastPageByCutomer DB 연결");
		System.err.println("goodsDao - kind : " + kind);
		System.err.println("goodsDao - category : " + category);

		// 종류 유무에 따라 쿼리가 달라짐.
		// 카테고리 o 종류 o
		if (category != null && kind != null) {
			sql = "select count(*) from goods where goods_name LIKE ? and goods_name LIKE ?";
			try {
				stmt = conn.prepareStatement(sql);
				// ? 값 setter
				stmt.setString(1, "%" + kind + "%");
				stmt.setString(2, "%" + category + "%");
				// 전체 행의 수를 구하기 위한 쿼리 실행
				rs = stmt.executeQuery();
				if (rs.next()) {
					totalRow = rs.getInt("count(*)");
				}
				// 디버깅
				System.out.println("totalRow  : " + totalRow);

				// 마지막 페이지
				lastPage = totalRow / rowPerPage;
				// 페이지의 수가 rowPerPage로 딱 나눠 떨어지지 않는다면 마지막 페이지 수를 1개 더해준다.
				if (totalRow % rowPerPage != 0) {
					lastPage += 1;
				}
			} finally {
				// 자원해제
				rs.close();
				stmt.close();
			}
		}
		// 카테고리 x 종류 o
		else if (category == null && kind != null) {
			sql = "select count(*) from goods where goods_name LIKE ? ";
			try {
				stmt = conn.prepareStatement(sql);
				// ? 값 setter
				stmt.setString(1, "%" + kind + "%");
				// 전체 행의 수를 구하기 위한 쿼리 실행
				rs = stmt.executeQuery();
				if (rs.next()) {
					totalRow = rs.getInt("count(*)");
				}
				// 디버깅
				System.out.println("totalRow  : " + totalRow);

				// 마지막 페이지
				lastPage = totalRow / rowPerPage;
				// 페이지의 수가 rowPerPage로 딱 나눠 떨어지지 않는다면 마지막 페이지 수를 1개 더해준다.
				if (totalRow % rowPerPage != 0) {
					lastPage += 1;
				}
			} finally {
				// 자원해제
				rs.close();
				stmt.close();
			}
		} // 카테고리 o 종류 x
		else if (category != null && kind == null) {
			sql = "select count(*) from goods where goods_name LIKE ?";
			try {
				stmt = conn.prepareStatement(sql);
				// ? 값 setter
				stmt.setString(1, "%" + category + "%");
				// 전체 행의 수를 구하기 위한 쿼리 실행
				rs = stmt.executeQuery();
				if (rs.next()) {
					totalRow = rs.getInt("count(*)");
				}
				// 디버깅
				System.out.println("totalRow  : " + totalRow);

				// 마지막 페이지
				lastPage = totalRow / rowPerPage;
				// 페이지의 수가 rowPerPage로 딱 나눠 떨어지지 않는다면 마지막 페이지 수를 1개 더해준다.
				if (totalRow % rowPerPage != 0) {
					lastPage += 1;
				}
			} finally {
				// 자원해제
				rs.close();
				stmt.close();
			}
		} // 카테고리 x 종류 x
		else {
			sql = "select count(*) from goods";
			try {
				stmt = conn.prepareStatement(sql);
				// 전체 행의 수를 구하기 위한 쿼리 실행
				rs = stmt.executeQuery();
				if (rs.next()) {
					totalRow = rs.getInt("count(*)");
				}
				// 디버깅
				System.out.println("totalRow  : " + totalRow);

				// 마지막 페이지
				lastPage = totalRow / rowPerPage;
				// 페이지의 수가 rowPerPage로 딱 나눠 떨어지지 않는다면 마지막 페이지 수를 1개 더해준다.
				if (totalRow % rowPerPage != 0) {
					lastPage += 1;
				}
			} finally {
				// 자원해제
				rs.close();
				stmt.close();
			}
		}
		return lastPage;
	} // end lastPageByCutomer

	// 마지막 페이지
		public int lastPage(Connection conn, final int ROW_PER_PAGE) throws ClassNotFoundException, SQLException  {
			// 리턴값 반환할 변수
			int lastPage = 0;
			// 전체 게시물 수 
			int totalRow = 0;
			// DB 자원
			DBUtil dbUtil = new DBUtil();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT count(*) FROM goods";

			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsDao - lastPage DB 연결 성공!!!!!!!!!!");

			try {
				stmt = conn.prepareStatement(sql);
				// 쿼리 실행
				rs = stmt.executeQuery();

				// 전체 행의 수를 구하기 위한 쿼리 실행
				if (rs.next()) {
					totalRow += rs.getInt("count(*)");
					// 디버깅
					System.out.println("GoodsDao - totalRow  : " + totalRow);
				}

				// 마지막 페이지 구하기
				lastPage = totalRow / ROW_PER_PAGE;
				// 마지막페이지가 rowPerPage로 떨어지지 않을 떼
				if (totalRow % ROW_PER_PAGE != 0) {
					lastPage += 1;
				}

				// 디버깅
				System.out.println("GoodsDao - lastPage : " + lastPage);
			} finally {
				// DB 자원해제
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (stmt != null) {
					try {
						stmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			//
			return lastPage;
		} // end lastPage
	
	// 관리자용 상품 조회
	public List<Goods> selectGoodsListbyPage(Connection conn, int rowPerPage, int beginRow)
			throws ClassNotFoundException, SQLException {
		// 리턴 반환 할 객체
		List<Goods> list = new ArrayList<Goods>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		/*
		 * select good_no goodNo from goods order by goods_no desc limit ?,?
		 */
		String sql = "select goods_no, goods_name, goods_price, create_date, update_date, sold_out from goods order by goods_no asc limit ?,?";

		// DB 연결
		// 동일한 conn를 사용해야 하기 때문에 매개변수로 conn을 받아옴.
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("selectGoodsListbyPage -  DB 연결");

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("selectGoodsListbyPage - stmt" + stmt);

			rs = stmt.executeQuery();
			while (rs.next()) {
				Goods goods = new Goods();
				// 데이터 값 설정
				goods.setGoodsNo(rs.getInt("goods_no"));
				goods.setGoodsName(rs.getString("goods_name"));
				goods.setGoodsPrice(rs.getString("goods_price"));
				goods.setCreateDate(rs.getString("create_date"));
				goods.setUpdateDate(rs.getString("update_date"));
				goods.setSoldOut(rs.getString("sold_out"));
				list.add(goods);
				// 디버깅
				System.out.println(goods);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원해제
			rs.close();
			stmt.close();
		}
		return list;
	} // end selectGoodsListbyPage

	// 상품 상세보기
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo)
			throws ClassNotFoundException, SQLException {
		Map<String, Object> map = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out SoldOut, gi.filename filename, g.create_date createDate"
				+ " FROM goods g inner join goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		conn = dbUtil.getConnection();
		// 디버깅
		System.out.println("selectGoodsAndImgOne -  DB 연결");
		try {
			stmt = conn.prepareStatement(sql);
			// ? setter
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println("selectGoodsAndImgOne - stmt" + stmt);

			// 쿼리 실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				map = new HashMap<>();
				map.put("goodsNo", goodsNo);
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getString("goodsPrice"));
				map.put("soldOut", rs.getString("SoldOut"));
				map.put("filename", rs.getString("filename"));
				map.put("createDate", rs.getString("createDate"));
			}
			// 디버깅
			if (map != null) {
				System.out.println(" GoodsDao - selectGoodsAndImgOne 성공!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원해제
			rs.close();
			stmt.close();
		}
		return map;
	} // end selectGoodsAndImgOne
}