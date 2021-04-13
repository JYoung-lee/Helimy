<%@page import="helimy.project.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro 페이지</title>
</head>

<body>
<%
	if(session.getAttribute("memId") != null){	//로그인상태 %>
		<script>
			alert("이미로그인 되었습니다.!");
			window.location="/helimy/member.jsp";
		</script>	
<%	}else{	
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw"); 
		String auto = request.getParameter("auto");	//자동로그인 체크박스 파라미터 받기
	
		// 쿠키가 있다면 다시 꺼내기
		Cookie[] coos = request.getCookies();
		if(coos != null){
			for(Cookie c : coos ){
				if(c.getName().equals("autoId")) id =c.getValue();
				if(c.getName().equals("autoPw")) pw =c.getValue();
				if(c.getName().equals("autoAuto")) auto =c.getValue();
			}		
		}
		//로그인 체크 > DB에 가서 id pw 일치하는 회원이 있는지 체크
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = dao.checkIdPw(id, pw);
		int auth = dao.checkAuth(id, pw); 
				
		if(res){ //id pw 일치
			if(auto != null){	//자동로그인 체크했으면, 쿠키만들기
				Cookie c1 = new Cookie("autoId",id);	// 사용자 id
				Cookie c2 = new Cookie("autoPw",pw);	// 사용자 pw
				Cookie c3 = new Cookie("autoCh",auto);	// 자동로그인 체크값
				c1.setMaxAge(60*60*24);
				c2.setMaxAge(60*60*24);
				c3.setMaxAge(60*60*24);
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
			}
			//로그인 상태 유지 -> session 만들기(세션에 memId이름과 사용자의 id 값으로 속성 추가)
				session.setAttribute("memId",id);
				session.setAttribute("authority", auth);		//회원 나누기위한 변수
				response.sendRedirect("memberMain.jsp");	
		}else{%>
			<script>
				alert("아이디 또는 비밀번호가 맞지 않습니다. 다시 시도해주세요.");
				history.go(-1);
			</script>	
<%		}
	}//else close	
%>

</body>
</html>