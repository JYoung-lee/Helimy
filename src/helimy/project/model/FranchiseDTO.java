package helimy.project.model;

import java.sql.Timestamp;

public class FranchiseDTO {
	private Integer francode;
	private String id;
	private String shopname;
	private String shopaddress;
	private String shopphone;
	private String weekday;
	private String sat;
	private String sun;
	private String promote;	
	private String notice;	
	private String amenity;	
	private String addservice;	
	private Integer totalnum;	
	private Integer membernum;	
	private Integer nonmemnum;	
	private Timestamp reg;
	
	public Integer getFrancode() {
		return francode;
	}
	public void setFrancode(Integer francode) {
		this.francode = francode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getShopname() {
		return shopname;
	}
	public void setShopname(String shopname) {
		this.shopname = shopname;
	}
	public String getShopaddress() {
		return shopaddress;
	}
	public void setShopaddress(String shopaddress) {
		this.shopaddress = shopaddress;
	}
	public String getShopphone() {
		return shopphone;
	}
	public void setShopphone(String shopphone) {
		this.shopphone = shopphone;
	}
	public String getWeekday() {
		return weekday;
	}
	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}
	public String getSat() {
		return sat;
	}
	public void setSat(String sat) {
		this.sat = sat;
	}
	public String getSun() {
		return sun;
	}
	public void setSun(String sun) {
		this.sun = sun;
	}
	public String getPromote() {
		return promote;
	}
	public void setPromote(String promote) {
		this.promote = promote;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getAmenity() {
		return amenity;
	}
	public void setAmenity(String amenity) {
		this.amenity = amenity;
	}
	public String getAddservice() {
		return addservice;
	}
	public void setAddservice(String addservice) {
		this.addservice = addservice;
	}
	public Integer getTotalnum() {
		return totalnum;
	}
	public void setTotalnum(Integer totalnum) {
		this.totalnum = totalnum;
	}
	public Integer getMembernum() {
		return membernum;
	}
	public void setMembernum(Integer membernum) {
		this.membernum = membernum;
	}
	public Integer getNonmemnum() {
		return nonmemnum;
	}
	public void setNonmemnum(Integer nonmemnum) {
		this.nonmemnum = nonmemnum;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
}
