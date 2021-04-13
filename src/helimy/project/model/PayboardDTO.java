package helimy.project.model;

import java.sql.Timestamp;

public class PayboardDTO {	
	private Integer productcode;
	private Integer paymentcode;
	private String id;
	private Timestamp reg;
	public Integer getProductcode() {
		return productcode;
	}
	public void setProductcode(Integer productcode) {
		this.productcode = productcode;
	}
	public Integer getPaymentcode() {
		return paymentcode;
	}
	public void setPaymentcode(Integer paymentcode) {
		this.paymentcode = paymentcode;
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
}
