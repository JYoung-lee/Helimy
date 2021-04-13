<%@page import="java.text.SimpleDateFormat"%>
<%@page import="helimy.project.model.BookingDAO"%>
<%@page import="helimy.project.model.BookingDTO"%>
<%@page import="helimy.project.model.ImageFranchiseDTO"%>
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
<body>
<jsp:include page="include/nav.jsp"/>
<%request.setCharacterEncoding("UTF-8");%>
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
				//해당 아이디의 매장 데이터 뿌려주기
				FranchiseDAO frandao = FranchiseDAO.getInstance();
				FranchiseDTO frandto = frandao.franchiseInfo(francode);
				BookingDAO bookingdao = BookingDAO.getInstance();
				BookingDTO bookingdto = bookingdao.getbookingInfo(francode,id);
			  	Integer totaltime = bookingdto.getBookingend() - bookingdto.getBookingstart(); //총 예약시간
				//해당 매장의 이미지 뿌려주기
				ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance();
				ImageFranchiseDTO imgdto = imgdao.getMainImg(Integer.parseInt(francode));
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
%>			
			<div class="cont">
			<div class="tableWrap">
				<table>
					<tr>
					  	<td rowspan="3"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="100" height="100"/></td>
					<th>매장명</th>
						<td><%=frandto.getShopname()%></td>
					</tr>
					<tr>
					  	<td>기존 예약 날짜 <%=sdf.format(bookingdto.getReg()) %></td>
						<td><%=bookingdto.getBookingstart() %> 시</td>
						<td>~</td>
						<td><%=bookingdto.getBookingend() %> 시</td>
					</tr>
					<tr>
					    <td colspan="3">총 <%=totaltime%> 시간 예약되어있습니다</td>
					</tr>
				</table>
				
				<%if(frandto.getMembernum() != 0 || frandto.getNonmemnum() != 0){ %>
				<h3> 변경할시간을 선택하세요 </h3>
			    <form action="modifyBookingPro.jsp" method="post" onsubmit="return inputCheck()"> 
			    	<input type="hidden" name="id" value="<%=id%>"/>
			    	<input type="hidden" name="francode" value="<%=francode%>"/>
			        <table>
			            <tr>
			            	<td>06:00<input type="checkbox" class="time" name ="time0" value="6"/></td>
			                <td>07:00<input type="checkbox" class="time" name ="time1" value="7"/></td>
			                <td>08:00<input type="checkbox" class="time" name ="time2" value="8"/></td>
			                <td>09:00<input type="checkbox" class="time" name ="time3" value="9"/></td>
			                <td>10:00<input type="checkbox" class="time" name ="time4" value="10"/></td>
			            </tr>
			            <tr>
			                <td>11:00<input type="checkbox" class="time" name ="time5" value="11"/></td>
			                <td>12:00<input type="checkbox" class="time" name ="time6" value="12"/></td>
			                <td>13:00<input type="checkbox" class="time" name ="time7" value="13"/></td>
			                <td>14:00<input type="checkbox" class="time" name ="time8" value="14"/></td>
			                <td>15:00<input type="checkbox" class="time" name ="time9" value="15"/></td>
			            </tr>
			            <tr>
			                <td>16:00<input type="checkbox" class="time" name ="time10" value="16"/></td>
			                <td>17:00<input type="checkbox" class="time" name ="time11" value="17"/></td>
			                <td>18:00<input type="checkbox" class="time" name ="time12" value="18"/></td>
			                <td>19:00<input type="checkbox" class="time" name ="time13" value="19"/></td>
			                <td>20:00<input type="checkbox" class="time" name ="time14" value="20"/></td>
			            </tr>
			            <tr>
			                <td>21:00<input type="checkbox" class="time" name ="time15" value="21"/></td>
			                <td>22:00<input type="checkbox" class="time" name ="time16" value="22"/></td>
			                <td>23:00<input type="checkbox" class="time" name ="time17" value="23"/></td>
			                <td>24:00<input type="checkbox" class="time" name ="time18" value="24"/></td>
			            </tr>
			            <tr> 
			               <td>
			                   <input type="submit" value="변경하기" />
			               </td>
			               <td>
			                 <input type="button" onclick="window.location='franInfolist.jsp'" value="취소" /> <%--마이페이지로 경로변경--%>
			               </td>
			            </tr>
			        </table>
			    </form> 
			    <%} %>  
			</div>
			</div>
		<%}else{ //파라미터가없을경우 
			response.sendRedirect("bookingList.jsp");
		} 
	}//else session id가 존재할때 %>
</body>
</html>