<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<nav>
		<%if(session.getAttribute("memId") == null) {%>
		<div class="top">
			<a href="/helimy/admin/index.jsp"><p class="logo">logo</p></a>
			<ul class="user">
				<li><button onclick="window.location.href='loginPro.jsp'">로그인</button></li>
			</ul>
		</div>
		<%}else{ %>
		<div class="top">
			<a href="/helimy/admin/index.jsp"><p class="logo">logo</p></a>
			<ul class="user">
				<li><%=session.getAttribute("memId") %>님</li>
				<li><button onclick="window.location.href='#'">홈</button></li>
				<li><button onclick="window.location.href='logoutPro.jsp'">로그아웃</button></li>
			</ul>
		</div>
		<%} %>
</body>
</html>