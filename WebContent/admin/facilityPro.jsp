<%@page import="helimy.project.model.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>facilityPro</title>
</head>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="frandto" class="helimy.project.model.FranchiseDTO" />
<jsp:setProperty property="*" name="frandto"/>

<%
	//시설정보 저장
	FranchiseDAO frandao = FranchiseDAO.getInstance();
	frandao.insertFacility(frandto); 							// 가맹DAO에 시설정보 저장하기

	//상품명,상품가격저장
	Integer francode = frandto.getFrancode(); 	// ProductDAO에 사용할변수 가맹코드
	
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
		productdao.insertProduct(prodto);
	} 
	
	response.sendRedirect("gallery.jsp?francode="+francode);
%>
<body>
	 

</body>
</html>