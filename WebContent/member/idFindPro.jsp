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
		}else{ //session과 cookie가 모두 없는 비로그인상태		%>
			<!-- cookie와 session 모두가 없을 때에만 보여주기 -->
			<jsp:include page="include/top_logout.jsp"/>			
			
			<div class="cont cont2">
			<!-- 비로그인일 상태에서만 아이디 찾기 실행 -->
			<jsp:useBean id="member" class="helimy.project.model.MemberDTO"/>
			<%
				//입력했던 이름과 전화번호 가져오기
				String name = request.getParameter("name");
				String cellnum = request.getParameter("cellnum");
				
				MemberDAO dao = MemberDAO.getInstance();//DAO 객체생성
				member = dao.findId(name, cellnum);//아이디 찾아주는 메서드실행
				
				if(member != null){ //객체에 내용물이 담겼을 경우 즉, 아이디가 존재할 경우
			%>		
					<%=name%>님의 아이디는  <%=member.getId() %>입니다
					<button onclick="window.location='login.jsp'">확인</button>
			<%	}else{//객체가 비었을떄 즉, 아이디가 없을경우 %>		
					<script>
						alert("입력하신 정보의 아이디는 없는 아이디입니다.");
						history.go(-1);
					</script>
			<%	} %>
			</div>
<%		} %>
<%	} %>
</body>
</html>