<%@page import="helimy.project.model.FranchiseDAO"%>
<%@page import="helimy.project.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ProductDAO"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<%
	String id = (String)session.getAttribute("memId");	//세션아이디로 변경해야함
	String francode = Integer.toString((int)session.getAttribute("francode"));
	FranchiseDAO frandao = FranchiseDAO.getInstance();
	FranchiseDTO frandto = (FranchiseDTO)frandao.franchiseInfo(id, francode);
%>
<html>
<body>
	<jsp:include page="include/nav.jsp"/>
	<div class="cont">		
	<div class="tableWrap">
	<%-- 매장시설정보가 등록되지않은 시설정보로 확인하고  없으면 등록버튼 --%>
	<%if(frandto.getPromote() == null){ %> 		
	    <form action="facilityPro.jsp" method="post">
	    	<input type="hidden" name="id" value="<%=id%>"/> <%--세션아이디로 대체 삭제--%>
	    	<input type="hidden" name="francode" value="<%=francode%>"/>
	       	<input type="hidden" name="m0" value="m1"/>	<%-- 1개월 --%>
	    	<input type="hidden" name="m1" value="m2"/> <%-- 3개월 --%>
	    	<input type="hidden" name="m2" value="m3"/> <%-- 6개월 --%>
	    	<input type="hidden" name="m3" value="m4"/> <%-- 12개월 --%>
	    	
	    	<p class="tit1">가격설정</p>
	        <table>
	        	<tr>
	        		<th>1개월</th>
	        		<th>3개월</th>
	        		<th>6개월</th>
	        		<th>12개월</th>
	        	</tr>
	        	<tr>
	                <td><input type="text" name="pricem0" /></td>
	                <td><input type="text" name="pricem1" /></td>
	                <td><input type="text" name="pricem2" /></td>
	                <td><input type="text" name="pricem3" /></td>
	            </tr>
	        </table>	    	
	    	
	        <p class="tit1">홍보내역</p>
	        <textarea name="promote" style="width:100%; height:150px;"></textarea>    
	        
	        <p class="tit1">공지사항</p>
	        <textarea name="notice" style="width:100%; height:150px;"></textarea>
	        
	        <p class="tit1">편의시설</p>
	        <textarea name="amenity" style="width:100%; height:150px;"></textarea>
	        
	        <p class="tit1">부가서비스</p>
	        <textarea name="addservice" style="width:100%; height:150px;"></textarea>
	        
	        <div class="btnWrap flex bt">
	 			<input class="btn_a" type="reset" value="리셋">
	 			<input class="btn_b" type="submit" value="등록">
 			</div>
	        
	    </form>
	<%-- 매장시설정보가 등록된 사람에게는 값뿌려주고 수정버튼 --%>
    <%}else{ %>
		<%
			ProductDAO prodao = ProductDAO.getInstance();
			List proMonthlist = prodao.getProuctMonth(francode);	// 개월수 가격만 따로 담아오기
		%>    
	    <form action="facilityModifyPro.jsp" method="post">
	    	<input type="hidden" name="id" value="<%=id%>"/> <%--세션아이디로 대체 삭제--%>
	    	<input type="hidden" name="francode" value="<%=francode%>"/>
	    	<input type="hidden" name="m0" value="m1"/>	<%-- 1개월 --%>
	    	<input type="hidden" name="m1" value="m2"/> <%-- 3개월 --%>
	    	<input type="hidden" name="m2" value="m3"/> <%-- 6개월 --%>
	    	<input type="hidden" name="m3" value="m4"/> <%-- 12개월 --%>
	    	
	    	<p class="tit1">가격설정</p>  	
	        <table>
	        	<tr>
	        		<th>1개월</th>
	        		<th>3개월</th>
	        		<th>6개월</th>
	        		<th>12개월</th>
	        	</tr>
	        	<tr>
	                <%for(int i = 0; i < proMonthlist.size(); i++){
	                	ProductDTO promonthdto = (ProductDTO)proMonthlist.get(i);
	                	if(promonthdto.getPrice() == null){%>
			                <td><input type="text" name="pricem<%=i%>" /></td>
	                	<%}else{%>
	                		<td><input type="text" name="pricem<%=i%>" value="<%=promonthdto.getPrice()%>"/></td>
	                	<%} %>
	                <% } %>
	            </tr>
	        </table>
	      
	      	<p class="tit1">홍보내역</p>
          	<%if(frandto.getPromote() == null){ %>
				<textarea name="promote" style="width:100%; height:150px;"></textarea>
			<%}else{ %>               
           		<textarea name="promote" style="width:100%; min-height:150px;"><%=frandto.getPromote()%></textarea>   
           	<%} %>			
	        
	        <p class="tit1">공지사항</p>	       
	        <%if(frandto.getNotice() == null){ %>
         		<textarea name="notice" style="width:100%; height:150px;"></textarea>
         	<%}else{ %>
         		<textarea name="notice" style="width:100%; min-height:150px;"><%=frandto.getNotice() %></textarea>
         	<%} %>
	        
	        <p class="tit1">편의시설</p>
	        <%if(frandto.getNotice() == null){ %>
         		<textarea name="amenity" style="width:100%; height:150px;"></textarea>
         	<%}else{ %>
         		<textarea name="amenity" style="width:100%; min-height:150px;"><%=frandto.getAmenity() %></textarea>
         	<%} %>
         	
         	<p class="tit1">부가서비스</p>
         	<%if(frandto.getNotice() == null){ %>
         		<textarea name="amenity" style="width:100%; height:150px;"></textarea>
         	<%}else{ %>
         		<textarea name="amenity" style="width:100%; min-height:150px;"><%=frandto.getAddservice() %></textarea>
         	<%} %>
         	
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