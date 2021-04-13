<%@page import="helimy.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
			<jsp:useBean id="member" class="helimy.project.model.MemberDTO"/>
			<jsp:setProperty property="*" name="member"/>
<%
			//회원가입 정보 받은거 입력하기
			MemberDAO dao = MemberDAO.getInstance();
			boolean res = dao.insertMember(member);
		
			if(res == true){	//회원가입이 DB에 입력 성공하면	%>
				<div class="cont cont2 width460 centerbox centerbox2">
					<p class="tit1 tac">회원가입완료! 로그인해주세요.</p>
					<input class="btn_a" type="button" onclick="window.location='nonmemberMain.jsp'" value="홈"/>
					<input class="btn_b" type="button" onclick="window.location='login.jsp'" value="로그인"/>
				</div>
<%			}else{	//DB입력 실패하면	%>	
				<script>
					alert("회원가입이 실패했습니다. 다시시도해주세요.");
					history.go(-1);
				</script>
<% 			}%>
<%		} %>
<%	} %>	
</body>
</html>