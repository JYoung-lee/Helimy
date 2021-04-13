<%@page import="helimy.project.model.MemberDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="mem" class="helimy.project.model.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mem"/>
<%
	AdminDAO dao = AdminDAO.getInstance();
	dao.insertMember(mem);
%>
<body> 
	 
</body>
</html>