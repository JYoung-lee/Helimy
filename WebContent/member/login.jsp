<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
	<script>
	//유효성 검사
		function check(){
			var inputs = document.inputForm;
			//필수 기입란 기입했는지
			if(!inputs.id.value){//이름 필수 입력확인
				alert("아이디를 입력하세요.");
				return false;
			}
			if(!inputs.pw.value){//비밀번호 필수 입력확인
				alert("비밀번호를 입력하세요.");
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
		}else{ //session과 cookie가 모두 없는 비로그인상태		%>

		<div class="cont cont2 width460 centerbox centerbox2">
			<p class="logo"><a href="nonmemberMain.jsp"></a></p>
			<p class="txt">로그인 하시고 다양한 혜택을 누리세요!</p>
			<form action="loginPro.jsp" method="post" name="inputForm" onsubmit="return check()">
			<ul class="loginbox">
				<li><input class="input_a" type="text" name="id" placeholder="아이디"/></li>
				<li><input class="input_a" type="password" name="pw" placeholder="비밀번호"/></li>
				<li><input class="btn_c" type="submit" value="로그인" /></li>
				<li><input type="checkbox" name="auto" value="1"/> 자동로그인</li>
			</ul>
			</form>
			<div class="flex find">
				<a href="idFindForm.jsp">id찾기</a>
				<a href="pwFindForm.jsp">pw찾기</a>
				<a href="terms.jsp">회원가입</a>
			</div>
		</div>
<%		} %>
<%	} %>
</body>
</html>