package helimy.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {return instance; }
	
	//커넥션 메서드
	private Connection getConnection() throws Exception{
		Context ctx =new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
//----------------------------------------------------------------
	//회원가입 시켜주는 메서드
	public boolean insertMember(MemberDTO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int res = 0;
		boolean result= false;
		try {
			conn = getConnection();
			String sql = "insert into memberInfo values(?,?,?,?,?,?,?,default,default,default,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId().trim());
			pstmt.setString(2, member.getPw().trim());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getGender());
			pstmt.setString(6, member.getCellnum());
			pstmt.setString(7, member.getAddress());
			res = pstmt.executeUpdate(); //쿼리입력 - > 회원정보 입력/..
			if(res > 0) {//쿼리 실행문이 0보다 크다면 실행됨 그이외엔 실행 안됨.
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}//close insertMember
	
	//회원정보 바꿔주는 메서드
	public boolean updateMember(MemberDTO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int res = 0;
		boolean result= false;
		try {
			conn = getConnection();
			String sql = "update memberInfo set name=? ,birth=? ,cellnum=? ,address=? where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getBirth());
			pstmt.setString(3, member.getCellnum());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getId());
			pstmt.setString(6, member.getPw());
			res = pstmt.executeUpdate(); //쿼리입력 - > 회원정보 입력/..
			if(res > 0) {//쿼리 실행문이 0보다 크다면 실행됨 그이외엔 실행 안됨.
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}//close updateMember
	
	//id찾아주는 메서드
	public MemberDTO findId(String name, String cellnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;	//가져온 아이디 보내주기 위한 객체
		try {
			conn = getConnection();
			String sql = "select id from memberInfo where name=? and cellnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, cellnum);
			rs = pstmt.executeQuery(); //쿼리입력해서 해당 아이디 가져오기
			
			if(rs.next()) {//쿼리 실행문이 0보다 크다면 실행됨 그이외엔 실행 안됨. 0보다 커야 아이디가 존재
				member = new MemberDTO();
				member.setId(rs.getString("id"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		
		return member;
	}//close findId
	
	//비밀번호 찾아주는 메서드
	public MemberDTO findPw(String id, String cellnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;	//가져온 비밀번호 보내주기 위한 객체
		try {
			conn = getConnection();
			String sql = "select pw from memberInfo where id=? and cellnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, cellnum);
			rs = pstmt.executeQuery(); //쿼리입력해서 해당 비밀번호 가져오기
			
			if(rs.next()) {//next가 존재해야 해당 비밀번호 가져올수 있다.
				member = new MemberDTO();
				member.setPw(rs.getString("pw"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return member;
	}//close findPw
	
	//id와 비번 check해주는 메서드
	public boolean checkIdPw(String id,String pw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "select * from memberInfo where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery(); //쿼리입력해서 해당 비밀번호 가져오기
			
			if(rs.next()) {
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}//close checkIdPw
	
	//id와 pw로 회원정보 가져와주는 메서드
		public MemberDTO getMemberInfo(String id,String pw) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			MemberDTO member = null;
			try {
				conn = getConnection();
				String sql = "select * from memberInfo where id=? and pw=?";	//id와 pw가 일치하는 정보 전부 가져오기
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				rs = pstmt.executeQuery(); //쿼리입력해서 해당 비밀번호 가져오기
				
				if(rs.next()) {//받아온 정보가 있다면 DTO객체에 넣어주기
					member = new MemberDTO();
					member.setId(id);
					member.setName(rs.getString("name"));
					member.setBirth(rs.getString("birth"));
					member.setCellnum(rs.getString("cellnum"));
					member.setAddress(rs.getString("address"));
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null)try {rs.close();} catch(Exception e) {e.printStackTrace();}
				if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
				if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
			}
			return member;//객체 리턴
		}//close getMemberInfo
	
	//pw변경 메서드
	public boolean changPw(String id,String newPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int res = 0;
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "update memberInfo set pw=? where id=?";	//id에 해당하는 비밀번호 새로 넣어줌
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPw);
			pstmt.setString(2, id);
			res = pstmt.executeUpdate();	
			
			if(res > 0) {	//해당하는 id가 있어서 비밀번호 변경 성공시
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return result;//결과값
	}//close changePw
	
	// 회원 탈퇴(삭제)
	   public boolean deleteMember(String id) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int res = 0;
	      boolean result = false;
	      
	      try {
	         conn = getConnection();
	         String sql = "delete from memberInfo where id=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         res = pstmt.executeUpdate();
	         if(res > 0) {
	            result = true;
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
	         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();} 
	      }
	      return result;
	   }
	   
	   // id 존재여부 확인
	   public boolean confirmId(String id) {
	      boolean result = false;
	      Connection conn = null;
	      PreparedStatement pstmt =null;
	      ResultSet rs = null;
	      try {
	         conn = getConnection();
	         String sql = "select id from memberInfo where id=? and pw=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         if(rs.next()) { 
	            result = true;
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
	         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
	      }
	      return result;   // id 존재하면 true , id 존재하지 않으면 false
	   }
	   
	   // 가맹인지 일반회원인지 확인
	   public int checkAuth(String id,String pw) {
	      int result = 0;
	      Connection conn = null;
	      PreparedStatement pstmt =null;
	      ResultSet rs = null;
	      try {
	         conn = getConnection();
	         String sql = "select authority from memberInfo where id=? and pw=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         pstmt.setString(2, pw);
	         rs = pstmt.executeQuery();
	         if(rs.next()) { 
	            result = rs.getInt(1);
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
	         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
	      }
	      return result;   // id 존재하면 true , id 존재하지 않으면 false
	   }
}
