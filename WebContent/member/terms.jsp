<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
	<script>
		function check(){// 약관동의 체크 메서드
			var inputs = document.getElementsByName("terms");
			//필수 기입란 기입했는지
			var count = 0;
			
			for(var i = 0; i < inputs.length; i++){
				if(inputs[i].value == "person" ){//개인정보동의 동의시+1
					if(inputs[i].checked == true){
						count++;
					}
				}
				if(inputs[i].value == "location" ){//위치정보 동의시+1
					if(inputs[i].checked==true ){
						count++;
					}
				}
			}
			if(count != 2){	// 모두 동의 안할시 false 처리되도록
				alert("약관을 동의해주세요");
				return false;
			}
		} 	
	</script>
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
%>
			<form action="signupForm.jsp" method="post" name="inputForm" onsubmit="return check()">
			<div class="cont cont2 width460 centerbox">
				<p class="logo"><a href="nonmemberMain.jsp"></a></p>
				<form action="loginPro.jsp" method="post" name="inputForm" onsubmit="return check()">
				<div class="loginbox">
					<jsp:include page="yak.jsp"/>
				</div>
				<input type="checkbox" name="terms" value="person" style="margin-bottom:8px;"/> 개인정보 수집 이용 동의 <br/>
				<input type="checkbox" name="terms" value="location" style="margin-bottom:8px;"/> 위치정보 이용약관 동의 <br/>				
				<input class="btn_a" type="button" onclick="window.location='nonmemberMain.jsp'" value="취소"/>
				<input class="btn_b" type="submit" value="확인"/>				
				</form>
			</div>				
			</form>
<%		} %>
<%	}%>	
</body>
</html>