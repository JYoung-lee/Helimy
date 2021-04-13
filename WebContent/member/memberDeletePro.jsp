<%@page import="helimy.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>

<html>
<%
   request.setCharacterEncoding("UTF-8");
%>

<body>
<%-- 아이디가 비로그인상태이거나 쿠키가 없을경우 --%>
<%	if(session.getAttribute("memId") == null){	//비로그인상태 
		//session은 존재하지 않지만 쿠키가 존재할 수 있으니 2중체크
		String id = null, pw= null, auto=null; 
		Cookie[] coos = request.getCookies();
		if(coos != null){
			for(Cookie c : coos){
				if(c.getName().equals("autoId")) id = c.getValue();
				if(c.getName().equals("autoPw")) pw = c.getValue();
				if(c.getName().equals("autoCh")) auto = c.getValue();
			}
		}	
		if(auto != null && id != null && pw != null){	//cookie가 존재해서 그 아이디가 존재한다면 로그인 시켜주기
			// 로그인상태를 유지시켜주는 세션, 이것이 만들어지는 pro 이동
			response.sendRedirect("loginPro.jsp");
		}
%>
		<script>
			alert("로그인후 이용해주시기 바랍니다!");
			window.location="/helimy/member/login.jsp";
		</script>
		
<% 	}else{	//로그인상태	%>
<%  // 아이디와 비밀번호 맞는지 체크
	   	String id = request.getParameter("id");
	   	String pw = request.getParameter("pw");
	   
		MemberDAO dao = MemberDAO.getInstance();  
		boolean res = dao.checkIdPw(id, pw);
		
		if(res){
		   // id pw 확인 회원 삭제 
		   res = dao.deleteMember(id);
		   // 삭제 메서드가 실행되는지 확인
		   if(res){ 
		   		// 탈퇴시 쿠키도 삭제
				Cookie[] cs = request.getCookies();
				if(cs != null){
					for(Cookie c : cs ){
						if(c.getName().equals("autoId")||c.getName().equals("autoPw")||c.getName().equals("autoCh")){
							c.setMaxAge(0);
							response.addCookie(c);
						}
					}
				}
				// 세션 삭제
				session.invalidate();%>
		      	<div class="cont cont2 width460 centerbox centerbox2">
					<p class="tit1 tac">회원탈퇴완료!</p>
					<input class="btn_c" type="button" onclick="window.location='nonmemberMain.jsp'" value="홈으로"/>
				</div>
		 <% } %>             
	<% 	}else{ %>
		       <script>
		          alert("비밀번호가 맞지 않습니다. 다시 작성해주세요.");
		          history.go(-1);
		       </script>     
	<%	} %>        
<%	} %>
</body>
</html>