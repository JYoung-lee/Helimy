<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>


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
			<jsp:include page="include/top_login.jsp"/>
			<div class="fixedBg"></div>
			<div class="cont cont2">
				<div class="vod">
					<div class="cover">
						<form action="memberMainPro.jsp" method="post">						
						<div class="searchPos">
							<p class="tit1 tac">주변 GYM을 검색해보세요!</p>
							<div class="search">								
								<select name="sel">
				            		<option value="address">지역</option>
					            </select>
					            <input class="bar" type="text" name="search" />
					            <input class="btn_bar" type="submit" value="검색" />
							</div>				            
			            </div>
			      		</form>
					</div>
					<video id="vid" src="../vod/main.mp4" autoplay muted loop></video>
					<script>
					/* var autoplayVideoInterval = setInterval("autoplayVideo()",200);
	
					function autoplayVideo(){
						var promise = document.getElementById('vid').play();
						if (promise !== undefined){
							promise.then(function (){
								clearInterval(autoplayVideoInterval);	
							});
						}
					} */
					</script>
				</div>
				<jsp:include page="include/footer.jsp"/>
			
<%	} %>			
</body>
</html>