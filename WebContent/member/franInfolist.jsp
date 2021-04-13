<%@page import="helimy.project.model.ReviewDAO"%>
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

<% request.setCharacterEncoding("UTF-8"); %>
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
		
<% 	}else{	//로그인상태	%>
		<jsp:include page="include/top_login.jsp"/>
<%
	
		String id = (String)session.getAttribute("memId");	//임의설정 세션으로 변경
		if(request.getParameter("francode") == null){
			response.sendRedirect("memberMain.jsp");
		}else{
			String francode = request.getParameter("francode");	//임의설정 넘어온파라미터로 변경
			
			//DB매장 정보 가져오기
			FranchiseDAO frandao = FranchiseDAO.getInstance(); 			// 매장정보DAO 연결
			// 아이디, 매장코드명 주고 매장 데이터 가져오기
			FranchiseDTO frandto = frandao.franchiseInfo(francode); 	// 매장정보가져오기
			ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance(); // img에 연결
			ImageFranchiseDTO imgdto = imgdao.getMainImg(Integer.parseInt(francode));
			//리뷰테이블에서 총 평점 가져오기
			ReviewDAO reviewdao = ReviewDAO.getInstance();
			double totalPoint = reviewdao.getPoint(francode); //평점 총점가져오기
			String tp = String.format("%.1f", totalPoint);
			
			String fransisul = request.getParameter("fransisul");
			String franimg = request.getParameter("franimg");
			String franreview = request.getParameter("franreview");
%>
		<div class="cont cont3 width1200">
		
			<ul class="frandetail">
				<li>
			        <div class="clearfix" style="max-width:600px; max-height:600px;">
						<ul id="image-gallery" class="gallery list-unstyled cS-hidden">
							<li data-thumb="/helimy/imgupload/<%=imgdto.getImage()%>.jpg"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="600px"/></li>
							<li data-thumb="/helimy/imgupload/<%=imgdto.getImage()%>.jpg"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="600px"/></li>
							<li data-thumb="/helimy/imgupload/<%=imgdto.getImage()%>.jpg"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="600px"/></li>
							<li data-thumb="/helimy/imgupload/<%=imgdto.getImage()%>.jpg"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="600px"/></li>
							<li data-thumb="/helimy/imgupload/<%=imgdto.getImage()%>.jpg"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="600px"/></li>
							<li data-thumb="/helimy/imgupload/<%=imgdto.getImage()%>.jpg"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" width="600px"/></li>
						</ul>
					</div>
				</li>
				<script>
				$('#image-gallery').lightSlider({
					gallery:true,
					item:1,
					thumbItem:6,
					slideMargin: 0,
					speed:300,
					pause:3000,
					auto:true,
					loop:true,
					onSliderLoad: function() {
						$('#image-gallery').removeClass('cS-hidden');
					}
				});
				</script>
				<li class="right">
					<p class="name"><%=frandto.getShopname()%><span class="btn_fav" ></span></p>
					<p class="tit5">평점</p>
					<p class="txt1"><%=tp%></p>
					<p class="line"></p>
					<p class="tit5">주소</p>
					<p class="txt1"><%=frandto.getShopaddress()%></p>
					<p class="line"></p>
					<p class="tit5">TEL.</p>
					<p class="txt1"><%=frandto.getShopphone() %></p>
					<p class="line"></p>
					<p class="tit5">영업시간</p>
					<p class="txt1">평일 : <%=frandto.getWeekday()%></p>
					<p class="txt1">토 : <%=frandto.getSat() %></p>
					<p class="txt1">일 : <%=frandto.getSun() %></p>
					<p class="line"></p>
					<input type="button" class="btn_b" onclick="window.location='paymentFormList.jsp?id=<%=id%>&francode=<%=francode%>'" value="구매하기">
		        	<input type="button" class="btn_a" onclick="window.location='bookingForm.jsp?id=<%=id%>&francode=<%=francode%>'" value="예약하기">
				</li>
			</ul>
			
		</div>
		
		<div class="cont cont4">
			<div class="ddi"></div>
			<ul class="tabBtn width1200">
				<li>시설정보</li>
				<li>매장이미지</li>
				<li>리뷰</li>
			</ul>
			<ul class="tabCont width1200">
				<li>
    				<jsp:include page="franInfoTab.jsp">
    					<jsp:param name="id" value="<%=id%>"/>
    					<jsp:param name="francode" value="<%=francode%>"/>
    				</jsp:include>
				</li>
				<li>
    				<jsp:include page="franImgTab.jsp">
    					<jsp:param name="id" value="<%=id%>"/>
    					<jsp:param name="francode" value="<%=francode%>"/>
    				</jsp:include>
				</li>
				<li>
    				<jsp:include page="franReviewTab.jsp">
    					<jsp:param name="id" value="<%=id%>"/>
    					<jsp:param name="francode" value="<%=francode%>"/>
    				</jsp:include>
				</li>
			</ul>
			<script>
				$(".tabBtn").children("li").eq(0).addClass("on");
				$(".tabCont").children("li").eq(0).show();
				$(".tabBtn").children("li").eq(0).click(function(){
					$(".tabBtn").children("li").removeClass("on");
					$(this).addClass("on");
					$(".tabCont").children("li").hide();
					$(".tabCont").children("li").eq(0).show();
				});
				$(".tabBtn").children("li").eq(1).click(function(){
					$(".tabBtn").children("li").removeClass("on");
					$(this).addClass("on");
					$(".tabCont").children("li").hide();
					$(".tabCont").children("li").eq(1).show();
				});
				$(".tabBtn").children("li").eq(2).click(function(){
					$(".tabBtn").children("li").removeClass("on");
					$(this).addClass("on");
					$(".tabCont").children("li").hide();
					$(".tabCont").children("li").eq(2).show();
				});
			</script>
		</div>
		
	    <jsp:include page="include/footer.jsp"/>
<%		}						 %>	    
<%	}	//else session id가 존재할때 %>	    
	    
</body>
</html> 