<%@page import="helimy.project.model.BookingDAO"%>
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
			if(!inputs.point.value){//평점 필수 입력확인
				alert("평점을 입력하세요."); 
				return false;
			}
			if(!inputs.content.value){//내용 필수 입력확인
				alert("내용을 입력해주세요.");
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
		}%>
		<script>
			alert("로그인후 이용해주시기 바랍니다!");
			window.location="/helimy/member/login.jsp";
		</script>
		
<% 	}else{	//로그인상태	%>
		<jsp:include page="include/nav.jsp"/>
<%	
		String id = (String)session.getAttribute("memId");
		if(request.getParameter("bookingcode")==null){
			response.sendRedirect("bookingList.jsp");
		}else{
			int bookingcode = Integer.parseInt(request.getParameter("bookingcode")); 
			BookingDAO book = BookingDAO.getInstance();
			int francode = book.getFrancode(bookingcode);
			
			if(francode != -1){	//francode까지 존재할때 실행	%>
				<div class="cont">
				<form action="franReviewPro.jsp" method="post" name="inputForm" onsubmit="return check()">
				<p class="tit1">후기작성</p>
				<div class="tableWrap talbeWrap2">
				
				<input type="hidden" name="francode" value="<%=francode%>"/>
				<table>
					<tr>
						<td><%=id%> </td>
						<td>평점 : </td>
						<td><input type="text" name="point" placeholder="최대 5.0"/> </td>
					</tr> 
					<tr>
						<td colspan="3"><textarea cols="60" rows="5" name="content" placeholder="5글자 이상 입력해주세요."></textarea></td>
					</tr>
					<tr>
						<td colspan="3"><input type="submit" value="후기등록"/></td>
					</tr>
				</table>
				</div>
<%			}else{	//francode 불러오기 실패
				response.sendRedirect("bookingList.jsp");
			}
		}
%>
		</form>
		</div>
<%	}//session else close	%>		
</body>
</html>