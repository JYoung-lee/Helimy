package helimy.project.model;

public class BookmarkDTO {
	private Integer markcode;	// 즐겨찾기 코드
	private String id;			// 회원아이디
	private Integer francode;	// 가맹코드
	
	public Integer getMarkcode() {
		return markcode;
	}
	public void setMarkcode(Integer markcode) {
		this.markcode = markcode;
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
	
	
}
