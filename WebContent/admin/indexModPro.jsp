<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String id = (String)session.getAttribute("memId");	
	int francode = (Integer)session.getAttribute("francode");
	int totalnum = Integer.parseInt(request.getParameter("totalnum"));
	int memnum = Integer.parseInt(request.getParameter("memnum"));
	int nonmemnum = Integer.parseInt(request.getParameter("nonmemnum"));
	
	AdminDAO dao = AdminDAO.getInstance();
	dao.setMemnum(totalnum, memnum, nonmemnum, id, francode); 
	
	response.sendRedirect("index.jsp");
%> 
<html>
<body>
</body>
</html>