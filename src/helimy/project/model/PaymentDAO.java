package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource; 


public class PaymentDAO {
   //싱글톤
      private static PaymentDAO instance = new PaymentDAO();
      private PaymentDAO() {}
      public static PaymentDAO getInstance () {return instance;}
      
      //컬렉션 연결
      public Connection getConnection() throws Exception{
         Context ctx = new InitialContext();
         Context env = (Context)ctx.lookup("java:comp/env");
         DataSource ds = (DataSource)env.lookup("jdbc/orcl");
         return ds.getConnection();
      } //getConnection()
   
      // id를 던져주고 결제내역정보를 가져오기
      public List getPayment(String id) {
         List list = null;
    	 PaymentListDTO paymentList = null;
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         
         try {
            conn = getConnection();
            // id로는 결제코드랑 결제시간 
            // product code로 매장명, 상품명, 결제금액 가져올것
            String sql = "select paymentcode,reg,productcode,state from payment where id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
               
            if(rs.next()) {
            	list = new ArrayList();
            	FranchiseDAO frandao = FranchiseDAO.getInstance();
               do {
            	   paymentList = new PaymentListDTO();
                   paymentList.setPaymentcode(rs.getInt(1)); 			//결제코드
                   paymentList.setReg(rs.getTimestamp(2));				//결제시간
                   // rs에서 받아온 productcode로 다시 매장명이랑 기타정보 불러오기
                   ProductDTO prodto = getProductInfo(rs.getInt(3));
                   paymentList.setState(rs.getString(4));				//결제상태	
                   //받아온 DTO 객체로 정보 집어넣어주기
                   String shopname = frandao.franchiseName(prodto.getFrancode());	//매장명 불러오기
                   paymentList.setShopname(shopname);					//매장명
                   paymentList.setProductname(prodto.getProductname());	//상품명
                   paymentList.setPrice(prodto.getPrice());				//결제금액
                   list.add(paymentList);								//불러온 정보 싹다 정리해서 list에 넣기
               }while(rs.next());
            }
          }catch(Exception e){
           e.printStackTrace();
          }finally {
        	  if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
        	  if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
        	  if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); }   
          }
         return list;
      }
      
      // product 코드로 매장명, 상품명, 가격 가져오기
      public ProductDTO getProductInfo(int productcode) {
         
    	 ProductDTO productdto = null;
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         
         try {
            conn = getConnection();
            // id로는 결제코드랑 결제시간 
            // product code로 매장명, 상품명, 결제금액 가져올것
            String sql = "select productname, price, francode FROM product WHERE productcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productcode);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	productdto = new ProductDTO();	
            	productdto.setProductname(rs.getString(1));
            	productdto.setPrice(rs.getInt(2));
            	productdto.setFrancode(rs.getInt(3));
            }
          }catch(Exception e){
           e.printStackTrace();
          }finally {
        	  if(rs != null) try {rs.close();}catch(Exception e) { e.printStackTrace(); } 
        	  if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
        	  if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); }    
          }
         return productdto;
      }
      
      //id, paymentcode로 결제내역 취소 시키면서 이유도 받아서 넣어주기
      public boolean canclePay(String id, int paymentcode, String canclereason) {
    	  Connection conn = null;
          PreparedStatement pstmt = null;
          boolean result = false;
          int res = 0;
          try {
             conn = getConnection();
             String sql = "update payment set state='cancle', canclereason=? where id=? and paymentcode=?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, canclereason);
             pstmt.setString(2, id);
             pstmt.setInt(3, paymentcode);
             res = pstmt.executeUpdate();
             if(res != 0) {
            	 result = true;
             }
           }catch(Exception e){
            e.printStackTrace();
           }finally {
         	  if(pstmt != null) try {pstmt.close();}catch(Exception e) { e.printStackTrace(); } 
         	  if(conn != null) try {conn.close();}catch(Exception e) { e.printStackTrace(); }    
           }
    	  return result;
      }
      public void insertPayment(Integer productcode, String id) {		// memberPage
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		
  		try {
  			conn = getConnection();
  			String sql = "insert into payment(paymentcode,productcode,id,reg) values(paymentcode_seq.nextval,?,?,sysdate)";
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setInt(1, productcode);
  			pstmt.setString(2, id);
  			pstmt.executeUpdate();
  		}catch(Exception e) {
  			e.printStackTrace();
  		}finally {
  			if(pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
  			if(conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();}
  		}
  	}//insertPayment
}

