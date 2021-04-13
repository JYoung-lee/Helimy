<%@page import="helimy.project.model.ImageFranchiseDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@page import="helimy.project.model.BookingDTO"%> 
<%@page import="helimy.project.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<% request.setCharacterEncoding("UTF-8"); %>
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
<% 	}else{	//로그인상태
	String id = (String)session.getAttribute("memId");
		if(request.getParameter("francode") != null){
			String francode = request.getParameter("francode");
		   	int temp1 = 0, temp2 = 0;
		   	// 예약 시작시간 담아줄변수
		   	Integer bookingstart = null;              
		   	// 예약 종료시간 담아줄변수
		   	Integer bookingend = null;
		   
		   	for(int i = 0; i < 19; i++){ // 넘어온 데이터 전부 배열에 담아주기
		    	if(request.getParameter("time" + i) != null){
		      		if( temp1 == 0){
		        		temp1 = Integer.parseInt(request.getParameter("time" + i));   //넘어온데이터 문자로 받기
		        	}else if( temp2 == 0){
		        		temp2 = Integer.parseInt(request.getParameter("time" + i));   //넘어온데이터 문자로 받기
		        	}
				}   
		   	}
		   	if( temp1 < temp2){
		    	bookingstart = temp1;
		    	bookingend = temp2;
		   	}else if(temp1 > temp2){
		    	bookingstart = temp2;
		    	bookingend = temp1;
		   	}
		  	//가맹코드, 아이디, 예약시작시간, 예약종료시간 던져주고 DB에 저장
		  	BookingDAO bookingdao = BookingDAO.getInstance();
		  	bookingdao.insertBooking(francode,id,bookingstart,bookingend);
		  	// DB 저장후 예약완료 데이터 뿌려주기
		  	BookingDTO bookingdto = bookingdao.getbookingInfo(francode,id);
		  	Integer totaltime = bookingdto.getBookingend() - bookingdto.getBookingstart(); //총 예약시간 
		   
		  	//해당 아이디의 매장 데이터 뿌려주기
		  	FranchiseDAO frandao = FranchiseDAO.getInstance();
		  	FranchiseDTO frandto = frandao.franchiseInfo(francode);
		   
		   	//해당 매장의 이미지 뿌려주기
		   	ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
		  	ImageFranchiseDTO imgdto = imgdao.getMainImg(Integer.parseInt(francode));
			//가맹코드 던져주고 해당가맹 회원 -1
		  	frandao.deleteMemberNum(frandto);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
%>   
		<jsp:include page="include/top_login.jsp"/>
		<div class="cont cont3">
			<p class="tit1 tac">예약완료! 즐거운 하루되세요!</p>
		<div class="tableWrap">
		   <table style="width:1200px; margin:60px auto;">
		   		<tr>
		   			<th>매장명</th>
		   			<th>예약날짜</th>
		   			<th>총 시간</th>
		   		</tr>
		   		<tr>
		   			<td><%=frandto.getShopname()%></td>
		   			<td><%=sdf.format(bookingdto.getReg()) %> (<%=bookingdto.getBookingstart() %>시~<%=bookingdto.getBookingend() %>시)</td>
		   			<td><%=totaltime%>시간</td>
		   		</tr>		      
		    </table>
		    <div class="btnWrap">
		    	<button class="btn_a" onclick="window.location='memberMain.jsp'">메인으로</button>
		        <button class="btn_b" onclick="window.location='bookingList.jsp'">예약내역</button>
		    </div>
		
		<%}else{ //파라미터가없을경우 
			response.sendRedirect("franInfolist.jsp");
		} 
	}//else session id가 존재할때 %>	
		</div>
		</div>
		<jsp:include page="include/footer.jsp"/> 
</body>
</html>