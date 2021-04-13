package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class FranchiseDAO {
	//싱글톤
	private static FranchiseDAO instance = new FranchiseDAO();
	private FranchiseDAO () {}
	public static FranchiseDAO getInstance() {return instance;}
	
	//커넥션 연결
	private Connection getConnection () throws Exception {
			Context ctx = new InitialContext();
			Context env = (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}//getConnection
	
	//admin에서 매장시설 등록하기(수정하기) 둘다 가능   adminPage
	public void insertFacility(FranchiseDTO frandto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "update franchise set promote=?,notice=?,amenity=?,addservice=? where id=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, frandto.getPromote()); 		// 홍보내역
			pstmt.setString(2, frandto.getNotice());		// 공지사항
			pstmt.setString(3, frandto.getAmenity());		// 편의시설
			pstmt.setString(4, frandto.getAddservice());	// 부가서비스
			pstmt.setString(5, frandto.getId());			// id
			pstmt.setInt(6, frandto.getFrancode());			// 가맹코드
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
			if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
		}
		
	}//insertFacility
	
	//admin에서 매장정보 등록하기(수정하기) 둘다 가능   (adminpage)
	public void insertFranchise(FranchiseDTO frandto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql ="update franchise set shopname=?,shopaddress=?,shopphone=?,weekday=?,sat=?,sun=?,totalnum=?,membernum=?,nonmemnum=? where id=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, frandto.getShopname());
			pstmt.setString(2, frandto.getShopaddress());
			pstmt.setString(3, frandto.getShopphone());
			pstmt.setString(4, frandto.getWeekday());
			pstmt.setString(5, frandto.getSat());
			pstmt.setString(6, frandto.getSun());
			pstmt.setInt(7, frandto.getTotalnum());
			pstmt.setInt(8, frandto.getMembernum());
			pstmt.setInt(9, frandto.getNonmemnum());
			pstmt.setString(10, frandto.getId());
			pstmt.setInt(11, frandto.getFrancode());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
			if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
		}
		
		
	}//insertFranchise
		
	//id가 ? 인 사람이 매장자세히보기 누르면 매장정보 가져오기 
	public FranchiseDTO franchiseInfo(String id, String francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FranchiseDTO frandto = null;
		try {
			conn = getConnection();
			String sql = "select * from franchise where id=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, francode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				frandto = new FranchiseDTO();
				frandto.setFrancode(rs.getInt("francode"));			// 매장코드
				frandto.setId(rs.getString("id"));					// 회원아이디
				frandto.setShopname(rs.getString("shopname")); 		// 매장명
				frandto.setShopaddress(rs.getString("shopaddress"));// 매장주소
				frandto.setShopphone(rs.getString("shopphone")); 	// 매장전화번호
				frandto.setWeekday(rs.getString("weekday")); 		// 월~금
				frandto.setSat(rs.getString("sat")); 				// 토 
				frandto.setSun(rs.getString("sun")); 				// 일
				frandto.setPromote(rs.getString("promote"));		// 홍보내역 
				frandto.setNotice(rs.getString("notice"));			// 공지사항
				frandto.setAmenity(rs.getString("amenity"));		// 편의시절
				frandto.setAddservice(rs.getString("addservice"));	// 부가서비스
				frandto.setTotalnum(rs.getInt("totalnum"));			// 총 수용인원
				frandto.setMembernum(rs.getInt("membernum"));		// 회원 수용인원
				frandto.setNonmemnum(rs.getInt("nonmemnum"));		// 비회원 수용인원
			}//if
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
			if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
			if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
		}
		return frandto;
	}//franchiseInfo
	
	//매장코드로 사람이 매장자세히보기 누르면 매장정보 가져오기 	memberPage 오버로딩
	public FranchiseDTO franchiseInfo(String francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FranchiseDTO frandto = null;	
		try {
			conn = getConnection();
			String sql = "select * from franchise where francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				frandto = new FranchiseDTO();
				frandto.setFrancode(rs.getInt("francode"));			// 매장코드
				frandto.setId(rs.getString("id"));					// 회원아이디
				frandto.setShopname(rs.getString("shopname")); 		// 매장명
				frandto.setShopaddress(rs.getString("shopaddress"));// 매장주소
				frandto.setShopphone(rs.getString("shopphone")); 	// 매장전화번호
				frandto.setWeekday(rs.getString("weekday")); 		// 월~금
				frandto.setSat(rs.getString("sat")); 				// 토 
				frandto.setSun(rs.getString("sun")); 				// 일
				frandto.setPromote(rs.getString("promote"));		// 홍보내역 
				frandto.setNotice(rs.getString("notice"));			// 공지사항
				frandto.setAmenity(rs.getString("amenity"));		// 편의시절
				frandto.setAddservice(rs.getString("addservice"));	// 부가서비스
				frandto.setTotalnum(rs.getInt("totalnum"));			// 총 수용인원
				frandto.setMembernum(rs.getInt("membernum"));		// 회원 수용인원
				frandto.setNonmemnum(rs.getInt("nonmemnum"));		// 비회원 수용인원
			}//if
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
			if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
			if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
		}
		return frandto;
	}//franchiseInfo
	
	
	//francode가져오면 매장 이름만 리턴해주기
	public String franchiseName(Integer francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = null;
		try {
			conn = getConnection();
			String sql = "select shopname from franchise where francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, francode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				name = rs.getString("shopname");
			}//if
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
			if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
			if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
		}
		return name;
	}//franchiseName
	
   public void deleteMemberNum(FranchiseDTO frandto) {      //memberPage 회원수 -1 추가
      Connection conn = null;
      PreparedStatement pstmt = null;
      
      try {
         Integer membernum = frandto.getMembernum() - 1;
         conn = getConnection();
         String sql = "update Franchise set membernum=? where francode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, membernum);
         pstmt.setInt(2, frandto.getFrancode());
         pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
         if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); } 
      }
   }//deleteMemberNum

   //매장코드로 사람이 매장자세히보기 누르면 매장정보 가져오기 	memberPage 오버로딩
   public List searchFranInfo(String sel,String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FranchiseDTO frandto = null;
		List list = null;
		
		try {
			conn = getConnection();
			String sql = "select * from franchise where shop"+sel+ " like '%"+ search +"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				list = new ArrayList();
				do {
					frandto = new FranchiseDTO();
					frandto.setFrancode(rs.getInt("francode"));			// 매장코드
					frandto.setShopname(rs.getString("shopname")); 		// 매장명
					frandto.setShopaddress(rs.getString("shopaddress"));// 매장주소
					frandto.setShopphone(rs.getString("shopphone")); 	// 매장전화번호
					list.add(frandto);
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
   }//franchiseInfo
   
}//FranchiseDAO
