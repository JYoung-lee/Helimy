<%@page import="helimy.project.model.FranchiseDAO"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="include/header.jsp"/>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	
	
	String path = request.getRealPath("imgupload");				//img업로드위치
	int max = 1024*1024*5;										//파일크기 
	String enc = "UTF-8";										//인코딩 타입
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();	//파일 중복되지 않게
	
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	String francode = Integer.toString((int)session.getAttribute("francode"));
	String id = (String)session.getAttribute("memId"); // 세션아이디로 변경
	//넘어온 이미지 DAO에 넘겨주고 이미지 DB에 넣기
	String img = mr.getFilesystemName("img");	//바꿀이미지명
	String imgs = mr.getParameter("imgs");		//원래이미지명
	if(img != null){	//이미지를 변경했을경우 바꿀이미지 ,가맹코드,원래이미지를 가져와넣어준다
		ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
		imgdao.imgModify(img,francode,imgs);	//바꿀이미지,가맹코드,원래이미지
	}
	
	//파일이 넘어와서 하나씩 DTO에 넣어주기 
	FranchiseDTO frandto = new FranchiseDTO();
	frandto.setFrancode(Integer.parseInt(francode));						// 매장코드
	frandto.setId(id);														// 세션아이디 넣어주기
	frandto.setShopname(mr.getParameter("shopname"));						// 매장명
	frandto.setShopaddress(mr.getParameter("shopaddress"));					// 매장주소
	frandto.setShopphone(mr.getParameter("shopphone"));						// 매장 전화번호
	frandto.setWeekday(mr.getParameter("weekday"));							// 운영시간 평일
	frandto.setSat(mr.getParameter("sat"));									// 토요일
	frandto.setSun(mr.getParameter("sun"));									// 일요일
	frandto.setTotalnum(Integer.parseInt(mr.getParameter("totalnum")));		// 총인원 받을 수
	frandto.setMembernum(Integer.parseInt(mr.getParameter("membernum")));	// 회원 받을 수
	frandto.setNonmemnum(Integer.parseInt(mr.getParameter("nonmemnum")));	// 비회원 받을 수
	//넘어온 매장정보 FranchiseDTO담아 DB 넘겨 저장하기
	FranchiseDAO frandao = FranchiseDAO.getInstance();
	frandao.insertFranchise(frandto);
%>

	<jsp:include page="include/nav.jsp"/>
	<div class="cont cont3 width1200">
	<div class="tableWrap">
		<table>
			<tr>
				<td><p class="tit1">수정완료</p></td>	
			</tr>
			<tr>
				<td>
					<input type="button" value="변경정보확인" onclick="window.location='info.jsp?francode=<%=francode%>'" />
					<input type="button" value="시설정보변경" onclick="window.location='facility.jsp?francode=<%=francode%>'" />
				</td>		
			</tr>
		</table>
	</div>   
	</div>	
</body>
</html>