<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="type" %>

<c:if test="${mid != null }">

<c:choose>
	<c:when test="${type=='msg'}">
		<input type="text" name="msg">
			<!-- 만약에, 로그인을 하지않았다면, 로그인후에 이용하세요! -->
	</c:when>
	<c:when test="${type=='rmsg'}">
		<input type="text" name="rmsg">
	</c:when>
</c:choose>
</c:if>
<c:if test="${mid == null }">
	<input type = "text" disabled value="등록하려면 로그인하세요!">
</c:if>

