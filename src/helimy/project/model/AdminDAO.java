package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {
	
	//싱글톤
	private static AdminDAO instance = new AdminDAO();
	private AdminDAO() {}
	public static AdminDAO getInstance() { return instance; }
	
	//db연결
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}	
	
	//id로 소유한 가맹점코드 리스트 가져오기
	public List getFranlist(String id) {
		List franlist = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select francode,shopname,shopaddress,reg from franchise where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				franlist = new ArrayList();
				do {
					FranchiseDTO fran = new FranchiseDTO();
					fran.setFrancode(rs.getInt("francode"));
					fran.setShopname(rs.getString("shopname"));
					fran.setShopaddress(rs.getString("shopaddress"));
					fran.setReg(rs.getTimestamp("reg"));
					franlist.add(fran);
		        }while(rs.next());	
			}			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return franlist;		
	}
	
	//id와 가맹코드로 가맹점정보DTO 가져오기
	public FranchiseDTO getFran(String id, Integer francode) {
		FranchiseDTO fran = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();			
			String sql = "select * from franchise where id=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
            	fran = new FranchiseDTO();
               	fran.setFrancode(rs.getInt("francode"));
				fran.setId(rs.getString("id"));
				fran.setShopname(rs.getString("shopname"));
				fran.setShopaddress(rs.getString("shopaddress"));
				fran.setShopphone(rs.getString("shopphone"));
				fran.setWeekday(rs.getString("weekday"));
				fran.setSat(rs.getString("sat"));
				fran.setSun(rs.getString("sun"));
				fran.setPromote(rs.getString("promote"));
				fran.setNotice(rs.getString("notice"));
				fran.setAmenity(rs.getString("amenity"));
				fran.setAddservice(rs.getString("addservice"));
				fran.setTotalnum(rs.getInt("totalnum"));
				fran.setMembernum(rs.getInt("membernum"));
				fran.setNonmemnum(rs.getInt("nonmemnum"));
				fran.setReg(rs.getTimestamp("reg"));
	         }
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return fran;		
	}
	
	//가맹점 수용가능인원 값변경
	public void setMemnum(int totalnum, int memnum, int nonmemnum, String id, Integer francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update franchise set totalnum=?, membernum=?, nonmemnum=? where id=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, totalnum);
			pstmt.setInt(2, memnum);
			pstmt.setInt(3, nonmemnum);
			pstmt.setString(4, id);
			pstmt.setInt(5, francode);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}		
	}
	
	//가맹코드로 가맹점 회원 불러오기
	public MemberDTO getMem(Integer francode) {
		MemberDTO mem = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();			
			String sql = "select * from memberinfo where francode=? order by reg DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
            	mem = new MemberDTO();
               	mem.setId(rs.getString("id"));
               	mem.setName(rs.getString("name"));
               	mem.setBirth(rs.getString("birth"));
               	mem.setGender(rs.getString("gender"));
               	mem.setCellnum(rs.getString("cellnum"));
               	mem.setAddress(rs.getString("address"));
               	mem.setOnoff(rs.getString("onoff"));
               	mem.setReg(rs.getTimestamp("reg"));
	         }
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return mem;		
	}
	
	
	//회원등록
	public void insertMember(MemberDTO mem) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	  	  
		try {
			conn = getConnection();		

			//글 저장 쿼리문
			String sql = "insert into memberinfo(id,pw,name,birth,gender,cellnum,address,authority,francode,onoff,reg) values(?,?,?,?,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem.getId());
			pstmt.setString(2, mem.getPw());
			pstmt.setString(3, mem.getName());
			pstmt.setString(4, mem.getBirth());
			pstmt.setString(5, mem.getGender());
			pstmt.setString(6, mem.getCellnum());
			pstmt.setString(7, mem.getAddress());
			pstmt.setInt(8, mem.getAuthority());
			pstmt.setInt(9, mem.getFrancode());
			pstmt.setString(10, mem.getOnoff());
			pstmt.executeUpdate();
	  	}catch(Exception e) {
	  		e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//가맹점 회원 개수 리턴 메서드
	public int getMemberCount(Integer francode) {
		int x = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	   
		try {
			conn = getConnection();
			String sql = "select count(*) from memberinfo where francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return x;
	}
	
	//범위 주고 범위 내의 회원들 가져오는 메서드
	public List getMember(Integer francode, int start, int end){
      List memList = null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = getConnection();
         String sql = "select b.*, r from (select a.*, rownum r from (select * from memberinfo) a order by reg ASC) b where authority=1 and francode=? and r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, francode);
         pstmt.setInt(2, start);
         pstmt.setInt(3, end);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            memList = new ArrayList();
            do {
               MemberDTO mem = new MemberDTO();
               mem = new MemberDTO();
               mem.setId(rs.getString("id"));
               mem.setName(rs.getString("name"));
               mem.setBirth(rs.getString("birth"));
               mem.setGender(rs.getString("gender"));
               mem.setCellnum(rs.getString("cellnum"));
               mem.setAddress(rs.getString("address"));
               mem.setFrancode(rs.getInt("francode"));
               mem.setOnoff(rs.getString("onoff"));
               mem.setReg(rs.getTimestamp("reg"));
               memList.add(mem);
            }while(rs.next());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
         if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
         if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
      }
      return memList;
   }	
	
}
