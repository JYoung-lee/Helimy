package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BannerDAO {
	//싱글턴
	private static BannerDAO instance = new BannerDAO();
	private BannerDAO() {}
	public static BannerDAO getInstance() {return instance;}
	
	public static Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource rs = (DataSource)env.lookup("jdbc/orcl");
		return rs.getConnection();
	}//getConnection
	
	public void insertBannerImg(String id, String img) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = getConnection();
			String sql = "insert into banner values(bannercode_seq.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, img);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(pstmt != null)  try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)  try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}//insertBannerImg
	
	public List getBannerImg(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List bannerlist = null;
		try{
			conn = getConnection();
			String sql = "select * from banner where id=? order by bannercode";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bannerlist = new ArrayList();
				do {
					bannerlist.add(rs.getString("image"));
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs != null)  try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)  try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)  try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return bannerlist;
	}//getBannerImg
	
}//BannerDAO
