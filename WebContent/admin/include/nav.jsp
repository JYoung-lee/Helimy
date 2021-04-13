<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<nav>
		<%if(session.getAttribute("memId") == null) {%>
		<div class="top">
			<a href="/helimy/admin/index.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li><button onclick="window.location.href='loginPro.jsp'">로그인</button></li>
			</ul>
		</div>
		<%}else{ %>
		<div class="top jaju">
			<a href="/helimy/admin/index.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li><%=session.getAttribute("memId") %>님</li>
				<li><button onclick="window.location.href='franoutPro.jsp'">가맹점선택</button></li>
				<li><button onclick="window.location.href='../member/mypage.jsp'">마이페이지</button></li>
				<li><button onclick="window.location.href='../member/logout.jsp'">로그아웃</button></li>
			</ul>
		</div>
		<%} %>
		<ul class="left jaju">
			<li><a href="/helimy/admin/index.jsp">홈</a></li>
			<li><a href="/helimy/admin/member.jsp?pageNum=1">회원관리</a></li>
			<li><a href="/helimy/admin/payment.jsp?pageNum=1">예약/결제</a></li>
			<li><a href="/helimy/admin/review.jsp">리뷰</a></li>
			<li><a href="/helimy/admin/info.jsp">매장기본정보</a></li>
			<li><a href="/helimy/admin/facility.jsp">매장시설정보</a></li>
			<li><a href="/helimy/admin/gallery.jsp">매장이미지</a></li>
		</ul>
	</nav>
	<script>
		var now = window.location.pathname;
		if(now == "/helimy/admin/index.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(0).addClass("on");
		}else if(now == "/helimy/admin/member.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(1).addClass("on");
		}else if(now == "/helimy/admin/payment.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(2).addClass("on");
		}else if(now == "/helimy/admin/review.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(3).addClass("on");
		}else if(now == "/helimy/admin/info.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(4).addClass("on");
		}else if(now == "/helimy/admin/facility.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(5).addClass("on");
		}else if(now == "/helimy/admin/gallery.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(6).addClass("on");
		}
	</script>
</body>
</html>