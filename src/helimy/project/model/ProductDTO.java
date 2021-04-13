package helimy.project.model;

public class ProductDTO {
	private Integer productcode;	// 상품코드
	private String productname;		// 상품명
	private Integer price;			// 가격
	private Integer francode;		// 가맹점코드
	
	public Integer getProductcode() {
		return productcode;
	}
	public void setProductcode(Integer productcode) {
		this.productcode = productcode;
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
	public Integer getFrancode() {
		return francode;
	}
	public void setFrancode(Integer francode) {
		this.francode = francode;
	}
	
}
