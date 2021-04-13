<%@page import="helimy.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyCheck Pro</title>
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
	<%	
		//입력한 id, pw가져오기
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
	
		//아이디 비번 확인하는 메서드 사용
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = dao.checkIdPw(id, pw);
	
		if(res == true){ //입력한 아이디랑 비밀번호에 맞는 정보가 있을경우 		
			response.sendRedirect("modifyForm.jsp?id="+id+"&pw="+pw);
		}else{//잘못 입력했을 경우	%>
			<script>
				alert("입력하신 정보가 맞지않습니다.");
				history.go(-1);
			</script>
		
<%		} %>
<%	}//else close %>
</body>
</html>