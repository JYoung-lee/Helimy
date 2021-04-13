package helimy.project.model;

import java.sql.Timestamp;

public class PaymentListDTO {
   private Integer paymentcode;   // 결제코드
   private Timestamp reg;         // 결제 시간
   private String shopname;      // 매장명
   private String productname;      // 상품명
   private Integer price;         // 가격
   private String state;			//결제상태
   private String id;            // 아이디
   private Integer productcode;   // 상품코드
   private Integer francode;      // 매장코드
   
   public Integer getPaymentcode() {
      return paymentcode;
   }
   public void setPaymentcode(Integer paymentcode) {
      this.paymentcode = paymentcode;
   }
   public Timestamp getReg() {
      return reg;
   }
   public void setReg(Timestamp reg) {
      this.reg = reg;
   }
   public String getShopname() {
      return shopname;
   }
   public void setShopname(String shopname) {
      this.shopname = shopname;
   }
   public String getProductname() {
      return productname;
   }
   public void setProductname(String productname) {
      this.productname = productname;
   }
   public Integer getPrice() {
      return price;
   }
   public void setPrice(Integer price) {
      this.price = price;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public Integer getProductcode() {
      return productcode;
   }
   public void setProductcode(Integer productcode) {
      this.productcode = productcode;
   }
   public Integer getFrancode() {
      return francode;
   }
   public void setFrancode(Integer francode) {
      this.francode = francode;
   }
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}	
   
}