<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%

// DB연결
Class.forName("com.mysql.jdbc.Driver");
String address="jdbc:mysql://localhost:3306/baseball?serverTimeZone=UTC";
String id="root";
String pass="abcde12345";

Connection con = DriverManager.getConnection(address, id, pass);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	String name = request.getParameter("name");
	String include = request.getParameter("include");
	String position = request.getParameter("position");
	String rate = request.getParameter("rate");

	String command = "insert into person values(" + no + ", '" + name + "', '" + include + "', '" + position + "', " + rate
			+ ")";

	Statement st = con.createStatement();
	st.executeUpdate(command);
	%>








</body>
</html>