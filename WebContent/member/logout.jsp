<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>

<body>
<%
	if(session.getAttribute("memId")==null){ //이미 로그아웃 상태		%>
		<script>
			alert("로그인 해주세요!");
			window.location="/web/member1222/main.jsp";		
		</script>
<%	}else{

		// 로그아웃시 쿠키도 삭제
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
		session.invalidate();
		// 메인으로 이동
		response.sendRedirect("nonmemberMain.jsp");
	}//else 
%>
	
</body>
</html>