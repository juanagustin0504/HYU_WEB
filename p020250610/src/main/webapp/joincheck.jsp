<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%

String getid = request.getParameter("id");
String getpass = request.getParameter("pass");
String getname = request.getParameter("name");


// DB연결
Class.forName("com.mysql.jdbc.Driver");
String address="jdbc:mysql://localhost:3306/airport?serverTimeZone=UTC";
String id="root";
String pass="abcde12345";

Connection con = DriverManager.getConnection(address, id, pass);


Statement dbst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ResultSet rs = dbst.executeQuery("select * from user");
rs.last();
int lastnumber = rs.getInt(1);

Statement insert = con.createStatement();
insert.executeUpdate("insert into user values(" + (lastnumber+1) + ", '" + getid + "', sha1('" + getpass + "'), '" + getname + "', 0)");

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

가입 완료 되었습니다.<br>
<a href="main.jsp">메인페이지가기</a>
<%
out.print(getid);
out.print(getpass);
out.print(getname);

%>

</body>
</html>