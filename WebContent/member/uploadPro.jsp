<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Pro</title> <%-- 이미지 저장할수있도록해준다 --%>
</head>
<% request.setCharacterEncoding("UTF-8"); %>

<% 

	String path = request.getRealPath("imgupload");
	System.out.println(path);

	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);

	String img = mr.getFilesystemName("img");
	Integer francode = Integer.parseInt(mr.getParameter("francode"));
		 
	ImageFranchiseDAO dao = ImageFranchiseDAO.getInstance();
	dao.uploadImg(img, francode);
	
%>

<body>
	<h1>이미지가 DB에 저장되었습니다.</h1>
	<h1>코드명<%= francode %></h1>
	<h1>이미지<%= img %></h1>	



</body>
</html>