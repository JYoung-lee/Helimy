<%@page import="helimy.project.model.BannerDAO"%>
<%@page import="helimy.project.model.ImageFranchiseDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="helimy.project.model.FranchiseDTO"%> 
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
   <script>
      function inputCheck(){
         var inputs = document.getElementsByClassName("time");
         var count = 0;
         var num1 = -1;
         var num2 = -1;
         for(var i = 0; i < inputs.length; i++){
            if(inputs[i].checked == true){
               ++count;
               if(count == 1){
                  num1 = inputs[i].value;
               }
               if(count == 2){
                  num2 = inputs[i].value;
               }
            }
         }
         // 갯수확인
         if(count == 2){
            if(Math.abs(num1-num2) > 0 && Math.abs(num1-num2) < 4 ){
               return true;
            }else{
               alert("최대 3시간까지 가능합니다.");
               return false;
            }
         }else{
            alert("시작과 끝을 다시 설정하세요.");
            return false;
         }
      }
   </script>
<%request.setCharacterEncoding("UTF-8");%>
<body>
<%-- 아이디가 비로그인상태이거나 쿠키가 없을경우 --%>
<%	if(session.getAttribute("memId") == null){	//비로그인상태 
		//session은 존재하지 않지만 쿠키가 존재할 수 있으니 2중체크
		String id = null, pw= null, auto=null;
		Cookie[] coos = request.getCookies();
		if(coos != null){
			for(Cookie c : coos){
				if(c.getName().equals("autoId")) id = c.getValue();
				if(c.getName().equals("autoPw")) pw = c.getValue();
				if(c.getName().equals("autoCh")) auto = c.getValue();
			}
		}	
		if(auto != null && id != null && pw != null){	//cookie가 존재해서 그 아이디가 존재한다면 로그인 시켜주기
			// 로그인상태를 유지시켜주는 세션, 이것이 만들어지는 pro 이동
			response.sendRedirect("loginPro.jsp");
		}
%>
		<script>
			alert("로그인후 이용해주시기 바랍니다!");
			window.location="/helimy/member/login.jsp";
		</script>
<% 	}else{	//로그인상태
		String id = (String)session.getAttribute("memId");
		if(request.getParameter("francode") != null){
			String francode = request.getParameter("francode");
			FranchiseDAO frandao = FranchiseDAO.getInstance();
			FranchiseDTO frandto = frandao.franchiseInfo(francode);
			ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
			ImageFranchiseDTO imgdto = imgdao.getMainImg(Integer.parseInt(francode));
			BannerDAO bannerdao = BannerDAO.getInstance();
			List bannerimg = bannerdao.getBannerImg("master");
			
%>
			<jsp:include page="include/top_login.jsp"/>
			<div class="cont cont3 width1200">
			<div class="tableWrap">
			
				<p class="tit1">매장정보</p>
			   	<table>
			   		<tr>
			   			<th>매장명</th>
			   			<th>총수용가능인원</th>
			   			<th>회원수</th>
			   			<th>바로예약가능 여부</th>
			   		</tr>
			   		<tr>
			   			<td><%=frandto.getShopname() %></td>
			   			<td><%=frandto.getTotalnum() %></td>
			   			<td><%=frandto.getMembernum() %></td>
			   			<td>
			   				<%if(frandto.getMembernum() == 0 || frandto.getNonmemnum() == 0){ %>
			             		불가
				        	<%}else{%>
				            	가능
				           	<%}%> 
			   			</td>
			   		</tr>          
				</table>
				
				<p class="tit1">유의사항</p>
			  	<table>
			        <tr>
			            <th>예약 시간 변경 / 취소 방법</th>
			            <th>환불 시</th>
			        </tr>
			        <tr>
			            <td><img src="/helimy/imgupload/<%=bannerimg.get(4)%>" width="200" height="200"/></td>
			            <td><img src="/helimy/imgupload/<%=bannerimg.get(5)%>" width="200" height="200"/></td>
			        </tr>
			    </table> 
			    
			    <p class="tit1">예약시간선택</p>
			    <%if(frandto.getMembernum() != 0 || frandto.getNonmemnum() != 0){ %>
			    <form action="bookingPro.jsp" method="post" onsubmit="return inputCheck()"> 
			    	<input type="hidden" name="id" value="<%=id%>"/>
			    	<input type="hidden" name="francode" value="<%=francode%>"/>
			    	<div style="display:flex;">
				    	<table style="width:575px; margin-right:50px;">
				    		<tr>
				    			<th width="70%">시간</th>
				    			<th>선택</th>
				    		</tr>
				    		<tr>
				    			<td>06:00</td>
				    			<td><input type="checkbox" class="time" name ="time0" value="6"/></td>
				    		</tr>
				    		<tr>
				    			<td>07:00</td>
				    			<td><input type="checkbox" class="time" name ="time1" value="7"/></td>
				    		</tr>
				    		<tr>
				    			<td>08:00</td>
				    			<td><input type="checkbox" class="time" name ="time2" value="8"/></td>
				    		</tr>
				    		<tr>
				    			<td>09:00</td>
				    			<td><input type="checkbox" class="time" name ="time3" value="9"/></td>
				    		</tr>
				    		<tr>
				    			<td>10:00</td>
				    			<td><input type="checkbox" class="time" name ="time4" value="10"/></td>
				    		</tr>
				    		<tr>
				    			<td>11:00</td>
				    			<td><input type="checkbox" class="time" name ="time5" value="11"/></td>
				    		</tr>
				    		<tr>
				    			<td>12:00</td>
				    			<td><input type="checkbox" class="time" name ="time6" value="12"/></td>
				    		</tr>
				    		<tr>
				    			<td>13:00</td>
				    			<td><input type="checkbox" class="time" name ="time7" value="13"/></td>
				    		</tr>
				    		<tr>
				    			<td>14:00</td>
				    			<td><input type="checkbox" class="time" name ="time8" value="14"/></td>
				    		</tr>
				    		<tr>
				    			<td>15:00</td>
				    			<td><input type="checkbox" class="time" name ="time9" value="15"/></td>
				    		</tr>
				    	</table>
				    	<table style="width:575px;">
				    		<tr>
				    			<th width="70%">시간</th>
				    			<th>선택</th>
				    		</tr>
				    		<tr>
				    			<td>16:00</td>
				    			<td><input type="checkbox" class="time" name ="time10" value="16"/></td>
				    		</tr>
				    		<tr>
				    			<td>17:00</td>
				    			<td><input type="checkbox" class="time" name ="time11" value="17"/></td>
				    		</tr>
				    		<tr>
				    			<td>18:00</td>
				    			<td><input type="checkbox" class="time" name ="time12" value="18"/></td>
				    		</tr>
				    		<tr>
				    			<td>19:00</td>
				    			<td><input type="checkbox" class="time" name ="time13" value="19"/></td>
				    		</tr>
				    		<tr>
				    			<td>20:00</td>
				    			<td><input type="checkbox" class="time" name ="time14" value="20"/></td>
				    		</tr>
				    		<tr>
				    			<td>21:00</td>
				    			<td><input type="checkbox" class="time" name ="time15" value="21"/></td>
				    		</tr>
				    		<tr>
				    			<td>22:00</td>
				    			<td><input type="checkbox" class="time" name ="time16" value="22"/></td>
				    		</tr>
				    		<tr>
				    			<td>23:00</td>
				    			<td><input type="checkbox" class="time" name ="time17" value="23"/></td>
				    		</tr>
				    		<tr>
				    			<td>24:00</td>
				    			<td><input type="checkbox" class="time" name ="time18" value="14"/></td>
				    		</tr>
				    	</table>
				    	</div>
				    	
				    	<div class="btnWrap">
					    	<input class="btn_b" type="submit" value="예약하기" />
					    	<input class="btn_a" type="button" onclick="window.location='franInfolist.jsp'" value="취소" />
				    	</div>
			    	
			    </form>   
			    <%}else{%>
			    		<div class="btnWrap">
					    	<input class="btn_c" type="button" onclick="window.location='franInfolist.jsp'" value="뒤로가기" />
				    	</div>
			    
		    <%}%> 
		<%}else{ //파라미터가없을경우 
			response.sendRedirect("franInfolist.jsp");
		} 
	}//else session id가 존재할때 %>
			</div>
			</div> 
			<jsp:include page="include/footer.jsp"/> 
</body>
</html>