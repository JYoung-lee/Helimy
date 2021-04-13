<%@page import="helimy.project.model.MemberDAO"%>
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

<%
		//입력한 비밀번호와 아이디가 맞는지 체크
		String id = request.getParameter("id");
		String oldPw = request.getParameter("oldPw");
		String pw = request.getParameter("pw");
		
		//기존 아이디 비번에서 찾아서 있으면 새로 수정한 비밀번호로 바꿔주기
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = dao.checkIdPw(id, oldPw);		%>

<%		if(res){	//기존 입력했던 id와 pw가 맞으면 변경 실행
			res = dao.changPw(id, pw);	//바뀐비밀번호 넣어서 변경시켜주는 메서드 boolean 타입으로 실행해서 true일 경우에만 넘겨주기
			if(res){	// 비밀번호가 변경되었을 경우		%>
				비밀번호 수정이 완료되었습니다. 다시 로그인해주세요.		
				<button onclick="window.location='logout.jsp'">확인</button>	
<%			}else{		// 비밀번호 변경이 실패했을 경우 	%>
				<script>
					alert("비밀번호 변경이 실패했습니다. 다시시도해주세요.");
					history.go(-1);
				</script>
				
<%			}	
		}else{		//기본 입력했던 id와 pw가 일치하지 않으면 전페이지 가서 다시 확인 %>
			<script>
				alert("기존 비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>		
<%		}//else close %>
<%	} %>	
</body>
</html>