<%@page import="helimy.project.model.ImageFranchiseDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<%
	//가맹코드랑 id값 가져오기
	
	String id = (String)session.getAttribute("memId"); //admin1111
	String francode = Integer.toString((int)session.getAttribute("francode"));  // 10
	//System.out.println(francode);
	
	//id와 가맹코드로 매장이름을 가져와 등록인지 수정인지 가져오기
	FranchiseDAO frandao = FranchiseDAO.getInstance(); 			// franDAO연결
  	FranchiseDTO frandto = frandao.franchiseInfo(id,francode); 	// id,가맹코드던져주고 해당 정보가져오기
  	String shopname = frandto.getShopname();
%>
<html>
<body>
	<jsp:include page="include/nav.jsp"/>
	<div class="cont">		
		<div class="tableWrap tableWrap2">
	<%-- 매장이 등록되어있지않은 경우 --%>
	<%if(shopname == null){ %>
		<form action="infoPro.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="<%=id%>"> <%--세션아이디로 대체할거임 나중에 삭제--%>
			<input type="hidden" name="francode" value="<%=francode%>">
			
			<p class="tit1">매장이미지</p>
 			<table class="width380">
 				<tr>
 					<th>썸네일</th>
 				</tr>
 				<tr>
 					<td><input class="input_a" type="file" class="input" name="img"/></td>
 				</tr>
 			</table>
			
			<p class="tit1">매장정보</p>
 			<table>
 				<tr>
 					<th>매장명</th>
 					<th>주소</th>
 					<th>전화번호</th> 					
 				</tr>
 				<td> 				
 					<td><input class="input_a" type="text" name="shopname"/></td>
 					<td><input class="input_a" type="text" name="shopaddress"/></td>
 					<td><input class="input_a" type="text" name="shopphone"/></td> 					
 				</tr>
 			</table>
 			
 			<p class="tit1">운영시간</p>
 			<table>
 				<tr>
 					<th>월~금</th>
 					<th>토</th>
 					<th>일</th>
 				</tr>
 				<tr>
 					<td><input class="input_a" type="text" name="weekday"/></td>
 					<td><input class="input_a" type="text" name="sat"/></td>
 					<td><input class="input_a" type="text" name="sun"/></td>
 				</tr>
 			</table>
 			
 			<p class="tit1">수용인원</p>
 			<table>
 				<tr>
 					<th>총</th>
 					<th>회원</th>
 					<th>비회원</th>
 				</tr>
 				<tr>
 					<td><input class="input_a" type="text" name="totalnum" /></td>
 					<td><input class="input_a" type="text" name="membernum" /></td>
 					<td><input class="input_a" type="text" name="nonmemnum" /></td>
 				</tr>
 			</table>
 			
 			<div class="btnWrap flex bt">
	 			<input class="btn_a" type="reset" value="리셋">
	 			<input class="btn_b" type="submit" value="등록">
 			</div>
 			     
		</form>
    <%-- 매장이 있는경우 --%>
    <%}else{ %>
    <%  	
	  	ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();	// imgDAO 연결
	  	ImageFranchiseDTO imgdto = imgdao.getMainImg(Integer.parseInt(francode));
	  	String imgs = imgdto.getImage();	//현재이미지 파라미터로 넘겨준다.
    %>
		<form action="infoModifyPro.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="<%=id%>"> <%--세션아이디로 대체할거임 나중에 삭제--%>
			<input type="hidden" name="francode" value="<%=francode%>">
			
			<p class="tit1">매장이미지</p>
 			<table class="width380">
 				<tr>
 					<th>썸네일</th>
 				</tr>
 				<tr>
 					<td>
 						<%if(imgdto.getImage() == null){ %>
	                		<input type="file" class="input" name="img"/>
	                	<%}else{%>
	                		<img src="/helimy/imgupload/<%=imgs%>.jpg" width="350" height="auto"/>   		
							<input type="file" name="img" />
							<input type="hidden" name="imgs" value="<%=imgs%>"/>
	                	<%} %>
 					</td>
 				</tr>
 			</table>
			
			<p class="tit1">매장정보</p>
 			<table>
 				<tr>
 					<th>매장명</th>
 					<th>주소</th>
 					<th>전화번호</th>
 				</tr>
 				<tr> 					
 					<td><input class="input_a" type="text" name="shopname" value="<%=frandto.getShopname() %>" /></td>
 					<td><input class="input_a" type="text" name="shopaddress" value="<%=frandto.getShopaddress() %>" /></td>
 					<td><input class="input_a" type="text" name="shopphone" value="<%=frandto.getShopphone()%>" /></td> 					
 				</tr>
 			</table>
 			
 			<p class="tit1">운영시간</p>
 			<table>
 				<tr>
 					<th>월~금</th>
 					<th>토</th>
 					<th>일</th>
 				</tr>
 				<tr>
 					<td><input class="input_a" type="text" name="weekday" value="<%=frandto.getWeekday()%>" /></td>
 					<td><input class="input_a" type="text" name="sat" value="<%=frandto.getSat() %>" /></td>
 					<td><input class="input_a" type="text" name="sun" value="<%=frandto.getSun() %>" /></td>
 				</tr>
 			</table>
 			
 			<p class="tit1">수용인원</p>
 			<table>
 				<tr>
 					<th>총</th>
 					<th>회원</th>
 					<th>비회원</th>
 				</tr>
 				<tr>
 					<td><input class="input_a" type="text" name="totalnum" value="<%=frandto.getTotalnum() %>" /></td>
 					<td><input class="input_a" type="text" name="membernum" value="<%=frandto.getMembernum() %>" /></td>
 					<td><input class="input_a" type="text" name="nonmemnum" value="<%=frandto.getNonmemnum() %>" /></td>
 				</tr>
 			</table>
 			
 			<div class="btnWrap flex bt">
	 			<input class="btn_a" type="reset" value="리셋">
	 			<input class="btn_b" type="submit" value="수정">
 			</div>
 			      	
		</form>
    <%} %>
	</div>   
	</div>
</body>
</html>