package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookingDAO {
	//싱글턴
	private static BookingDAO instance = new BookingDAO();
	private BookingDAO() {}
	public static BookingDAO getInstance() {return instance;}
	
	public static Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource rs = (DataSource)env.lookup("jdbc/orcl");
		return rs.getConnection();
	}//getConnection
	
	// 예약저장하기
	public void insertBooking(String francode, String id, Integer bookingstart, Integer bookingend) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = getConnection();
			String sql = "insert into booking values(bookingcode_seq.nextval,?,?,?,?,default,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			pstmt.setString(2, id);
			pstmt.setInt(3, bookingstart);
			pstmt.setInt(4, bookingend);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}//insertBooking
	
	//예약내역 가져오기
	public BookingDTO getbookingInfo(String francode, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BookingDTO bookingdto =null;
		try {
			conn = getConnection();
			String sql = "select * from booking where francode=? and id=? order by reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bookingdto = new BookingDTO();
				bookingdto.setBookingcode(rs.getInt("bookingcode"));
				bookingdto.setFrancode(rs.getInt("francode"));
				bookingdto.setId(rs.getString("id"));
				bookingdto.setBookingstart(rs.getInt("bookingstart"));
				bookingdto.setBookingend(rs.getInt("bookingend"));
				bookingdto.setState(rs.getString("state"));
				bookingdto.setReg(rs.getTimestamp("reg"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return bookingdto;
	}//getBookingInfo
	
	// id를 통해서 예약내역에 대한 정보가져오기
	   public List bookingInfo(String id) { //list 리턴타입으로 문자열로 id와 매장코드를 사용
	      List list = null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      BookingDTO bookdto = null;
	      
	   try {
	         conn = getConnection();
	         String sql = "select francode, bookingstart, bookingend, reg, state,bookingcode from booking where id=?"; 
	         // on 은 예약중인 상태 // off는 예약이 끝나서 만료된상태 
	         // db에서 예약내역이 담긴 id와 매장코드를 불러온다.
	         // 매장명 , 예약완료시간 예약시간 
	         // db컬럼 불러온다 : select는 뒤에 정보가 필요한 컬럼명이 들어가고
	         // db수정문 : update 테이블명 set 컬럼값, 컬럼값 where 조건=? and 조건=?;
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) { 
	          list = new ArrayList();    // list를 사용하기 위한 객체생성
	          FranchiseDAO frandao = FranchiseDAO.getInstance();
	          do {
	             //예약내역에서 1가지 정보가 아닌 여러가지를 가져오기 위해서 반복문 안에 객체생성
	             bookdto = new BookingDTO(); 
	             bookdto.setFrancode(rs.getInt(1)); // 예약코드
	             bookdto.setBookingstart(rs.getInt(2)); // 예약시작시간
	             bookdto.setBookingend(rs.getInt(3)); //  예약종료시간
	             bookdto.setReg(rs.getTimestamp(4)); // 예약완료 시간
	             bookdto.setState(rs.getString(5)); // 예약상태
	             bookdto.setBookingcode(rs.getInt(6));//부킹코드
	             list.add(bookdto);
	          }while(rs.next());
	         }//if
	      }catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
	         if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
	         if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
	      }
	      return list;
	}
	   

      // 예약 수정페이지에서 매장명 , 결제완료시간 , 기존 예약 시간 가져오기
      public List modifyBooking(String id) { 
         List list = null;
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         BookingDTO bookingdto = null;
         
         try {
        	conn = getConnection();
        	String sql = "select francode, bookingstart, bookingend, reg, state from booking where id=? and state='on'";
  
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			    
			if(rs.next()) { 
				list = new ArrayList();       
				// 매장명 , 결제완료시간 , 기존예약시간 불러오기
				do {
				   bookingdto = new BookingDTO(); 
				   bookingdto.setFrancode(rs.getInt(1)); // 예약코드
				   bookingdto.setBookingstart(rs.getInt(2)); // 예약시작시간
				   bookingdto.setBookingend(rs.getInt(3)); //  예약종료시간 
				   bookingdto.setReg(rs.getTimestamp(4)); // 예약완료 시간
				   bookingdto.setState(rs.getString(5)); // 예약상태
				   list.add(bookingdto);
				}while(rs.next());
	        }//if
         }catch (Exception e) {
            e.printStackTrace();
         }finally {
            if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
            if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
            if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
         }
         return list;
      }   	   
      
    //예약취소 해주는 코드 boolean인 이유는 리턴값받아서 성공했는지 체크하려고
  	public boolean cancleBooking(String id, int bookingcode) {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		boolean result = false;
  		int res = 0;
  		
  		try {
  			conn = getConnection();
  			String sql = "update booking set state='cancle' where id=? and bookingcode=?";
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, id);
  			pstmt.setInt(2, bookingcode);
  			res = pstmt.executeUpdate();
  			if(res > 0) {
  				result = true;
  			}
  		}catch(Exception e) {
  			e.printStackTrace();
  		}finally {
  			if(pstmt != null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
  			if(conn != null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
  		}
  		return result;
  	}//getBookingInfo
  	
  	 //예약코드로 매장정보 가져오기
  	public int getFrancode(int bookingcode) {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		int result = -1;
  		
  		try {
  			conn = getConnection();
  			String sql = "select francode from booking where bookingcode=?";
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setInt(1, bookingcode);
  			rs = pstmt.executeQuery();
  			if(rs.next()) {
  				result = rs.getInt("francode");
  			}
  		}catch(Exception e) {
  			e.printStackTrace();
  		}finally {
  			if(rs != null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
  			if(pstmt != null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
  			if(conn != null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
  		}
  		return result;
  	}//getFrancode
  	
    //예약 시간 변경
    public void modifyBooking(String francode, String id, Integer bookingstart, Integer bookingend) { //memberPage 추가
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String state = "on";
       Integer bookingcode = 0; 
       try {
          conn = getConnection();
          String sql = "select * from booking where francode=? and id=? and state=? order by reg desc";
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, francode);
          pstmt.setString(2, id);
          pstmt.setString(3, state);
          rs = pstmt.executeQuery();
          if(rs.next()) {
             bookingcode = rs.getInt("bookingcode"); //해당 예약 코드 가져오기 
          }
          
          sql = "update booking set bookingstart=?, bookingend=? where bookingcode=? and francode=? and id=?";         
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, bookingstart);
          pstmt.setInt(2, bookingend);
          pstmt.setInt(3, bookingcode);
          pstmt.setString(4, francode);
          pstmt.setString(5, id);
          pstmt.executeUpdate();
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          if(rs != null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
          if(pstmt != null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
          if(conn != null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
       }
    }//modifyBooking
  	
} //BookingDTO
