<%@page import="java.util.List"%>
<%@page import="helimy.project.model.MemberDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<%
   AdminDAO dao = AdminDAO.getInstance();
   int francode = (Integer)session.getAttribute("francode");
   List memList = null;
   
   //페이지 정보 
   int pageSize = 5;
   String pageNum = request.getParameter("pageNum");
   if(pageNum==null){
      pageNum = "1";
   }
   
   //정보세팅
   int currPage = Integer.parseInt(pageNum);
   int startRow = (currPage-1)*pageSize+1;
   int endRow = currPage*pageSize;
   int count = 0;
   
   //회원 유무체크
   count = dao.getMemberCount(francode);
%>
<html>
<body>
   <jsp:include page="include/nav.jsp"/>
   <div class="cont">
      <p class="tit1">회원등록</p>
      <div class="tableWrap tableWrap2">         
         <div id="control">
            <div id="btn_add" class="btn">등록</div>
            <div id="btn_mod" class="btn">수정</div>
            <div id="btn_del" class="btn">삭제</div>
         </div>         
         <form id="signup">
         <table id="tableAdd">
            <tr>
               <th width="10%">이름</th>
               <th width="7.5%">성별</th>
               <th width="7.5%">생년월일</th>
               <th>회원권</th>
               <th width="15%">시작일/종료일</th>
               <th width="20%">주소</th>
               <th width="15%">전화번호</th>
               <th>상태</th>
               <th width="5%">옵션</th>
               <th width="5%">비고</th>
            </tr>
            <tr>
               <td><input type="text" name="name" /></td>
               <td><input type="text" name="gender" /></td>
               <td><input type="text" name="birth" /></td>
               <td>준비중</td>
               <td>준비중</td>
               <td><input type="text" name="address" /></td>
               <td><input type="text" name="cellnum" /></td>
               <td>off</td>
               <td><input type="text" value="x" readonly/></td>
               <td><input type="text" value="x" readonly/></td>
            </tr>
         </table>
         <input type="hidden" name="pw" value="1234" />
         <input type="hidden" name="authority" value="1" />
         <input type="hidden" name="francode" value="<%=francode %>" />
         <input type="hidden" name="onoff" value="off" />
         </form>
         <script type="text/javascript">
            $('#btn_add').click(function(){
               $.ajax({
                     type: 'POST',    
                     url: "signupPro.jsp",   //전송할 url
                     data: $('#signup').serialize(),    //form id를 입력하자
                     success: function(response) {   //성공했을시의 동작.                         
                        /*location.href="signupPro.jsp";*/
                        $('.tableWrap').load(window.location.href+'.tableWrap');
                        alert("등록완료");
                     },
                    error: function() {    //오류났을때 동작
                        alert("에러났음");
                    }
                 });               
            });
         </script>
      </div>
      
      <%if(count>0){ 
         memList = dao.getMember(francode,startRow,endRow);
      %>
      <p class="tit1">회원목록</p>
      <div class="tableWrap">
      <table>
         <tr>
            <th width="10%">이름</th>
            <th width="7.5%">성별</th>
            <th width="7.5%">생년월일</th>
            <th>회원권</th>
            <th width="15%">시작일/종료일</th>
            <th width="20%">주소</th>
            <th width="15%">전화번호</th>
            <th>상태</th>
            <th width="5%">옵션</th>
            <th width="5%">비고</th>
         </tr>
         <%
         for(int i = 0; i < memList.size(); i++){
            MemberDTO mem = (MemberDTO)memList.get(i);
         %>
         <tr>
            <td><%=mem.getName() %></td>
            <td><%=mem.getGender() %></td>
            <td><%=mem.getBirth() %></td>
            <td>준비중</td>
            <td>준비중</td>
            <td><%=mem.getAddress() %></td>
            <td><%=mem.getCellnum() %></td>
            <td><%=mem.getOnoff() %></td>
            <td>x</td>
            <td>x</td>
         </tr>
         <%} %>         
       </table>
       </div>
       <%}else{ %>
          <p>회원이 없습니다.</p>
       <%} %>
      <%
         int pageCount = (count/pageSize)+(count%pageSize==0 ? 0 : 1);
         int pageBlock = 5;
         int startPage = (int)(((currPage-1)/pageBlock)*pageBlock+1);
         int endPage = startPage+pageBlock-1;
         if(endPage>pageCount){
               endPage = pageCount;
        }%>
         <div class="pageNums">
         <%if(startPage>pageBlock){%>
               <a href="member.jsp?pageNum=<%=startPage-pageBlock%>"> &lt; </a>
         <%}
         for(int i=startPage; i<=endPage; i++){%>
            <a href="member.jsp?pageNum=<%=i%>"> &nbsp; <%=i%> &nbsp;</a>
         <%}
	      if(endPage<pageCount){%>
	              <a href="member.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
	      <%}%>
	      </div>      
   </div>
</body>
</html>