<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<%if((Integer)session.getAttribute("authority") == 1 ){	//일반회원일 경우	%>
		<nav>
			<div class="top">
			<a href="/helimy/member/memberMain.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li>환영합니다! <strong><%=session.getAttribute("memId")%></strong>님</li>
				<li><button onclick="window.location.href='mypage.jsp'">마이페이지</button></li>
				<li><button onclick="window.location.href='logout.jsp'">로그아웃</button></li>
			</ul>
			</div>
		</nav>
	<%}else{ %>
		<nav>
			<div class="top">
			<a href="/helimy/member/memberMain.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li>환영합니다! <strong><%=session.getAttribute("memId")%></strong>님</li>
				<li><button onclick="window.location.href='../admin/franlist.jsp'">관리자페이지</button></li>
				<li><button onclick="window.location.href='mypage.jsp'">마이페이지</button></li>
				<li><button onclick="window.location.href='logout.jsp'">로그아웃</button></li>
			</ul>
			</div>
		</nav>
	<%} %>
</body>
</html>