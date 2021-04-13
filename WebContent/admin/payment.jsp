<%@page import="java.util.List"%>
<%@page import="helimy.project.model.BannerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<body>
	<jsp:include page="include/nav.jsp"/>
<%
	BannerDAO dao = BannerDAO.getInstance();
	List img = dao.getBannerImg("master");
%>
	<div class="cont">
		<img src="/helimy/imgupload/<%=img.get(7)%>" width="1400" height="500"/>
	</div>	
</body>
</html>