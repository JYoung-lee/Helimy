<%@page import="helimy.project.model.BookmarkDAO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
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
		<jsp:include page="include/nav.jsp"/>
<%
	   	String id = (String)session.getAttribute("memId");
	   
	   	BookmarkDAO bookdao = BookmarkDAO.getInstance();
	  	List list = bookdao.getFrancode(id);  
%>
		<div class="cont">
			<p class="tit1">즐겨찾기</p>
			
		<%
		if(list != null){ //list에 받아온 정보가 있으니까 %>
			<div class="tableWrap">
					<table>
						<tr>
							<th>매장명</th>
							<th>매장위치</th>
							<th>전화번호</th>
							<th width="24%">예약 및 삭제</th>
						</tr>
<%		   for(int i = 0; i<list.size(); i++){
		      FranchiseDTO franchise = new FranchiseDTO(); 
		      franchise =(FranchiseDTO)list.get(i);
%>
					<tr>
						<td><%=franchise.getShopname()%></td>
						<td><%=franchise.getShopaddress()%></td>
						<td><%=franchise.getShopphone()%></td>
						<td>
							<button class="btn_e long" onclick="window.location='bookingForm.jsp?id=<%=id%>&francode=<%=franchise.getFrancode()%>'">예약하기</button>
							<button class="btn_e long" onclick="window.location='favoritesDeletePro.jsp?francode=<%=franchise.getFrancode()%>'">삭제하기</button>
						</td>
					</tr>
				
<%			} // for close %>
				</table>
			</div>     
<%		}else{	%>
			<h1>즐겨찾기 목록이 없습니다.</h1>
<%		} //if close %>  
		</div>  
<%	} %>
</body>
</html>
