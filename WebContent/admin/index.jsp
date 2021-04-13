<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<%
	String id = (String)session.getAttribute("memId");
	AdminDAO dao = AdminDAO.getInstance();
	int francode = (Integer)session.getAttribute("francode");
	FranchiseDTO fran = dao.getFran(id, francode);
%>
<html>
<body>
	<jsp:include page="include/nav.jsp"/>
	
	<div class="cont">
		<p class="tit1">환영합니다! <%=session.getAttribute("memId") %>님</p>
		
		<p class="line nn"></p>
		
		<div class="tableWrap tableWrap2">		
			
			<table>
				<tr>
					<th>선택매장</th>
					<th>주소</th>
					<th>전화번호</th>
				</tr>
				<tr>
					<td><%=fran.getShopname() %></td>
					<td><%=fran.getShopaddress() %></td>
					<td><%=fran.getShopphone() %></td>
				</tr>
			</table>
			
			<p class="tit1">신규 소식</p>
			<table>
				<tr>
					<th>신규예약</th>
					<th>신규회원</th>
					<th>신규리뷰</th>
				</tr>
				<tr>
					<td>준비중</td>
					<td>준비중</td>
					<td>준비중</td>
				</tr>
			</table>
			
			<p class="tit1">수용인원 조절</p>
			<form id="indexmod">
			<table>
				<tr>
					<th>신규예약</th>
					<th>신규회원</th>
					<th>신규리뷰</th>
					<th width="15%"></th>
				</tr>
				<tr>
					<td><input id="mem1" class="input_a" type="text" name="totalnum" value="<%=fran.getTotalnum() %>" /></td>
					<td><input id="mem2" class="input_a" type="text" name="memnum" value="<%=fran.getMembernum() %>" /></td>
					<td><input id="mem3" class="input_a" type="text" name="nonmemnum" value="<%=fran.getNonmemnum() %>" readonly/></td>
					<td><input id="btn_mod" class="btn_e long" type="button" value="수정"></td>
				</tr>
			</table>					
			</form>
			
			<script type="text/javascript">		
				$(function(){
					$('#mem1').keyup(function(){
						$('#mem3').val($('#mem1').val()-$('#mem2').val());
					});
					$('#mem2').keyup(function(){
						$('#mem3').val($('#mem1').val()-$('#mem2').val());
					});
				});
				
				$('#btn_mod').click(function(){
					$.ajax({
				         type: 'POST',    
				         url: "indexModPro.jsp",   //전송할 url
				         data: $('#indexmod').serialize(),    //form id를 입력하자
				         success: function(response) {   //성공했을시의 동작.				             
				        	 /*location.href="signupPro.jsp";*/
				        	 alert("수정완료");
				         },
				        error: function() {    //오류났을때 동작
				            alert("에러났음");
				        }
				     });					
				});
			</script>

			<p class="tit1">메모장</p>
			<textarea style="width:100%; height:150px;"></textarea>
			
		</div>		
	</div>
	
</body>
</html>