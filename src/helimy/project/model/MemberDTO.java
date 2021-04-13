package helimy.project.model;

import java.sql.Timestamp;

public class MemberDTO {
	private String id;			// 아이디
	private String pw;			// 비밀번호
	private String name;		// 이름
	private String birth;		// 생년월일
	private String gender;		// 성별
	private String cellnum;		// 전화번호
	private String address;		// 회원주소
	private Integer authority;	// 관리자권한 default 1
	private Integer francode;	// 가맹점코드 기본 0
	private String onoff;		// 온라인/오프라인 default 'on'
	private Timestamp reg;		// 회원 가입 시간 sysdate
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
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
	public Integer getAuthority() {
		return authority;
	}
	public void setAuthority(Integer authority) {
		this.authority = authority;
	}
	public Integer getFrancode() {
		return francode;
	}
	public void setFrancode(Integer francode) {
		this.francode = francode;
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
