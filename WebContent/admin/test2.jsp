<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<body>
	<div class="cont cont2">
	
		<h1>제목</h1>
		<textarea class="article" cols="200" rows="30"></textarea>
		
		<h1>댓글</h1>
		<form action="">
			<textarea class="article" cols="200" rows="5"></textarea><br>
			<input type="button" value="작성">
		</form>
		
		<div style="text-indent:20px;">
			<p>"작성자명" 1번 댓글입니다. test</p>
			<a class="rereBtn" href="#">댓글달기</a>
			<textarea class="rere" cols="200" rows="1"></textarea>
		</div>
		<script>
			$(".rere").hide();
			$(".rereBtn").click(function(){
				$("this").next(".rere").show();
			});
		</script>
	</div>
</body>
</html>