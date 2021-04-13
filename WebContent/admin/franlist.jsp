<%@page import="java.util.List"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%

	String id = (String)session.getAttribute("memId");
	AdminDAO dao = AdminDAO.getInstance();
	List franList = dao.getFranlist(id);
	
	
%>
<body>
	<div class="cont cont2 width550 centerbox">
		<p class="logo"><a href="../member/nonmemberMain.jsp"></a></p>
		<p class="txt">가맹점을 선택해 주세요.</p>
		<ul class="franlist">
		<%
		for(int i = 0; i < franList.size(); i++){
			FranchiseDTO dto = new FranchiseDTO();
			dto = (FranchiseDTO)franList.get(i);
			if(dto.getShopname()!=null){%>
				<form action="franinPro.jsp" method="get">
				<li>
					<p class="tit5 tac"><%=dto.getShopname() %></p>					
					<p class="tit6 tac">(<%=dto.getShopaddress() %>)</p>
					<p class="txt1 tac">등록일 <%=dto.getReg() %></p>
					<input type="hidden" name="francode" value="<%=dto.getFrancode() %>" />
					<input type="hidden" name="first" value="0"/>
					<input class="btn_e middle center" type="submit" value="선택"/>
				</li>
				</form>
			<%}else{%>
				<form action="franinPro.jsp?first=1" method="get">
				<li>
					<p class="tit5 tac">가맹점 정보 등록이 필요합니다!</p>					
					<p class="txt1 tac">등록일 <%=dto.getReg() %></p>
					<input type="hidden" name="francode" value="<%=dto.getFrancode() %>" />
					<input type="hidden" name="first" value="1"/>
					<input class="btn_e middle center" type="submit" value="등록"/>				
				</li>
				</form>
			<%}
		}%>
		</ul>
	</div>

</body>
</html>