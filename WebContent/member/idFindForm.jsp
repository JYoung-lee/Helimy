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
			if(!inputs.name.value){//이름 필수 입력확인
				alert("이름을 입력하세요.");
				return false;
			}
			if(!inputs.cellnum.value){//휴대폰번호 필수 입력확인
				alert("휴대폰번호를 입력하세요.");
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
			<!-- cookie와 session 모두가 없을 때에만 보여주기 -->
			<jsp:include page="include/top_logout.jsp"/>
			
			<div class="cont cont2">
			<!-- 비로그인일 상태에서만 아이디 찾기 실행 -->
			<form action="idFindPro.jsp" method="post" name="inputForm" onsubmit="return check()">
				<table>
					<tr>
						<td> 이름 </td>
						<td> <input type="text" name="name"/></td>
					</tr>		
					<tr>
						<td> 휴대전화 </td>
						<td> <input type="text" name="cellnum"/></td>
					</tr>	
					<tr>
						<td colspan="2"><input type="submit" value="아이디찾기" /></td>
					</tr>
				</table>
			</form>
			</div>
<%		} %>
<%	} %>			
</body>
</html>