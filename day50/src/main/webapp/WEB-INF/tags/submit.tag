<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="type" %>


<c:if test="${mid != null }">
	<c:choose>
		<c:when test="${type== 'letter' }">
			<input type="submit" value="글 등록">
		</c:when>
		<c:when test="${type== 'reply' }">
			<input type="submit" value="댓글 등록">
		</c:when>
	</c:choose>
	
</c:if>