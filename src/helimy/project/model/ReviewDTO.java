package helimy.project.model;

import java.sql.Timestamp;

public class ReviewDTO {
	private Integer reviewcode; 	// 리뷰코드
	private String id;				// 회원아이디
	private Integer point;			// 평점
	private String content;			// 내용
	private String reply;			// 답글
	private String state;			// 상태 ( y , n ) 답변완료 y , 미답변 n
	private Timestamp replyreg;		// 답변시간
	private Timestamp reviewreg;	// 리뷰작성 시간
	private Integer francode;		// 가맹코드
	public Integer getReviewcode() {
		return reviewcode;
	}
	public void setReviewcode(Integer reviewcode) {
		this.reviewcode = reviewcode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer point) {
		this.point = point;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Timestamp getReplyreg() {
		return replyreg;
	}
	public void setReplyreg(Timestamp replyreg) {
		this.replyreg = replyreg;
	}
	public Timestamp getReviewreg() {
		return reviewreg;
	}
	public void setReviewreg(Timestamp reviewreg) {
		this.reviewreg = reviewreg;
	}
	public Integer getFrancode() {
		return francode;
	}
	public void setFrancode(Integer francode) {
		this.francode = francode;
	}
	
	
}
