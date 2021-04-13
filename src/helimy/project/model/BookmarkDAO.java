package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookmarkDAO {

   private static BookmarkDAO instance = new BookmarkDAO();
   private BookmarkDAO() {}
   public static BookmarkDAO getInstance() {return instance;}
   
   //커넥션 메서드
   private Connection getConnection() throws Exception{
      Context ctx = new InitialContext();
      Context env = (Context)ctx.lookup("java:comp/env");
      DataSource ds = (DataSource)env.lookup("jdbc/orcl");
      return ds.getConnection();
   }   


   // 매장코드 이미지 불러오기
    public List getImg(Integer francode) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         List imglist = null;
         try {
            conn = getConnection();
            String sql = "select * from bookmark where id=? And francode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, francode);
            rs = pstmt.executeQuery();
         if(rs.next()) {
            do {
               ImageFranchiseDTO imgdto = new ImageFranchiseDTO();
               imglist = new ArrayList();
               imgdto.setImagecode(rs.getInt("imagecode"));
               imgdto.setImage(rs.getString("image"));
               imgdto.setFrancode(francode);
               imglist.add(rs.getString("image"));
            }while(rs.next());
         } //if
            
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();} 
            if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();} 
            if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();} 
         }
         
         return imglist;
      }//getImg
      
   // id와 매장코드를 통해서 매장정보 불러오기
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
            frandto.setFrancode(rs.getInt("francode"));         // 매장코드
            frandto.setId(rs.getString("id"));                  // 아이디                     
            frandto.setShopname(rs.getString("shopname"));         // 매장명       
            frandto.setShopaddress(rs.getString("shopaddress"));   // 매장위치   
            frandto.setShopphone(rs.getString("shopphone"));        // 매장번호
            
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
   
   
   //매장명 , 위치 , 번호 불러오기 id를 통해서 francode를 가져올수 있게..
   public List getFrancode(String id) {
   // 즐겨찾기 매장정보 가져오기
      List list = null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      FranchiseDTO franchise = null;
      
      try {
         conn = getConnection();
         String sql = "SELECT Francode FROM Bookmark where id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,id);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            // rs.next안에 넣은순간 커서가 이동되므로 한번 실행하고 다음커서로 넘기기위해 do while을 사용
            list = new ArrayList();  
            do {
               // 받아온 francode로 매장정보 불러와서 넣기
               // list 안에 add를 하면 주소값
               franchise = new FranchiseDTO();
               // 객체를 안에 넣는이유는 바깥에서 객체를 만들면 하나로 돌려쓰는원리가 되는거고
               // 안에서 만들면 되면 do while 반복문에 의해서 여러번 반복되니까 객체는 주소값을 공유하기때문에 다른정보를 
               // 넣고 싶을때는 새로운 객체를 넣어야된다.
               franchise = getFranInfo(rs.getInt(1));
               list.add(franchise);
            }while(rs.next());
      // rs.next << 커서 이동시켜놓은 상태에서 실행을 돌려놓고 커서이동  
         }   
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
      }
      
      return list;
   }

   // do while 문안에서 실행시킨다고 생각하고 메서드 실행
   public FranchiseDTO getFranInfo(int francode) {
      // francode로 매장정보를 가져오는 메서드
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      FranchiseDTO result = null;
      try {
         conn = getConnection();
         String sql = "SELECT francode,shopname,shopaddress,shopphone FROM franchise WHERE francode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, francode); 
         rs = pstmt.executeQuery();
         if(rs.next()) {
            //존재한거니까 받아온걸 DTO에 집어넣는다 
            result = new FranchiseDTO();
            result.setFrancode(rs.getInt(1));
            result.setShopname(rs.getString(2));
            result.setShopaddress(rs.getString(3));
            result.setShopphone(rs.getString(4));
            //set을 하는이유는 franchise 객체안에 집어넣는것 
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally{
         if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
      }
      return result;
      
      
   }
   // 실행되는지 체크하기 위해 boolean타입으로 메서드 생성....ㅎㅎ
   public boolean deleteFavorite(String id, int francode) {
      boolean result = false;
      Connection conn = null;
      PreparedStatement pstmt = null;
      int temp = 0;
      try {
         conn = getConnection();
         String sql = "delete from bookmark where id=? and francode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id); 
         pstmt.setInt(2, francode);
         temp = pstmt.executeUpdate();
         // temp pstmt 실행시켰을때 돌아오는 리턴값으로 실행되는지 안되는지 확인하려고 만드는 변수
         if(temp > 0) {
            result = true;
         }
         
      }catch(Exception e) {
         e.printStackTrace();
      }finally{
         
         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
      }
      
      return result;
   }
   public void insertbookmark(String id, String francode) { //memberPage
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int count = -1; 
      try {
         conn = getConnection();
         String sql="select count(francode) from bookmark where francode=? and id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, francode);
         pstmt.setString(2, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            count = rs.getInt(1);
         }
         if(count == 0) {
            sql ="insert into bookmark values(markcode_seq.nextval,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, francode);
            pstmt.executeUpdate();
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(pstmt != null) try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
         if(conn != null) try { conn.close();}catch(Exception e) {e.printStackTrace();} 
      }
   }//insertbookmark   
   
}//FranchiseDAO
