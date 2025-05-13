<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>

<%!
	int nm = 10;
	int sum(int a, int b) {
		return a + b;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		int p = 10;
		out.println(sum(1,2) + p + nm);
	%>
	<br>
	p의 값은 <%=p %>이다<br>
	p의 값은 <% out.println(p); %>이다<br>

</body>
</html>