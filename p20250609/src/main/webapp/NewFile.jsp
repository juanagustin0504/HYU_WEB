<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%

// DB연결
Class.forName("com.mysql.jdbc.Driver");
String address="jdbc:mysql://localhost:3306/acompany?serverTimeZone=UTC";
String id="root";
String pass="abcde12345";

Connection con = DriverManager.getConnection(address, id, pass);


%>
<!DOCTYPE html>


<%


	// 쿠키 생성
	Cookie makecookie = new Cookie("name", "moon");
	response.addCookie(makecookie); // Client PC에 cookie를 저장한다.
	
	
	
	
	
	String getid = request.getParameter("id");
	String getpass = request.getParameter("pass");
	String getname = request.getParameter("name");
	
	/* String getid = "asdf1";
	String getpass = "asdf1";
	String getname = "asdf1"; */
	
	Statement dbst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = dbst.executeQuery("select * from member");
	rs.last();
	int lastnumber = rs.getInt(1);
	
	Statement insert = con.createStatement();
	insert.executeUpdate("insert into member values(" + (lastnumber+1) + ", '" + getid + "', sha1('" + getpass + "'), '" + getname + "')");
	//String runmessage = "insert into member values(3, '" + getid + "', sha1('" + getpass + "'), '" + getname + "')";
	//out.print(runmessage);
	
	

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	out.print("가입되었습니다.<br>");

%>

</body>
</html>