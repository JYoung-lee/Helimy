package helimy.project.model;

public class MembershipDTO {
	private Integer membership;	// 회원권고유번호
	private String id;			// 회원아이디
	private Integer francode;	// 가맹점코드
	private Integer itemcode;	// 상품코드
	private String startday;		// 상품 시작일
	private String endday;		// 상품 종료일
	private String state;		// 상태 on/stop/end
	private String opt;			// 옵션 해당매장 부가서비스입력란
	private String etc;			// 비고
	
	public Integer getMembership() {
		return membership;
	}
	public void setMembership(Integer membership) {
		this.membership = membership;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getFrancode() {
		return francode;
	}
	public void setFrancode(Integer francode) {
		this.francode = francode;
	}
	public Integer getItemcode() {
		return itemcode;
	}
	public void setItemcode(Integer itemcode) {
		this.itemcode = itemcode;
	}
	public String getStarday() {
		return startday;
	}
	public void setStarday(String starday) {
		this.startday = starday;
	}
	public String getEndday() {
		return endday;
	}
	public void setEndday(String endday) {
		this.endday = endday;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}

	
}
