package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import vo.GoodsImg;

public class GoodsImgDao {
	
	// 상품 이미지 삭제하기
	public int removeGoodsImg(Connection conn, int goodsNo) throws Exception {
		int row = 0;
		String sql = "delete from goods_img where goods_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {	
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println("GoodsImgDao - removeGoodsImg - stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
			// 디버깅
			if(row != 0) {
				System.out.println("GoodsImgDao - removeGoodsImg 삭제 성공");
			}
			
		}finally{
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}	
			return row;
	} // end removeGoodsImg
		
	
	// 상품 이미지 수정하기
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		int row = 0;
		String sql = "update goods_img set filename = ? where goods_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {	
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, goodsImg.getFilename());
			stmt.setInt(2, goodsImg.getGoodsNo());
			// 디버깅
			System.out.println("GoodsImgDao - updateGoodsImg - stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
			// 디버깅
			if(row != 0) {
				System.out.println("GoodsImgDao - updateGoodsImg  수정 성공");
			}
		}finally{
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}	
			return row;
	} // end updateGoodsImg
	
	// 상품 이미지 추가하기
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		int row = 0;
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date) VALUES (?, ?, ?, ?, NOW())";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {	
		stmt = conn.prepareStatement(sql);
		// stmt setter
		stmt.setInt(1, goodsImg.getGoodsNo());
		stmt.setString(2, goodsImg.getFilename());
		stmt.setString(3, goodsImg.getOrignFilename());
		stmt.setString(4, goodsImg.getContentFile());
		// 디버깅
		System.out.println("GoodsImgDao insertGoodsImg stmt : " + stmt);
		
		
		// 쿼리실행
		row = stmt.executeUpdate();
		
		}finally{
			// DB 자원해제
			if (stmt != null) { try { stmt.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
			
			return row;
	} // end insertGoodsImg

}

