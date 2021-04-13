package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewDAO {
	//싱글톤
	private static ReviewDAO instance = new ReviewDAO();
	private ReviewDAO() {}
	public static ReviewDAO getInstance() {return instance;}
	
	//Connection
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}//getConnection
	
	//게시글 존재하는지 확인
	public int getReviewCount(String francode) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from review where francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if (pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if (conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return count;
	}//getReviewCount
	
	//게시글 범위주고 가져오기
	public List getReview(String francode, int startRow, int endRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List reviewlist = null;
		
		try {
			conn = getConnection();
			String sql = "select b.* from (select a.*,rownum r from(select * from review where francode=? order by reviewcode desc) a) b where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewlist = new ArrayList();
				do {
					ReviewDTO reviewdto = new ReviewDTO();
					reviewdto.setReviewcode(rs.getInt("reviewcode"));
					reviewdto.setId(rs.getString("id"));
					reviewdto.setPoint(rs.getInt("point"));
					reviewdto.setContent(rs.getString("content"));
					reviewdto.setReviewreg(rs.getTimestamp("reviewreg"));
					reviewdto.setFrancode(rs.getInt("francode"));
					reviewlist.add(reviewdto);
				}while(rs.next());
			}//if
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if (pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if (conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return reviewlist;
	}//getReview
	
	//해당 가맹점 리뷰가져오기
	public double getPoint(String francode) {								// memberPage
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		double totalPoint = 0;
		int point = 0;
		try {
			conn = getConnection();
			String sql = "select sum(point) from review where francode=?"; // 총 리뷰 합가져오기
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1) != 0) {
				point = rs.getInt(1); //리뷰 총 포인트
				}//if
			}//if
			
			sql = "select count(point) from review where francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1) != 0) {
				int count = rs.getInt(1);
				totalPoint =(double)point / count;
				}//if
			}//if
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if (pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if (conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	
		return totalPoint;
	} // getPoint
	
	public boolean insertReview(String id,int francode,double point,String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int res = 0;
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "insert into review values(reviewCode_seq.nextval,?,?,?,null,default,null,sysdate,?)"; // 총 리뷰 합가져오기
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, id);
			pstmt.setDouble(2, point);
			pstmt.setString(3, content);
			pstmt.setInt(4, francode);
			res = pstmt.executeUpdate();
			if(res > 0) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if (conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}//insertReview
	
	public boolean checkReview(String id, int francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "select * from review where id=? and francode=?"; // 해당 아이디가 매장에 리뷰 남겼는지. 체크.
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, id);
			pstmt.setInt(2, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if (pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if (conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// reviewcode로 리뷰 가져오기
    public List getMember(int francode) { //review 정보를 회원아이디로 가져와서 전부 보내줄것 
       ReviewDTO review = null;
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List list = null;
       try {                        // 껍데기    목적 : 변수공유 
          conn = getConnection();
          
          String sql = "select * from review where francode=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, francode);
          rs = pstmt.executeQuery();
          
          if(rs.next()) {
             list = new ArrayList();  // 글 하나이상 ArrayList  DB에 있는 데이터를  DTO에 SET에 넣어주기.
             do {
                review = new ReviewDTO(); // 위에 객체 생성  
                review.setReviewcode(rs.getInt("reviewcode"));
                review.setId(rs.getString("id"));
                review.setPoint(rs.getInt("point"));
                review.setContent(rs.getString("content"));
                review.setReply(rs.getString("reply"));
                review.setState(rs.getString("state"));
                review.setReplyreg(rs.getTimestamp("replyreg"));
                review.setReviewreg(rs.getTimestamp("reviewreg"));
                review.setFrancode(rs.getInt("francode"));
                list.add(review);
             }while(rs.next());
          }//if문    
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          if(rs !=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
          if(pstmt !=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
          if(conn !=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
          
       }
       return list;
    }
	
}//ReviewDAO
