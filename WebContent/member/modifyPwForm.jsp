<%@page import="helimy.project.model.MemberDAO"%>
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
			if(!inputs.pw.value){//비밀번호 필수 입력확인
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.pwCh.value){//비밀번호체크용 필수 입력확인
				alert("비밀번호 확인을 입력하세요.");
				return false;
			}
			// pw, pwCh 같은지
			if(inputs.pw.value != inputs.pwCh.value){ 
				alert("비밀번호가 같지 않습니다. 확인해주세요.");
				return false;
			}
			if(inputs.oldPw.value == inputs.pw.value){
				alert("기존비밀번호와 동일합니다. 다시입력하세요");
				return false;
			}
		}
	</script>
	
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
	<%
		//입력한 비밀번호와 아이디가 맞는지 체크
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = dao.checkIdPw(id, pw);		
	%>
	<%
		if(res){	//id pw 가 일치할 경우 pw변경이 가능하도록함		%>
			<div class="cont">
			<div class="tableWrap">	
			<form action="modifyPwPro.jsp" method="post" name="inputForm" onsubmit="return check()" >
				<input type="hidden" name="id" value="<%=id%>"/>
				<input type="hidden" name="oldPw" value="<%=pw%>"/>
				<table >
					<tr>
						<td>새 비밀번호 *</td>
						<td><input type="password" name ="pw"></td>
					</tr>
					<tr>
						<td>새 비밀번호확인 *</td>
						<td><input type="password" name ="pwCh"></td>
					</tr>
					
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="확인"/>								
						</td>
					</tr>
				</table>
			</form>
			</div>	
			</div>
	<%	}else{		//id pw 가 일치하지 않을경우 다시 회원수정페이지로 넘어가도록 함 %>
			<script>
				alert("비밀번호가 틀립니다.확인해주세요.");
				history.go(-1);
			</script>
	<%	}//else %>
<%	}//로그인상태 확인 else %>
</body>
</html>