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
		if(!inputs.id.value){//아이디 필수 입력확인
			alert("아이디를 입력하세요.");
			return false;
		}
		if(!inputs.pw.value){//비밀번호체크용 필수 입력확인
			alert("비밀번호 확인을 입력하세요.");
			return false;
		}
		// 내 로그인 아이디와 입력한 아이디가 같은지
		if(inputs.id.value != inputs.memId.value){
			alert("로그인한 아이디랑 일치하지 않습니다.");
			return false;
		}
	}
</script>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
		<jsp:include page="include/nav.jsp"/>
		<div class="cont">  
			<p class="tit1"> 회원탈퇴</p>
			<h4>회원탈퇴를 위해 아이디와 비밀번호를 입력해주세요.</h4>
			<div class="tableWrap">
			<form action="memberDeletePro.jsp" method="post" name="inputForm" onsubmit="return check()">
				<input type="hidden" name="memId" value="<%=session.getAttribute("memId")%>"/> 
				<ul class="loginbox loginbox2">
					<li><input class="input_a" type="text" name="id" placeholder="아이디"/></li>
					<li><input class="input_a" type="password" name="pw" placeholder="비밀번호"/></li>
					<li><input class="btn_c" type="submit" value="확인" /></li>
				</ul>
			</form>
			</div>
		</div>
<%	} %>
</body>
</html>