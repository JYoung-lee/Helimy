package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ImageFranchiseDAO {
	//싱글톤
	private static ImageFranchiseDAO instance = new ImageFranchiseDAO();
	private ImageFranchiseDAO() {}
	public static ImageFranchiseDAO getInstance() {return instance;}
	
	//컬렉션 연결
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	} //getConnection()
	
	// 이미지넣기		adminPage
	public void uploadImg(String img, Integer francode) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into imagefranchise values(imagecode_seq.nextVal,?,?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, img);
			pstmt.setInt(2, francode);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();} 
		}
	}// uploadImg()	
	
	//매장코드로 이미지 가져오기								adminPage
	public ImageFranchiseDTO getMainImg(Integer francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List imglist = null;
		ImageFranchiseDTO imgdto = null;
		try {
			conn = getConnection();
			String sql = "select * from imagefranchise where francode=? ORDER BY imagecode";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, francode);
			rs = pstmt.executeQuery();
		if(rs.next()) {		
			imgdto = new ImageFranchiseDTO();
			imgdto.setImagecode(rs.getInt("imagecode"));
			imgdto.setImage(rs.getString("image"));
			imgdto.setFrancode(rs.getInt("francode"));			
			
		} //if
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();} 
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();} 
		}
		return imgdto;
	}//getMainImg
	
	//매장코드로 메인 제외한 나머지 이미지 가져오기				adminPage / memberPage
	public List getImgList(String francode) {				
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List imglist = null;
		ImageFranchiseDTO imgdto = null;
		
		try {
			conn = getConnection();
			String sql = "select * from imagefranchise where francode=? ORDER BY imagecode";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			imglist = new ArrayList(); 
				while(rs.next()) {
				imgdto = new ImageFranchiseDTO();
				imgdto.setImagecode(rs.getInt("imagecode"));
				imgdto.setImage(rs.getString("image"));
				imgdto.setFrancode(rs.getInt("francode"));
				imglist.add(imgdto);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();} 
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return imglist;
	}
	
	//이미지 카운트로 수량 체크 								adminPage
	public int getImgCount(String francode) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from imagefranchise where francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		return count;
	}
	
	// 이미지 이름 던져주고 해당 이미지 수정 1:바꿀이미지, 2: 가맹코드, 3:원래이미지 adminPage
	public void imgModify(String img, String francode, String imgs) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update imagefranchise set image=? where francode=? and image=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, img);
			pstmt.setString(2, francode);
			pstmt.setString(3, imgs);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} 
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();} 
		}
	}//imgModify
	

	
} //ImageFranchiseDAO


