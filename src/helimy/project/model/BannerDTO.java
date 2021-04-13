package helimy.project.model;

public class BannerDTO {
	private Integer bannercode;	// 배너코드
	private String id;			// 회원아이디
	private String image;		// 사이트 사용설명서 사진
	
	public Integer getBannercode() {
		return bannercode;
	}
	public void setBannercode(Integer bannercode) {
		this.bannercode = bannercode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	
}
