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
			if(!inputs.name.value){//이름을 입력하지 않을시 채우도록
				alert("이름을 입력하세요.");
				return false; 
			}
			if(!inputs.birth.value){//생년월일을 입력하지 않을시 채우도록
				alert("생일을 입력하세요.");
				return false;
			}
			if(!inputs.cellnum.value){//휴대전화을 입력하지 않을시 채우도록
				alert("휴대전화를 입력하세요.");
				return false;
			}
			if(!inputs.address.value){//주소를 입력하지 않을시 채우도록
				alert("주소를 입력하세요.");
				return false;
			}
			// pw, pwCh 같은지
			if(inputs.pw.value != inputs.pwCh.value){
				alert("비밀번호가 같지 않습니다. 확인해주세요.");
				return false;
			}
		}
		// pw 변경 전에 비밀번호 채웠는지 확인하고 넘겨주는 메서드
		function passPw(inputForm){	// <- this.form
			//필수 기입란 기입했는지
			if(!inputForm.pw.value){//비밀번호 필수 입력확인
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputForm.pwCh.value){//비밀번호체크용 필수 입력확인
				alert("비밀번호 확인을 입력하세요.");
				return false;
			}
			// pw, pwCh 같은지
			if(inputForm.pw.value != inputForm.pwCh.value){
				alert("비밀번호가 같지 않습니다. 확인해주세요.");
				return false;
			}
			window.location="modifyPwForm.jsp?id="+inputForm.id.value+"&pw="+inputForm.pw.value;
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


	<jsp:useBean id="member" class="helimy.project.model.MemberDTO"/>
	<%
		//checkPro 에서 넘겨준 정보 받아오기
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
	
		
		//받아온 정보로 해당 회원 정보 불러와서 수정가능하도록 하기
		MemberDAO dao = MemberDAO.getInstance();
		member = dao.getMemberInfo(id, pw);
	%>
		<jsp:include page="include/nav.jsp"/>
		
		<div class="cont">
		<p class="tit1">회원정보 수정</p>
		<br/>
			<div class="width4600">
		<%	if(member != null){	//회원정보 가져온내용이 있을경우 %>
			<form action="modifyPro.jsp" method="post" >
				<input type="hidden" name=id value="<%=member.getId()%>"/>
				
				<p class="tit4">아이디</p>
				<div class="inputWrap">
					<input class="input_a nn" type="text" name ="id" value="<%=member.getId() %>" readonly/>
				</div>
				
				<p class="tit4">비밀번호</p>
				<div class="inputWrap">
					<input class="input_a" type="password" name ="pw"/>
				</div>
				
				<p class="tit4">비밀번호확인</p>
				<div class="inputWrap">
					<input class="input_a" type="password" name ="pwCh"/>
				</div>
				
				<p class="tit4">이름</p>
				<div class="inputWrap">
					<input class="input_a" name ="name" value="<%=member.getName()%>"/>
				</div>
				
				<p class="tit4">생년월일</p>
				<div class="inputWrap">
					<input class="input_a" name ="birth" maxlength="8" value="<%=member.getBirth()%>"/>
				</div>
				
				<p class="tit4">휴대전화</p>
				<div class="inputWrap">
					<input class="input_a" name ="cellnum" value="<%=member.getCellnum()%>" />
				</div>
				
				<p class="tit4">주소</p>
				<div class="inputWrap">
					<input class="input_a" name ="address" value="<%=member.getAddress()%>" />
				</div>
				
				<input class="btn_b" type="submit" value="수정"/>
				<input class="btn_a" type="button" value="비밀번호변경" name="inputForm2" onclick="passPw(this.form)"/>	
				
			</form>
			</div>
		<%	}else{ //가져온 회원정보가 없을 경우%>
				<script>
					alert("맞는 회원정보가 없습니다. 다시확인하세요.");
					history.go(-2);
				</script>
		<%	}//close else %>
		</div>
<%	} %>		
</body>
</html>