<%@page import="helimy.project.model.FranchiseDTO"%>
<%@page import="helimy.project.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="include/header.jsp"/>
<html>
<body>
	<div class="cont cont2">
		<!-- 이부분에 상단 내용(매장이미지슬라이드, 우측정보) 추가 -->
		<ul class="tabBtn">
			<li class="on">시설정보</li>
			<li>매장정보</li>
			<li>이용후기</li>
		</ul>
		<ul class="tabCont">
			<li class="on">시설정보인클루드</li>
			<li>매장정보인클루드</li>
			<li>이용후기인클루드</li>
		</ul>
		<script>
			$(".tabBtn").children("li").eq(0).click(function(){
				$(".tabBtn").children("li").removeClass("on");
				$(".tabCont").children("li").removeClass("on");
				$(".tabBtn").children("li").eq(0).addClass("on");
				$(".tabCont").children("li").eq(0).addClass("on");
			});
			$(".tabBtn").children("li").eq(1).click(function(){
				$(".tabBtn").children("li").removeClass("on");
				$(".tabCont").children("li").removeClass("on");
				$(".tabBtn").children("li").eq(1).addClass("on");
				$(".tabCont").children("li").eq(1).addClass("on");
			});
			$(".tabBtn").children("li").eq(2).click(function(){
				$(".tabBtn").children("li").removeClass("on");
				$(".tabCont").children("li").removeClass("on");
				$(".tabBtn").children("li").eq(2).addClass("on");
				$(".tabCont").children("li").eq(2).addClass("on");
			});
		</script>
	</div>	
</body>
</html>