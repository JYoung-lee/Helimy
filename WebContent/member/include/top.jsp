<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<nav>
		<%if(session.getAttribute("memId") == null) {%>
		<div class="top">
			<a href="/helimy/member/nonmemberMain.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li><button onclick="window.location.href='login.jsp'">로그인</button></li>
				<li><button onclick="window.location.href='terms.jsp'">회원가입</button></li>
			</ul>
		</div>
		<%}else{ %>
		<div class="top">
			<a href="/helimy/member/memberMain.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li>환영합니다! <strong><%=session.getAttribute("memId")%></strong>님</li>
				<li><button onclick="window.location.href='mypage.jsp'">마이페이지</button></li>
				<li><button onclick="window.location.href='logout.jsp'">로그아웃</button></li>
			</ul>
		</div>
		<%} %>
	</nav>
</body>
</html>