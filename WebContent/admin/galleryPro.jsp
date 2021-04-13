<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String path = request.getRealPath("imgupload"); // 저장경로
	int max = 1024*1024*5;							// 파일크기
	String enc = "UTF-8";							// 인코딩타입
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); //파일중복 방지 
	MultipartRequest mr = new MultipartRequest(request, path, max ,enc, dp);
	
	String id = mr.getParameter("id"); 				// 세션아이디로 대체
	Integer francode = Integer.parseInt(mr.getParameter("francode")); 	// 히든으로 넘어온 가맹점코드
	
	//가맹코드 주고 이미지 업로드
	ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
	String[] imgs = new String[19];							//넘어온 이미지 String배열에 순자적으로담기
	for(int i = 0; i < imgs.length; i++){					
		imgs[i] = mr.getFilesystemName("image"+i);			
	}
	for(int i = 0; i < imgs.length; i++){							
		if(imgs[i] == null){
			imgs[i] = "default"+i+".jpg";		//이미지를 선택하지않고 넘어올경우 default이미지 넣어주고 DB에 저장
			String img = imgs[i];			
			imgdao.uploadImg(img, francode);
		}else{
			String img = imgs[i];			//그렇지 않은경우 원래 이미지 넣어주기
			imgdao.uploadImg(img, francode);
		}
	}
	
	response.sendRedirect("index.jsp?id="+ id);
%>
<body>
</body>
</html>