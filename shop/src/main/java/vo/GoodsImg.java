package vo;

public class GoodsImg {
	// 정보은닉
	private int goodsNo;
	private String filename;
	private String orignFilename;
	private String contentFile;
	private String createDate;

	// 디버깅 Override
	@Override
	public String toString() {
		return "Goods [goodsNo=" + goodsNo + ", filename=" + filename + ", orignFilename=" + orignFilename
				+ ", contentFile=" + contentFile + ", createDate=" + createDate + "]";
	}

	// 캡슐화 getter, setter
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOrignFilename() {
		return orignFilename;
	}
	public void setOrignFilename(String orignFilename) {
		this.orignFilename = orignFilename;
	}
	public String getContentFile() {
		return contentFile;
	}
	public void setContentFile(String contentFile) {
		this.contentFile = contentFile;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

}



