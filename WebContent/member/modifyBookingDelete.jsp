<%@page import="helimy.project.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
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
<% 
		String id = (String)session.getAttribute("memId");	
		if(request.getParameter("bookingcode") == null){	//인자없이 바로 이페이지로 넘어오면 bookinglist로 보내준다.
			response.sendRedirect("bookingList.jsp");
		}else{
	
			int bookingcode = Integer.parseInt(request.getParameter("bookingcode"));
			
			BookingDAO bookdao = BookingDAO.getInstance();
			boolean result = bookdao.cancleBooking(id, bookingcode);	//취소가 됐는지 확인하기 위한 변수와 메서드
			
			if(result){		//취소가 잘 변경 되었습니다.	%>
				<h1>예약취소 완료!</h1>
		        <button onclick="window.location='bookingList.jsp'">확인</button>   
		<%		
				response.sendRedirect("bookingList.jsp");
			}else{			//취소가 실패했을 경우		%>
				<script>
					alert("실패했습니다. 다시시도해주세요.");
					window.location="bookingList.jsp";
				</script>
<%	
			}
		}//null else close
	%>		
<%	}//else close(session유무) %>	

        
</body>
</html>