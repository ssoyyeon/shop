package vo;

public class Cart {
	private int goodsNo;
	private String customerId;
	private int cartQuantity;
	private String updateDate;
	private String createDate;
	
	public Cart(int goodsNo, String customerId, int cartQuantity, String updateDate, String createDate) {
		super();
		this.goodsNo = goodsNo;
		this.customerId = customerId;
		this.cartQuantity = cartQuantity;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	
	public Cart() {
		super();
	}

	
	
	@Override
	public String toString() {
		return "Cart [goodsNo=" + goodsNo + ", customerId=" + customerId + ", cartQuantity=" + cartQuantity
				+ ", updateDate=" + updateDate + ", createDate=" + createDate + "]";
	}

	public int getGoodsNo() {
		return goodsNo;
	}

	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public int getCartQuantity() {
		return cartQuantity;
	}

	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
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
	
	
}
