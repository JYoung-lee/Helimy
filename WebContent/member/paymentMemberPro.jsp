<%@page import="helimy.project.model.PaymentDAO"%>
<%@page import="helimy.project.model.ProductDTO"%>
<%@page import="helimy.project.model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
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
			//paymentMemberForm에서 넘어온 정보 DB에 넣어주기
			//상품테이블에 상품명 던져주고 가격이랑 가맹코드 가져오기
			String productname = request.getParameter("month");	//넘어온 레디오값 변수에 담기
			
			ProductDAO prodao = ProductDAO.getInstance();
			ProductDTO prodto = prodao.getProduct(productname,francode); 		//해당 매장 상품코드가져오기 
			Integer productcode = prodto.getProductcode();						//해당상품코드 가져오기
			//결제 테이블에 상품코드랑 회원아이디 던져주고 디비에 저장하기
			PaymentDAO paydao = PaymentDAO.getInstance();
			paydao.insertPayment(productcode,id);			//상품코드,아이디
	
%>
		<jsp:include page="include/top_login.jsp"/>
		<div class="cont cont3 width1200">
			<p class="tit1 tac">결제완료! 바로 예약하시겠어요?</p>
			<div class="tableWrap">
				<table style="width:300px; margin:80px auto;">
			 		<tr>
			            <th>상품금액</th>
			        </tr>
			        <tr>
			            <td><%=prodto.getPrice() %> 원</td>
					</tr>		        
				</table>
	    	</div>
			<div class="btnWrap">
				<button class="btn_a" type="button" onclick="window.location='memberMain.jsp?francode=<%=francode%>'">메인으로</button>
				<button class="btn_b" type="button" onclick="window.location='bookingForm.jsp?francode=<%=francode%>'">예약하기</button>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"/>
		<%}else{ //파라미터가없을경우 
			response.sendRedirect("franInfolist.jsp");
		} 
	}//else session id가 존재할때 %>	
</body>
</html>