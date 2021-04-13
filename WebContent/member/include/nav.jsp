<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<nav>
		<%if(session.getAttribute("memId") == null) {%>
		<div class="top top_bg">
			<a href="/helimy/member/nonmemberMain.jsp"><p class="logo"></p></a>
			<ul class="user">
				<li><button onclick="window.location.href='login.jsp'">로그인</button></li>
				<li><button onclick="window.location.href='terms.jsp'">회원가입</button></li>
			</ul>
		</div>
<%		}else{ 
			if((Integer)session.getAttribute("authority") == 1 ){	//일반회원일 경우	%>
			
				<div class="top bora">
				<a href="/helimy/member/memberMain.jsp"><p class="logo"></p></a>
				<ul class="user">
					<li>환영합니다! <strong><%=session.getAttribute("memId")%></strong>님</li>
					<li><button onclick="window.location.href='mypage.jsp'">마이페이지</button></li>
					<li><button onclick="window.location.href='logout.jsp'">로그아웃</button></li>
				</ul>
				</div>
				
				<ul class="left bora">
					<li><a href="/helimy/member/mypage.jsp">마이페이지 홈</a></li>
					<li><a href="/helimy/member/modifyCheck.jsp">회원정보수정</a></li>
					<li><a href="/helimy/member/bookingList.jsp">예약내역</a></li>
					<li><a href="/helimy/member/paymentList.jsp">결제내역</a></li>
					<li><a href="/helimy/member/favoritesList.jsp">즐겨찾기</a></li>
					<li><a href="/helimy/member/memberDeleteForm.jsp">회원탈퇴</a></li>
				</ul>
				
<%			}else if((Integer)session.getAttribute("authority") == 2 ){ //관리자 회원일경우	%>
			
			<div class="top bora">
				<a href="/helimy/member/memberMain.jsp"><p class="logo"></p></a>
				<ul class="user">
					<li>환영합니다! <strong><%=session.getAttribute("memId")%></strong>님</li>
					<li><button onclick="window.location.href='../admin/franlist.jsp'">관리자페이지</button></li>
					<li><button onclick="window.location.href='mypage.jsp'">마이페이지</button></li>
					<li><button onclick="window.location.href='logout.jsp'">로그아웃</button></li>
				</ul>
			</div>
			
			<ul class="left bora">
				<li><a href="/helimy/member/mypage.jsp">마이페이지 홈</a></li>
				<li><a href="/helimy/member/modifyCheck.jsp">회원정보수정</a></li>
				<li><a href="/helimy/member/bookingList.jsp">예약내역</a></li>
				<li><a href="/helimy/member/paymentList.jsp">결제내역</a></li>
				<li><a href="/helimy/member/favoritesList.jsp">즐겨찾기</a></li>
				<li><a href="/helimy/member/memberDeleteForm.jsp">회원탈퇴</a></li>
			</ul>
			
<%			} %>
<%		} %>
			
	</nav>
	
	<script>
		var now = window.location.pathname;
		if(now == "/helimy/member/mypage.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(0).addClass("on");
		}else if(now == "/helimy/member/modifyCheck.jsp" || now == "/helimy/member/modifyForm.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(1).addClass("on");
		}else if(now == "/helimy/member/bookingList.jsp" || now == "/helimy/member/modifyBookingForm.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(2).addClass("on");
		}else if(now == "/helimy/member/paymentList.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(3).addClass("on");
		}else if(now == "/helimy/member/favoritesList.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(4).addClass("on");
		}else if(now == "/helimy/member/memberDeleteForm.jsp"){
			$(".left").children("li").removeClass("on");
			$(".left").children("li").eq(5).addClass("on");
		}
	</script>
</body>
</html>