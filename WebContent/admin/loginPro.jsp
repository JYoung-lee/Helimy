<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = "adminK";
	session.setAttribute("memId", id);
	response.sendRedirect("franlist.jsp");
%>
<body>

</body>
</html>