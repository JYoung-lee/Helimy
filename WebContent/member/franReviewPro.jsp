<%@page import="helimy.project.model.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>후기작성완료</title>
</head>
<%	
	request.setCharacterEncoding("UTF-8");
%> 
<body>
<!-- francode, id, point, content  -->
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
		
<% 	}else{	//로그인상태
		String id = (String)session.getAttribute("memId");
		if(request.getParameter("francode") ==null || request.getParameter("point") ==null || request.getParameter("content") ==null ){
			response.sendRedirect("bookingList.jsp");
		}else{
			int francode = Integer.parseInt(request.getParameter("francode"));
			double point = Double.parseDouble(request.getParameter("point"));
			String content = request.getParameter("content");
			
			ReviewDAO review = ReviewDAO.getInstance();
			boolean res = review.insertReview(id,francode,point,content);
			
			if(res){//리뷰 작성 성공시	%>
				<script>
					alert("작성을 완료했습니다.");
					window.location="/helimy/member/bookingList.jsp";
				</script>
<%			}else{//리뷰 작성 실패시	%>
				<script>
					alert("작성이 실패했습니다. 다시시도하세요.");
					window.location="/helimy/member/bookingList.jsp";
				</script>
<%			}
		}

%>
<%	} %>
</body>
</html>
