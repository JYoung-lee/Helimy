<%@page import="helimy.project.model.BookmarkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐겨찾기 취소</title>
</head>
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
		
<% 	}else{	//로그인상태	
	   String id = (String)session.getAttribute("memId");
	   int francode = Integer.parseInt(request.getParameter("francode")); 
	   BookmarkDAO bookdao = BookmarkDAO.getInstance();
	   
	   boolean res = bookdao.deleteFavorite(id,francode); 
	
	   if(res == true){
			// res라고만 적어도 되지만 true까지 적는이유는 알아보기 위해 
			// 삭제가 실행되고 삭제문구는 필요없고 다시 즐겨찾기 리스트로 가서 삭제된걸 확인시켜주면 끝 %>
			<script>
			   window.location="favoritesList.jsp";
			</script>
	<%  }else{
			// 삭제가 실패해서 경고문구 보내주고 다시 전으로 돌아간다. %>
			<script>
			   alert("삭제를 실패했습니다.머선일이누?");
			   history.go(-1);
			</script>
	<%    } %>
<%	} %>

</body>
</html>