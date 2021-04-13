<%@page import="helimy.project.model.PaymentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>


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
<%
		String id = request.getParameter("id");
		int paymentcode = 0;
		String canclereason = "마음에 들지 않습니다.";
		if(request.getParameter("paymentcode") == null){
			//다른페이지에서 접근시 paymentList로 강제로 보내기	
			response.sendRedirect("paymentList.jsp");
		}else{	//payment값이 존재할때 이유도 같이 가져와서 넣어주고 입력하기.
			paymentcode = Integer.parseInt(request.getParameter("paymentcode"));
			canclereason = request.getParameter("canclereason");
		}
		PaymentDAO paydao = PaymentDAO.getInstance();
		boolean res = paydao.canclePay(id,paymentcode,canclereason);	
		
		if(res){	//변경이 성공했다면 
			response.sendRedirect("paymentList.jsp");	
		}else{		//변경이 실패했다면 %>
			<script>
				alert("실패");	
				history.go(-1);
			</script>
<%		} %>
<%	}	//session else %>
</body>
</html>