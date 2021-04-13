<%@page import="helimy.project.model.ImageFranchiseDTO"%>
<%@page import="helimy.project.model.ImageFranchiseDAO"%>
<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.FranchiseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>

<%
	request.setCharacterEncoding("UTF-8");
%>
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
		<div class="cont cont3 width1200">
<%		if(request.getParameter("sel") == null || request.getParameter("search")==null){
			response.sendRedirect("memberMain.jsp");
		}else{	//넘어온 정보있을때
			//검색 정보 받아오기
			String sel = request.getParameter("sel");
			String search = request.getParameter("search");
			
			
			//검색내용 가지고 search해서 가져오기
			FranchiseDAO frandao = FranchiseDAO.getInstance();
			FranchiseDTO frandto = new FranchiseDTO();
			List list = frandao.searchFranInfo(sel,search); 
			
			
			if(list != null){	//받아온 검색정보가 있다면	%>	
				<p class="tit1 tac">"<%=search%>" 근처의 헬스장 목록입니다.</p>
				<ul class="searchlist">
<%				for(int i = 0 ; i < list.size(); i++){	
					//받아온 객체 하나씩 출력시키기
					frandto = (FranchiseDTO)list.get(i);	
					ImageFranchiseDAO imgdao = ImageFranchiseDAO.getInstance(); // img에 연결
					ImageFranchiseDTO imgdto = imgdao.getMainImg(frandto.getFrancode());
					%>
						<li>
							<a href="franInfolist.jsp?francode=<%=frandto.getFrancode()%>"></a>
							<div class="thumb"><img src="/helimy/imgupload/<%=imgdto.getImage()%>.jpg" /></div>
							<div class="info">
								<p class="name"><%=frandto.getShopname()%></p>
								<p class="add"><%=frandto.getShopaddress()%></p>
								<p class="tel">TEL. <%=frandto.getShopphone()%></p>
							</div>
						</li>				
<%				}%>
				</ul>
<%			}else{				//받아온 검색정보가 없다면	%>	
				<p class="tit1 tac">검색 결과가 없습니다.</p>
				<button class="btn_e long" onclick="window.location='memberMain.jsp'">다른 검색하기</button>			
<%			}
		}
%>		
		</div>	
		<jsp:include page="include/footer.jsp"/>
<%	} %>			
</body>
</html>