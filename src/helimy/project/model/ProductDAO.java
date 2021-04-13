package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDAO {
	//싱글톤
	private static ProductDAO instance = new ProductDAO();
	private ProductDAO() {}
	public static ProductDAO getInstance() { return instance;}
	
	// Connection 연결
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}//getConnection
	
	// DB에 상품들 개월/시간 가격 맞춰서 넣어주기						adminPage
	public void insertProduct(ProductDTO prodto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into product values(productcode_seq.nextval,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, prodto.getProductname());
			pstmt.setInt(2, prodto.getPrice());
			pstmt.setInt(3, prodto.getFrancode());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
	}//insertProduct
		
	// 상품=가격 수정하기												adminPage
	public void modifyProduct(ProductDTO prodto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "update product set price=? where productname=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, prodto.getPrice());
			pstmt.setString(2, prodto.getProductname());
			pstmt.setInt(3, prodto.getFrancode());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
	}//insertProduct
	
	// 가맹점 개월 가격 모두 꺼내오기									adminPage
	public List getProuctMonth(String francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List productMonthlist = null;
		String productname = "m%";
		try {
			conn = getConnection();
			String sql = "select * from product where francode=? and productname like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			pstmt.setString(2, productname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				productMonthlist = new ArrayList();
				do {
					ProductDTO prodto = new ProductDTO();
					prodto.setProductcode(rs.getInt("productcode"));
					prodto.setProductname(rs.getString("productname"));
					prodto.setPrice(rs.getInt("price"));
					prodto.setFrancode(rs.getInt("francode"));
					productMonthlist.add(prodto);
				}while(rs.next());
				
			}//if
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return productMonthlist;
		
	}//getProuct

	// 가맹점 시간 상품 가격 모두 꺼내오기								adminPage
	public List getProHourslist(String francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List producHourstlist = null;
		String productname = "h%";
		try {
			conn = getConnection();
			String sql = "select * from product where francode=? and productname like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, francode);
			pstmt.setString(2, productname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				producHourstlist = new ArrayList();
				do {
					ProductDTO prodto = new ProductDTO();
					prodto.setProductcode(rs.getInt("productcode"));
					prodto.setProductname(rs.getString("productname"));
					prodto.setPrice(rs.getInt("price"));
					prodto.setFrancode(rs.getInt("francode"));
					producHourstlist.add(prodto);
				}while(rs.next());
				
			}//if
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return producHourstlist;
		
	}//getProHourslist
	
	// 가맹코드 상품명으로 한개 담아오기 								memberPage
	public ProductDTO getProduct(String productname, String francode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO prodto = null;
		
		try {
			conn = getConnection();
			String sql = "select * from product where productname=? and francode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productname);
			pstmt.setString(2, francode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				prodto = new ProductDTO();
				prodto.setProductcode(rs.getInt("productcode"));
				prodto.setProductname(rs.getString("productname"));
				prodto.setPrice(rs.getInt("price"));
				prodto.setFrancode(rs.getInt("francode"));
			}//if
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			
		}
		return prodto;
	}//getproduct
	
}//ProductDAO
