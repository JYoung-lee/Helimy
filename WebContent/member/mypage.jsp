<%@page import="helimy.project.model.PaymentListDTO"%>
<%@page import="helimy.project.model.ProductDTO"%>
<%@page import="helimy.project.model.PaymentDTO"%>
<%@page import="helimy.project.model.PaymentDAO"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@page import="helimy.project.model.BookingDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.BookingDAO"%>
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
<%
		String id = (String)session.getAttribute("memId");
		BookingDAO bookdao = BookingDAO.getInstance();
		List listbook = bookdao.bookingInfo(id); 
		PaymentDAO paydao = PaymentDAO.getInstance();
		List listpay = paydao.getPayment(id);
%>
		<div class="cont">
		
		<p class="tit1">현재보유한 회원권</p>
				
<%
		if(listpay != null){                        // 정보를 불러왔다는 뜻 %>
			<div class="tableWrap tableWrap2">
				<table>
					<tr>
						<th>매장명</th>
						<th>상품종류</th>
						<th>상태</th>
					</tr>
<%		   for(int i = 0; i < listpay.size(); i++){      // list이기 때문에 for문을 통해서 돌리고
				PaymentListDTO payment = new PaymentListDTO();      
		      	payment = (PaymentListDTO)listpay.get(i);         // 객체를 새로 생성하지않으면 마지막에 모두가 공유되기때문에 
		      	if(payment.getState().equals("on")){         // on/off 확인 
		         	ProductDTO prodto = new ProductDTO();
			      	prodto = paydao.getProductInfo(payment.getPaymentcode());
			        FranchiseDAO franchisedao = FranchiseDAO.getInstance();   
			        String shopname = franchisedao.franchiseName(prodto.getFrancode()); // 0번째있는 francode 를 넣어준거
%>				
					<tr>
						<td><%=shopname%></td>
						<td>
							<%if(prodto.getProductname().equals("m1")){%>
								1개월권	
						<%	}%>
							<%if(prodto.getProductname().equals("m2")){%>
								3개월권
						<%	}%>
							<%if(prodto.getProductname().equals("m3")){%>
								6개월권
						<%	}%>
							<%if(prodto.getProductname().equals("m4")){%>
								12개월권
						<%	}%>
						</td>
						<td>
							<%if(payment.getState().equals("on")){%>
								이용중!
						<%	}%>
						<%if(payment.getState().equals("off")){%>
								기간 만료!
						<%	}%>
						</td>
					</tr>				
<%				} //if %>
<%			} //for  %>
				</table>	
			</div>	
<%		}else{ %>
			<h3> 보유하신 회원권이 없습니다.</h3>  
<%		} 		%>     				
		
		<br/><br/>
		<p class="tit1">현재 내 예약</p>
<%
		if(listbook != null){// 정보를 불러왔다는 뜻 %> 
			
			<div class="tableWrap tableWrap2">
				<table>
					<tr>
						<th>매장명</th>
						<th>상품종류</th>
						<th>예약시간</th>
					</tr>
			
<%		   for(int i = 0; i < listbook.size(); i++){      // list이기 때문에 for문을 통해서 돌리고
				BookingDTO booking = new BookingDTO();      
		      	booking = (BookingDTO)listbook.get(i);         // 객체를 새로 생성하지않으면 마지막에 모두가 공유되기때문에 
		      	if(booking.getState().equals("on")){         // on/off 확인 
		        FranchiseDAO franchisedao = FranchiseDAO.getInstance();   
		        String shopname = franchisedao.franchiseName(booking.getFrancode()); // 0번째있는 francode 를 넣어준거
		        int num = booking.getBookingend() - booking.getBookingstart();
%>				
				
					<tr>
						<td><%=shopname%></td>
						<td><%=num%>시간권</td>
						<td><%=booking.getBookingstart()%>:00 ~ <%=booking.getBookingend()%>:00</td>
					</tr>					
					
<%				} //if %>
<%			} //for  %>
				</table>
			</div>
<%		}else{ %>
			<h3> 예약된 곳이 없습니다.</h3>  
<%		} 		%>     		
		</div>
<%	} %>
</body>
</html>