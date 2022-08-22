<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="bid" %><%-- EL식 안에서 쓸 변수명을 새로 지정 --%>
<%@ attribute name="bmid" %>

<c:if test="${mid == bmid }">
	<form action="ctrlB.jsp?action=deleteB" method="post">
		<input type="hidden" name="bid" value="${bid }"> <input
			type="submit" value="삭제">
	</form>
</c:if>