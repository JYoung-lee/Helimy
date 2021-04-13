<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<body>
	<jsp:include page="include/nav.jsp"/>
	<%if(session.getAttribute("memId") == null) {%>
	<div class="cont">
		<button onclick="window.location.href='loginPro.jsp'">로그인</button>
	</div>
	<%}else{ %>
	<div class="cont">
		<%=session.getAttribute("memId")%>님 환영함미다
		<button onclick="window.location.href='logoutPro.jsp'">로그아웃</button>		
	</div>
	<%} %>
</body>
</html>