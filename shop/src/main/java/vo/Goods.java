package vo;

public class Goods {
	// 정보은닉
	private GoodsImg goodImg;
	private int goodsNo;
	private String goodsName;
	private String goodsPrice;
	private String updateDate;
	private String createDate;
	private String soldOut;

	@Override
	public String toString() {
		return "Goods [goodImg=" + goodImg + ", goodsNo=" + goodsNo + ", goodsName=" + goodsName + ", goodsPrice="
				+ goodsPrice + ", updateDate=" + updateDate + ", createDate=" + createDate + ", soldOut=" + soldOut
				+ "]";
	}
	// 캡슐화
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getSoldOut() {
		return soldOut;
	}
	public void setSoldOut(String soldOut) {
		this.soldOut = soldOut;
	}
	public GoodsImg getGoodImg() {
		return goodImg;
	}
	public void setGoodImg(GoodsImg goodImg) {
		this.goodImg = goodImg;
	}
}
