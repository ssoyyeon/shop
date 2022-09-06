package vo;

public class Orders {
	private int orderNo;
	private int goodsNo;
	private String customerId;
	private String orderPrice;
	private String orderAddr;
	private String detailAddr;
	private int orderQuantity;
	private String orderState;
	private String updateDate;
	private String createDate;
	

	public Orders() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Orders [orderNo=" + orderNo + ", goodsNo=" + goodsNo + ", customerId=" + customerId + ", orderPrice="
				+ orderPrice + ", orderAddr=" + orderAddr + ", detailAddr=" + detailAddr + ", orderQuantity="
				+ orderQuantity + ", orderState=" + orderState + ", updateDate=" + updateDate + ", createDate="
				+ createDate + "]";
	}

	public Orders(int orderNo, int goodsNo, String customerId, String orderPrice, String orderAddr, String detailAddr,
			int orderQuantity, String orderState, String updateDate, String createDate) {
		super();
		this.orderNo = orderNo;
		this.goodsNo = goodsNo;
		this.customerId = customerId;
		this.orderPrice = orderPrice;
		this.orderAddr = orderAddr;
		this.detailAddr = detailAddr;
		this.orderQuantity = orderQuantity;
		this.orderState = orderState;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	

	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}
	
	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
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

	public String getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(String orderPrice) {
		this.orderPrice = orderPrice;
	}

	public String getOrderAddr() {
		return orderAddr;
	}

	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
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
