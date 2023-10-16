<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate(); // destory current client's session info
%>
<script>
	location.href = 'index.jsp';
</script>