<%@page import="helimy.project.model.ImageFranchiseDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
	<script>
		function inputCheck(){
				var inputs = document.getElementsByName("month");
				var count = 0;
				for(var i = 0; i < inputs.length; i++){
					if(inputs[i].checked == true){
						count++;
					}
				}
				if(count > 0 )
					return true;
				else{
					alert("상품을 선택하세요.");
					return false;
				}
			}
	</script>

<%request.setCharacterEncoding("UTF-8");%> 
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
		<jsp:include page="include/top_login.jsp"/>
<%
		//매장코드,id 받기  
		String id = (String)session.getAttribute("memId");
		if(request.getParameter("francode") != null){
			String francode = request.getParameter("francode");
			
			//매장정보
			FranchiseDAO frandao = FranchiseDAO.getInstance();
			FranchiseDTO frandto = frandao.franchiseInfo(francode);
			//매장이미지
			ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
			ImageFranchiseDTO imgdto = imgdao.getMainImg(Integer.parseInt(francode));
			
			 %>
			<div class="cont cont3 width1200">
				<p class="tit1 tac">결제하실 상품을 선택해주세요.</p>		
				<div class="tableWrap">
					<table style="padding: 50px 0 0;">
						<tr>
							<th>매장명</th>
							<th>수용가능인원</th>
							<th>예약가능 회원수</th>
							<th>바로예약 가능여부</th>
						</tr>
						<tr>						
							<td><%=frandto.getShopname()%></td>
							<td><%=frandto.getTotalnum() %></td>
							<td><%=frandto.getMembernum() %></td>
							<td>
								<%if(frandto.getMembernum() > 0){ %>
				            		바로 예약가능
								<%}else{ %>			          
									예약불가  
								<%} %>	
							</td>
						</tr>			        
				    </table>
				    
				    <form action="paymentMemberPro.jsp" method="post" name="inputForm" onsubmit="return inputCheck()">
				    	<input type="hidden" name="id" value="<%=id%>"/>
				    	<input type="hidden" name="francode" value="<%=francode%>"/>
					    <table style="padding: 50px 0;">
					        <tr>
					            <th colspan="4">
					            	회원권
					            </th> 
					        </tr>
					        <tr>
					        	<td>1개월</td>
					        	<td>3개월</td>
					        	<td>6개월</td>
					        	<td>12개월</td>
					        </tr>
					        <tr>
					        	<td><input type="radio" name="month" value="m1"/></td>
					        	<td><input type="radio" name="month" value="m2"/></td>
					        	<td><input type="radio" name="month" value="m3"/></td>
					        	<td><input type="radio" name="month" value="m4"/></td>
					        </tr>
					    </table>
					    
					    <div class="btnWrap">
						    <button class="btn_a" type="button" onclick="window.location='franInfolist.jsp'">취소</button>
						    <input class="btn_b" type="submit" value="결제하기"/>
					    </div>			    
				    </form>
				    
		    	</div>
	    		
			</div>
			<jsp:include page="include/footer.jsp"/>
			
<%	}else{ //파라미터가없을경우 
			response.sendRedirect("franInfolist.jsp");
		} 
	}//else session id가 존재할때 %>
</body>
</html>  