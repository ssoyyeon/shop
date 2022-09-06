package vo;

public class OutId {
	// 정보은닉
	private String outId ;
	private String outDate ;
	
	// 디버깅 오버라이딩
	@Override
	public String toString() {
		return "OutId [outId=" + outId + ", outDate=" + outDate + "]";
	}

	// 캡슐화 getter, setter
	public String getOutId() {
		return outId;
	}
	public void setOutId(String outId) {
		this.outId = outId;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
} // end OutId
