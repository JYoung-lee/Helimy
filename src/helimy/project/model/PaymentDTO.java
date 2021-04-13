package helimy.project.model;

import java.sql.Timestamp;

public class PaymentDTO {
	private Integer paymentcode;	// 결제코드
	private Integer froductcode;	// 상품코드
	private String id;				// 회원 아이디
	private Timestamp reg;			// 결제 시간
	private String state;			// 상태 ( on / stop / end )
	private String canclereason;	// 취소사유
	
	public Integer getPaymentcode() {
		return paymentcode;
	}
	public void setPaymentcode(Integer paymentcode) {
		this.paymentcode = paymentcode;
	}
	public Integer getFroductcode() {
		return froductcode;
	}
	public void setFroductcode(Integer froductcode) {
		this.froductcode = froductcode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCanclereason() {
		return canclereason;
	}
	public void setCanclereason(String canclereason) {
		this.canclereason = canclereason;
	}
	
	
	
}
