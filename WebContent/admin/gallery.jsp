<%@page import="helimy.project.model.ImageFranchiseDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>

<%request.setCharacterEncoding("UTF-8"); %>
<%
	String id = (String)session.getAttribute("memId"); //세션아이디로 변경해야함
	String francode = Integer.toString((int)session.getAttribute("francode"));
	ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
	int count = imgdao.getImgCount(francode); 			//등록 메인이면 1개 등록되어있으면 1개이상
%>
<body>
	<jsp:include page="include/nav.jsp"/>
	<div class="cont">
	<%if(count <= 1) {%>
		<p class="tit1">매장 이미지 등록</p>
	    <form action="galleryPro.jsp" method="post" enctype="multipart/form-data">
	    	<input type="hidden" name="id" value="<%=id%>" /> <%-- 나중에 세션아이디로 대체 삭제해야함 --%>
	    	<input type="hidden" name="francode" value="<%=francode%>" /> 
	        <ul class="img40">
	        <%for(int i = 0; i <= 19; i++){ %>
	            <li>
	                <input type="file" name="image<%=i%>">
	            </li>
	        <%}%>	        	
	        </ul>
	        <div class="btnWrap flex bt">
	 			<input class="btn_a" type="reset" value="리셋">
	 			<input class="btn_b" type="submit" value="등록">
 			</div>
	    </form>
    <%}else{ %>
    <%
  	 	String[] imglist = new String[19];					// 히든으로 넘겨줄 이미지들 담기
		List franimgs = imgdao.getImgList(francode);		// 메인제외한 나머지 이미지들 가져오기
    %>
	    <form action="galleryModifyPro.jsp" method="post" enctype="multipart/form-data">
	    	<input type="hidden" name="id" value="<%=id%>" /> <%-- 나중에 세션아이디로 대체 삭제해야함 --%>
	    	<input type="hidden" name="francode" value="<%=francode%>" /> 
	        <ul class="img40">
		        <%	
		        	for(int i = 0; i < franimgs.size(); i++){ 			
		        	ImageFranchiseDTO imgdto = (ImageFranchiseDTO)franimgs.get(i);
		        	imglist[i] = imgdto.getImage();
		        	%>
		        	<% if(imgdto.getImage() == null){%>
			        <li>
		        		<input type="file" name="image<%=i%>">
		        	</li>
	        		<% }else{ %>
	        		<li>
		        		<img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="auto" height="100"/>
		        		<input type="file" name="image<%=i%>" style="display:block; width:200px; margin:8px auto 0;"/>
		        		<input type="hidden" name="imglist<%=i%>" value="<%=imglist[i]%>"/>
					</li>	        
	          		<%} %> 
	       		 <%}//for%>
	        </ul>
	        <div class="btnWrap flex bt">
	 			<input class="btn_a" type="reset" value="리셋">
	 			<input class="btn_b" type="submit" value="수정">
 			</div>
	    </form>
    <%} %>
	</div>
</body>
</html>