<%@page import="helimy.project.model.BannerDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%-- 이미지 넣는 Pro --%>
<title>Insert title here</title>
</head>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bannerdto" class="helimy.project.model.BannerDTO" />
<jsp:setProperty property="*" name="bannerdto"/>
<% 
	String path = request.getRealPath("imgupload"); 
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

	String img = mr.getFilesystemName("img");
	String id = mr.getParameter("id");
	
	BannerDAO bannerdao = BannerDAO.getInstance();
	bannerdao.insertBannerImg(id, img);
	
	response.sendRedirect("uploadForm.jsp");
%>
<body>

</body>
</html>