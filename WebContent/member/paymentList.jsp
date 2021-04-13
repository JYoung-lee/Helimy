<%@page import="helimy.project.model.PaymentListDTO"%>
<%@page import="java.util.List"%>
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
		if(coos != null){	//쿠키가 존재해
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
		String id = (String)session.getAttribute("memId");	//session아이디로 정보 불러오기
	    PaymentDAO paydao = PaymentDAO.getInstance();
	   	List list = paydao.getPayment(id); 
%>
		<div class="cont">
		    <p class="tit1">결제내역</p>
		    <div class="tableWrap tableWrap2">
		    <table>
		          <tr>
		              <th>구분</th>
		              <th>결제코드</th>
		              <th>결제시간</th>
		              <th>매장명</th>
		              <th>상품명</th>
		              <th>결제금액</th>
					  <th>비고</th>    
		          </tr>
<%		if(list != null){      // 매장 결제정보를 가져왔을때
			int count = 1;
			for(int i= 0; i < list.size(); i++){   
	            PaymentListDTO dto = new PaymentListDTO();
	            dto = (PaymentListDTO)list.get(i);  
	            if(dto.getState().equals("on")){    %>
	                <tr>
	                    <td><%=count++ %></td>
	                    <td><%=dto.getPaymentcode()%></td>
	                    <td><%=dto.getReg()%></td>
	                    <td><%=dto.getShopname()%></td>
	                    <td><%=dto.getProductname()%></td>
	                    <td><%=dto.getPrice()%></td>
	                    <td><button class="btn_e long" onclick="window.location='paymentDeleteForm.jsp?paymentcode=<%=dto.getPaymentcode()%>'">결제취소</button></td>     
	                </tr>
	<%          }else if(dto.getState().equals("stop")){ %>
					 <tr>
	                    <td><%=count++ %></td>
	                    <td><%=dto.getPaymentcode()%></td>
	                    <td><%=dto.getReg()%></td>
	                    <td><%=dto.getShopname()%></td>
	                    <td><%=dto.getProductname()%></td>
	                    <td><%=dto.getPrice()%></td>
	                    <td><button class="btn_n long">사용완료</button></td>     
	                </tr>
				<%}//if close 
			}   //for close   %>
		       </table> 
		       </div> 
<%		}else{   // 매장결제정보 잘못 가져왔을 경우%>
		      <script>
		         alert("잘못");
		         history.go(-1);
		      </script>      
<%   	} %>
		</div>    
<%	} %>        
</body>
</html>