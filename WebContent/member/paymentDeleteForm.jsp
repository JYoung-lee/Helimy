<%@page import="helimy.project.model.PaymentListDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.PaymentDAO"%>
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
		<jsp:include page="include/nav.jsp"/>
		<div class="cont">
<%
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("memId");	//id는 세션으로 받아오기
		int paymentcode = 0;
		if(request.getParameter("paymentcode") == null){
			//다른페이지에서 접근시 paymentList로 강제로 보내기	
			response.sendRedirect("paymentList.jsp");
		}else{
			paymentcode = Integer.parseInt(request.getParameter("paymentcode"));
		}
		
		PaymentDAO paydao = PaymentDAO.getInstance();
		List list = paydao.getPayment(id); 
	
		for(int i = 0; i < list.size(); i++){
			PaymentListDTO dto = new PaymentListDTO();
			dto = (PaymentListDTO)list.get(i);	
			if(dto.getPaymentcode() == paymentcode){		%>
				<br /><br /><br /><br /><br /><br />
			    <h4 align="center">
			    <%if( dto.getProductname().equals("m1")){ %>
			    	구매내역 : 회원 1개월  
			    <%} %>	
			    <%if( dto.getProductname().equals("m3")){ %>
			    	구매내역 : 회원 3개월  	
			    <%} %>	
	 			<%if( dto.getProductname().equals("m6")){ %>
			    	구매내역 : 회원 6개월 	
			    <%} %>	
			    <%if( dto.getProductname().equals("m12")){ %>
			    	구매내역 : 회원 12개월 
			    <%} %>	
			    <%if( dto.getProductname().equals("h1")){%>
			    	구매내역 : 1시간권 
			    <%}%>	
			    <%if( dto.getProductname().equals("h2")){ %>
			    	구매내역 : 2시간권 
			    <%} %>	
			    <%if( dto.getProductname().equals("h3")){ %>
			    	구매내역 : 3시간권 					 
			    <%} %>			    	
			    	결재금액 : <%=dto.getPrice()%> 
			    	매장명 : <%=dto.getShopname()%></h4>
			    <form action="paymentDeletePro.jsp" method="post" name="inputForm" >
			    	<input type="hidden" name="id" value="<%=id%>"/>
			    	<input type="hidden" name="paymentcode" value="<%=dto.getPaymentcode()%>"/>
				    <table align="center">
				        <tr>
				            <td>취소 사유</td>
				        </tr>
				        <tr>
				            <td><textarea cols="100" rows="10" name="canclereason">설명</textarea></td>
				        </tr>
				        <tr>
				            <td align="center"><input type="submit" value="결제취소"/></td>
				        </tr>
				    </table>
			    </form>
	    <%}	//if close%>
	<%	}// for close%>
		</div>
<%	} %>
</body>
</html>