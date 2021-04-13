package helimy.project.model;

import java.sql.Timestamp;

public class BookingDTO {
	private Integer bookingcode; 	// 예약코드
	private Integer francode;		// 가맹코드
	private String id;				// 회원아이디
	private Integer bookingstart;	// 예약 시간시작
	private Integer bookingend;		// 예약 시간종료
	private String state;			// 상태 ( on / stop / end )
	private Timestamp reg;			// 예약한 시간
	
	public Integer getBookingcode() {
		return bookingcode;
	}
	public void setBookingcode(Integer bookingcode) {
		this.bookingcode = bookingcode;
	}
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
	public Integer getBookingstart() {
		return bookingstart;
	}
	public void setBookingstart(Integer bookingstart) {
		this.bookingstart = bookingstart;
	}
	public Integer getBookingend() {
		return bookingend;
	}
	public void setBookingend(Integer bookingend) {
		this.bookingend = bookingend;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
}
