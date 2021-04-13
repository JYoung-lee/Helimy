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
			if(!inputs.pw.value){//비밀번호 필수 입력확인
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.pwCh.value){//비밀번호체크용 필수 입력확인
				alert("비밀번호를 입력하세요.");
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
		/*
		//id 중복확인 함수
		function openConfirmId(inputForm){	// <- this.form
			// form 태그안에 id 입력란에 작성한 값을 꺼내서 DB연결해 검사
			console.log(inputForm.id.value);	// 폼태그 안에 id라는 name속성값의 태그 값 출력
			if(inputForm.id.value == ""){	// id란에 입력했는지 검사
				alert("아이디를 입력하세요.");
				return; // 아래코드 실행하지 않고 이 함수 강제 종료!
			}
			//팝업띄워서 id 확인결과 보기
			//팝업띄울 주소를 작성 > id란에 입력한 값을 get방식 파라미터로 같이 전송!
			var url = "confirmId.jsp?id="+inputForm.id.value;
			open(url, "confirm", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=500, height=400");
		}
		*/
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
		}else{ //session과 cookie가 모두 없는 비로그인상태
%>
			<div class="cont cont2 width460 centerbox">
				<p class="logo"><a href="nonmemberMain.jsp"></a></p>
				
				<form action="signupPro.jsp" method="post" name="inputForm" onsubmit="return check()" >				
				<p class="tit4">아이디</p>
				<div class="inputWrap flex">
					<input class="input_b" type="text" name ="id">
					<input class="btn_d" type="button" value="중복확인" onclick="openConfirmId(this.form)"/>
				</div>
				
				<p class="tit4">비밀번호</p>
				<div class="inputWrap">
					<input class="input_a" type="text" name ="pw">
				</div>
				
				<p class="tit4">비밀번호확인</p>
				<div class="inputWrap">
					<input class="input_a" type="text" name ="pwCh">
				</div>
				
				<p class="tit4">이름</p>
				<div class="inputWrap">
					<input class="input_a" type="text" name ="name">
				</div>
				
				<p class="tit4">생년월일</p>
				<div class="inputWrap">
					<input class="input_a" type="text" name ="birth" maxlength="8" placeholder="ex) 911201">
				</div>
				
				<p class="tit4">성별</p>
				<div class="inputWrap">
					<select class="input_a" name="gender">
						<option value="" selected disabled hidden>선택</option>
					 	<option value="male">남자</option>
					 	<option value="female">여자</option>
					</select>
				</div>
				
				<p class="tit4">휴대전화</p>
				<div class="inputWrap">
					<input class="input_a" type="text" name ="cellnum" placeholder="ex) 010-0000-0000">
				</div>
				
				<p class="tit4">주소</p>
				<div class="inputWrap">
					<input class="input_a" type="text" name ="address" placeholder="ex) 서울 관악구 신림동">
				</div>				
				
				<input class="btn_c" type="submit" value="가입하기"/>				
				</form>
			</div>
<%		} %>
<%	} %>			
</body>
</html>