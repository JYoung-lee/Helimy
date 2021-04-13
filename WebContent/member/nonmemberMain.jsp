<%@page import="java.util.List"%>
<%@page import="helimy.project.model.BannerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>

<html>
<body>

<%-- 아이디가 이미 자동로그인상태이거나 세션이 존재할 경우는 memberMain(로그인상태 메인)으로 이동시킨다. --%>
<%	if(session.getAttribute("memId") != null){	//로그인상태 %>
		<script>
			alert("이미로그인 되었습니다.!");
			window.location="/helimy/member/memberMain.jsp";
		</script>	
<%--session이나 쿠키가 존재하지 않을 경우 처음 메인화면을 띄워준다. --%>		
<% 	}else{	
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
		// 위애서 검사했을때, 쿠키가 있다면 id,pw,auto 변수에 값이 들어있을것이고, -> 로그인처리
		if(auto != null && id != null && pw != null){	//cookie가 존재해서 그 아이디가 존재한다면 로그인 시켜주기
			// 로그인상태를 유지시켜주는 세션, 이것이 만들어지는 pro 이동
			response.sendRedirect("loginPro.jsp");
		}else{ //session과 cookie가 모두 없는 비로그인상태
			BannerDAO bannerdao = BannerDAO.getInstance(); 
			String master = "master";
			List bannerlist = bannerdao.getBannerImg(master);
			
%>
			<!-- cookie와 session 모두가 없을 때에만 보여주기 -->
			<jsp:include page="include/top_logout.jsp"/>
			<div class="fixedBg"></div>
			<div class="cont cont2">
				<div class="vod">
					<video id="vid" src="../vod/main.mp4" muted loop></video>
					<script>
					var autoplayVideoInterval = setInterval("autoplayVideo()",200);
	
					function autoplayVideo(){
						var promise = document.getElementById('vid').play();
						if (promise !== undefined){
							promise.then(function (){
								clearInterval(autoplayVideoInterval);	
							});
						}
					}
					</script>
				</div>
				<div class="ad_tit">
					<div class="bg bora"></div>
					<p class="tit width1200">Let's do it!</p>
				</div>
				<div class="width1200">
					<ul class="ad">
						<li><img src="../image/ad1.jpg" alt=""></li>
						<li><img src="../image/ad2.jpg" alt=""></li>
					</ul>
				</div>				
			</div>			
			<jsp:include page="include/footer.jsp"/>
<%		}//cookie else close %>
<%	}//session else close %>
</body>
</html>