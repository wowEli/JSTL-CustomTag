<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${mid == null }">
		<li><a href="signup.jsp" target="_blank">회원가입</a></li>
		<form action="ctrlM.jsp?action=login" method="post">
			<input type="text" name="mid"> <input type="password"
				name="mpw"> <input type="submit" value="로그인">
		</form>
	</c:when>
	<c:otherwise>
		<a href="ctrlM.jsp?action=logout">로그아웃</a>
	</c:otherwise>
</c:choose>