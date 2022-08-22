<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jang" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
	
	<div id="header">
		<h1>작은 티모</h1>
		
		<div class="gnb">
			<ul>
				<li><a href="ctrlB.jsp?action=main">메인으로</a></li>
				<li>
					<jang:login/>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="wrapper">
	
		<div id="content">
			<h2>글 등록하기</h2>
			<form action="ctrlB.jsp?action=insertB" method="post">
				<input type="hidden" name="mid" value="${mid}">
				<jang:write type="msg"/>
				<jang:submit type="letter"/>
				<!-- 만약에, 로그인을 하지않았다면, 로그인후에 이용하세요! -->
			</form> <!-- 커스텀태그 -->
		</div>
		
		<div id="main">
			<h2>글 목록보기</h2>
			<c:forEach var="v" items="${datas}">
				<c:set var="b" value="${v.boardVO}" />
				<h3>[${b.mid}] ${b.msg} [ 좋아요 ${b.favcnt} | 댓글 ${b.rcnt} ]</h3>
				<jang:delete bmid="${b.mid }" bid="${b.bid }"/>				
				<div class="reply">
					<ul>
						<c:forEach var="r" items="${v.rList}">
							<li>[${r.mid}] ${r.rmsg}</li>
						</c:forEach>
					</ul>
				</div>
			
			<div class="reply">
				<form action="ctrlB.jsp?action=insertR" method="post">
					<input type="hidden" name="mid" value="${mid}">
					<input type="hidden" name="bid" value="${b.bid}">
					<jang:write type="rmsg"/>
					<jang:submit type="reply"/>
				</form>
			</div>
			</c:forEach>
		</div>
		<a href="ctrlB.jsp?action=main&cnt=${cnt+2}">더보기&gt;&gt;</a>
		
	</div>
		
	<div id="footer">
		회사소개 | 이용약관 | <strong>개인정보처리방침</strong> | 보호정책 | 고객센터 <strong>ⓒ Corp.</strong>
	</div>

</body>
</html>