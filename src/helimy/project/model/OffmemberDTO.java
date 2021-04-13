package helimy.project.model;

import java.sql.Timestamp;

public class OffmemberDTO {
	private Integer offmemnum;	// 오프라인회원 번호
	private String name;		// 오프라인회원 이름
	private String birth;		// 오프라인회원 생일
	private String gender;		// 오프라인회원 성별
	private String cellnum;		// 오프라인회원 전화번호
	private String address;		// 오프라인회원 주소
	private Integer francode;	// 가맹점코드
	private String etc;			// 비고
	private String state;		// 상태
	private String opt;			// 옵션
	private String onoff;		// 온라인/오프라인 구분
	private Timestamp reg;		// 오프라인회원 등록시간
	
	public Integer getOffmemnum() {
		return offmemnum;
	}
	public void setOffmemnum(Integer offmemnum) {
		this.offmemnum = offmemnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCellnum() {
		return cellnum;
	}
	public void setCellnum(String cellnum) {
		this.cellnum = cellnum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getFrancode() {
		return francode;
	}
	public void setFrancode(Integer francode) {
		this.francode = francode;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
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
	public String getOnoff() {
		return onoff;
	}
	public void setOnoff(String onoff) {
		this.onoff = onoff;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
}
