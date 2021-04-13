<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	int first = Integer.parseInt(request.getParameter("first"));	
	int francode = Integer.parseInt(request.getParameter("francode"));
	//System.out.println(request.getParameter("francode"));
	session.setAttribute("francode", francode);	
	if(first==1){
		session.setAttribute("first", first);
		response.sendRedirect("info.jsp");
	}else{
		response.sendRedirect("index.jsp");
	}
%>
<body>
</body>
</html>