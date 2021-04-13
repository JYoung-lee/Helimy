<%@page import="helimy.project.model.ProductDTO"%>
<%@page import="helimy.project.model.ProductDAO"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="include/header.jsp"/>
<body>
<jsp:include page="include/nav.jsp"/>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="frandto" class="helimy.project.model.FranchiseDTO" />
<jsp:setProperty property="*" name="frandto"/>

<%
	//시설정보 저장
	FranchiseDAO frandao = FranchiseDAO.getInstance();
	frandao.insertFacility(frandto); 
	
	
	//상품명,상품가격저장
	Integer francode = frandto.getFrancode(); 								// ProductDAO에 사용할변수 가맹코드
	
	ProductDAO productdao = ProductDAO.getInstance();
	ProductDTO prodto = new ProductDTO();									// ProductDTO 생성
	
	Integer[] pricemset = new Integer[4];									// 개월 가격 넣을 배열 생성
	for(int i = 0; i < pricemset.length; i++){								
		pricemset[i] = Integer.parseInt(request.getParameter("pricem"+i));	// 문자로 넘어온 가격 숫자로변환
	}
	for(int i = 0; i < pricemset.length; i++){
		prodto.setFrancode(francode);										// francode값입력
		prodto.setProductname(request.getParameter("m"+i));					// 히든으로넘어온 m0 ~ m3 순차적으로 값 넣어주기
		prodto.setPrice(pricemset[i]);										// m0~ m3 맞게 가격 값 넣어주기
		productdao.modifyProduct(prodto);
	} 
%>
	<div class="cont cont3 width1200">
	<div class="tableWrap">
		<table>
			<tr>
				<td><p class="tit1">시설정보 수정이 완료되었습니다.</p><td>		
			</tr>
			<tr>
				<td>
					<input type="button" value="시설정보변경확인" onclick="window.location='facility.jsp?francode=<%=francode%>'" />
					<input type="button" value="이미지정보변경" onclick="window.location='gallery.jsp?francode=<%=francode%>'" />
					<%-- 메인버튼 만들기 <input type="button" value="관리자메인" onclick="window.location='.jsp?francode=<%=francode%>'" /> --%>
				</td>		
			</tr>
		</table>
	</div>
	</div>
</body>
</html>