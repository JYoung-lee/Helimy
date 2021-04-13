<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="include/header.jsp"/>
<body>
<jsp:include page="include/nav.jsp"/>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String path = request.getRealPath("imgupload");				//img업로드위치
	int max = 1024*1024*5;										//파일크기 
	String enc = "UTF-8";										//인코딩 타입
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();	//파일 중복되지 않게
	MultipartRequest mr = new MultipartRequest(request,path, max, enc, dp);
	
	String francode = mr.getParameter("francode");
	String id = mr.getParameter("id"); // 세션아이디로 변경
	
	ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
	String[] imglistset = new String[19];							//넘어온 원래이미지명 String배열에 순자적으로담기
	for(int i = 0; i < imglistset.length; i++){					
		imglistset[i] = mr.getParameter("imglist"+i);
	}//for
	
	String[] imgset = new String[19];								//넘어온 바꿀이미지명
	for(int i = 0; i < imgset.length; i++){					
		imgset[i] = mr.getFilesystemName("image"+i);		
	}//for
	
	for(int i = 0; i < imglistset.length; i++){							
		if(imgset[i] != null){							//이미지를 변경했을경우 바꿀이미지 ,가맹코드,원래이미지를 가져와넣어준다
			String imgs = imgset[i];					//바꿀이미지명
			String imglist = imglistset[i];				//원래이미지명
			imgdao.imgModify(imgs, francode, imglist);	//바꿀이미지,가맹코드,원래이미지
		}//if
	}//for
%>
</body>
	<div class="cont cont3 width1200">
	<div class="tableWrap">
	<table>
		<tr>
			<td><p class="tit1">수정이 완료되었습니다.</p></td>		
		</tr>
		<tr>
			<td>
				<input type="button" value="메인으로" onclick="window.location='index.jsp?id=<%=id%>'" />
			</td>		
		</tr>
	</table>
	</div>   
	</div>
</html>