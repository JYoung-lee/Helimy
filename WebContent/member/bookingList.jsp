<%@page import="helimy.project.model.ReviewDAO"%>
<%@page import="helimy.project.model.BookingDTO"%>
<%@page import="helimy.project.model.FranchiseDAO"%> 
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.BookingDAO"%>
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
		}%>
		<script>
			alert("로그인후 이용해주시기 바랍니다!");
			window.location="/helimy/member/login.jsp";
		</script>
		
<% 	}else{	//로그인상태	%>
		<jsp:include page="include/nav.jsp"/>
<%
		String id = (String)session.getAttribute("memId");
		BookingDAO bookdao = BookingDAO.getInstance();
		List list = bookdao.bookingInfo(id); 
		
		
%>
		<div class="cont">
		<p class="tit1">현재 예약</p>
<%
		if(list != null){// 정보를 불러왔다는 뜻%>
			<div class="tableWrap tableWrap2">    
			<table>
				<tr>
					<th>매장명</th>  
					<th>예약시간</th>					
					<th width="24%">변경 및 취소</th>
				</tr>		
<%		   for(int i = 0; i < list.size(); i++){      // list이기 때문에 for문을 통해서 돌리고
				BookingDTO booking = new BookingDTO();      
		      	booking = (BookingDTO)list.get(i);         // 객체를 새로 생성하지않으면 마지막에 모두가 공유되기때문에 
		      	if(booking.getState().equals("on")){         // on/off 확인 
		         FranchiseDAO franchisedao = FranchiseDAO.getInstance();   
		         String shopname = franchisedao.franchiseName(booking.getFrancode()); // 0번째있는 francode 를 넣어준거
		         
%>
			
				<tr>
					<td><%=shopname%></td>
					<td><%=booking.getBookingstart() %>:00 ~ <%=booking.getBookingend() %>:00</td>
					<td>
						<button class="btn_e long" onclick="window.location='modifyBookingForm.jsp?francode=<%=booking.getFrancode()%>'">예약변경</button>
						<button class="btn_e long" onclick="window.location='modifyBookingDelete.jsp?bookingcode=<%=booking.getBookingcode()%>'">예약취소</button>
					</td>
				</tr> 
<%				} //if %>			
<%			} //for  %>
			</table>
			</div>
<%		}else{ %>
			<h3> 현재 예약목록이 없습니다.</h3>  
<%		} 		%>         
		<p class="tit1">만료된 예약</p>
		
<%		
		if(list != null){%>
			<div class="tableWrap tableWrap2">
				<table>
					<tr>
						<th>번호</th>
						<th>회원명</th>
						<th>매장명</th>
						<th>예약시간</th>
						<th>평점(리뷰)</th>
						<th>상태</th>
						<th>리뷰</th>
					</tr>	
<%			for(int i = 0; i < list.size(); i++){      // list이기 때문에 for문을 통해서 돌리고
				int count=0;
				BookingDTO booking = new BookingDTO();      
			  	booking = (BookingDTO)list.get(i);         // 객체를 새로 생성하지않으면 마지막에 모두가 공유되기때문에 
			  	if(booking.getState().equals("stop")){         // on/off 확인 
				    FranchiseDAO franchisedao = FranchiseDAO.getInstance();   
				    String shopname = franchisedao.franchiseName(booking.getFrancode()); // 0번째있는 francode 를 넣어준거	
					ReviewDAO reviewdao = ReviewDAO.getInstance();
				    String francode = booking.getFrancode()+"";
					double totalPoint = reviewdao.getPoint(francode);	//평점 총점가져오기
					String tp = String.format("%.1f", totalPoint);
					boolean check = reviewdao.checkReview(id,booking.getFrancode());	//기존에 답글 달았었는지 체크
%>				
					<tr>
						<td><%=++count%></td>
						<td><%=id%></td>
						<td><%=shopname%></td>
						<td><%=booking.getBookingstart()%> ~ <%=booking.getBookingend()%></td>
						<td><%=tp%></td>
						<td>사용완료</td>
<%					if(check == true){	//기존에 리뷰 남겼으면		%>
						<td><button class="btn_n long">작성완료</button></td>
<%					}else{				//기존 리뷰가 없으면		%>						
						<td><button class="btn_e long" onclick="window.location='franReviewForm.jsp?bookingcode=<%=booking.getBookingcode()%>'">리뷰작성</button>  </td>
<%					} %>						
					</tr>      
<%			  	}		  	
			}
		}else{		%>
			<h3> 만료된 예약목록이 없습니다.</h3>  
<%		}
%>			
		</table>	
		</div>
		</div>
<%	} %>
</body>
</html>