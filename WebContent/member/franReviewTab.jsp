<%@page import="helimy.project.model.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="helimy.project.model.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
		//DB에서 해당매장 리뷰 있는만큼 뿌려주기
		String id = (String)session.getAttribute("memId");					// session id
		
		if(request.getParameter("francode") != null){		
			String francode = request.getParameter("francode");		// 가맹코드
			int pageSize = 3;										// 페이지에 보여줄 글 수 3개
			//게시글 페이지 정보담기
			String pageNum = request.getParameter("pageNum");		// 페이지 넘길떄 넘어오는 파라미터 받기
			if(pageNum == null){									
				pageNum = "1";
			}
			//현재페이지에 보여줄 게시글의 시작과 끝 등등 정보 세팅
			int currPage = Integer.parseInt(pageNum); 		// 현재 게시판 페이지 숫자로 변환	 1
			int startRow = (currPage - 1) * pageSize + 1; 	// 페이지 번호 시작  (1 - 1) = 0 * 3 + 1 = 1 
			int endRow = currPage * pageSize;				// 페이지 끝번호 1 * 3 = 3
			int count = 0;									// 전체 글수 변수선언 0;
			List reviewlist = null;
			//1. 게시글 있는지 확인하기
			ReviewDAO reviewdao = ReviewDAO.getInstance();	// 리뷰 DAO 연결
			count = reviewdao.getReviewCount(francode);		// 가맹코드 던저주며 해당하는 가맹점 글의 전체 수
			
			if(count > 0){									// 글이 있다면 정보 받아오기 
				reviewlist = reviewdao.getReview(francode,startRow,endRow); // 가맹코드 주고 가맹코드에 해당하는 후기들 가져오기
			}	
%>
			<div class="cont cont2">
			<div class="tableWrap">
			<%if(count == 0){ %>		<%--  글이 없을때 --%>
				<p class="tit2">등록된 리뷰가 없습니다.</p>
			<%}else{ %>					<%--  글이 있을때 --%>
				<table>
					<tr>
						<th>아이디</th>
						<th>내용</th>
						<th>평점</th>
					</tr>			
					<%for(int i = 0; i < reviewlist.size(); i++){
					ReviewDTO reviewdto = (ReviewDTO)reviewlist.get(i); // 전체글 하나씩 List에 담아 가져와서 다시 담아진 DTO의 값을 최신순으로 가져오기 	
					%>					
					<tr>
						<td><%=reviewdto.getId() %></td>				<%-- 작성자 --%>
						<td><%=reviewdto.getContent()%></td>				<%-- 작성자 --%>
						<td><%=reviewdto.getPoint() %></td>		<%-- 점수 --%>
					</tr>
					<%}//for %>
				</table>
				<br />
				<div align="center">
					
				<%
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); // 총페이지가 나오는지 계산			8 / 3 + (8 % 3 == 0 ? 0 : 1) 2 + 1 = 3
					int pageBlock = 5;													// 보여줄 페이지 번호의 개수  
					int startPage = (int)((currPage - 1)/ pageBlock) * pageBlock +1;	// 현재위치한 페이지에서 페이지뷰어 첫번째 숫자가 무엇인지 찾기 	( (1-1)/5 )* 5 + 1 = 1 
					int endPage = startPage + pageBlock - 1; 							// 현재위치한 페이지에서 페이지뷰어 마지막 숫자가 무엇인지 찾기 	1 + 5-1 = 5
					if(endPage > pageCount) endPage = pageCount;						// 마지막페이지가 총페이지보다 많으면 총페이지가 마지막페이지가 된다. 5 > 3 = endpage = 3
					
					if(startPage > pageBlock){%>
						<a href="franInfolist.jsp?pageNum=<%=startPage - pageBlock %>&franreview=1" > &lt; </a>
					<%}%>
					<%
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="franInfolist.jsp?pageNum=<%=i%>&franreview=1"> &nbsp;<%=i%> </a>
					<%} %>
					<% if(endPage < pageCount){%>
						<a href="franInfolist.jsp?pageNum=<%=startPage + pageBlock%>&franreview=1"> &gt; </a>
					<%} %>
				</div>
				
			</div>
			</div>		
			<%}//else %>
		<%}else{ //파라미터가없을경우 
			response.sendRedirect("franInfolist.jsp");
		} 
	}//else session id가 존재할때 %>
</body>
</html>