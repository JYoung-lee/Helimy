<%@page import="helimy.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>정보수정 page</title>
</head>
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

	<jsp:useBean id="member" class="helimy.project.model.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	<%
		//불러온 정보를 가지고 id,pw 맞는지 우선 체크
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = dao.checkIdPw(member.getId(), member.getPw());
	%>
	<%	
		if(res){	//불러온 정보의 id,pw가 맞다면 수정할 내용 바꿔주기
			res = dao.updateMember(member);	//회원수정 실행한 후에 밑에서 처리되었는지 검사하기
			
			if(res){	// 회원수정 완료했다면	%>
				회원정보 수정이 완료되었습니다. <br/>
				<%-- 확인 누르면 마이페이지로 넘겨주고 지금 실행했었던 id도 같이 넘겨준다. session으로 처리해도 되지만 같이 넘겨놓고 다음에 수정 --%>
				<button onclick="window.location='mypage.jsp?id=<%=member.getId() %>'">확인</button>
	<%		}else{		// 회원수정 실패했다면	%>
				<script>
					alert("회원정보 수정이 실패하였습니다. 다시시도하세요.");
					history.go(-1);
				</script>
	<%		}	%>
			
	<%	}else{	//불러온 정보의 id,pw가 맞지 않다면 수정할 내용 못바꿔줌	%>
			<script>
				alert("아이디와 비밀번호가 일치하지 않습니다.");
				history.go(-1);
			</script>		
	<%	}%>
<%	} %>
</body>
</html>