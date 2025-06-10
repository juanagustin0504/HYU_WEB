<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// main.jsp로부터 넘어온 데이터 가져오기
	String getid = request.getParameter("id");
	String getpass = request.getParameter("pass");
	
	
	// DB연결
	Class.forName("com.mysql.jdbc.Driver");
	String address="jdbc:mysql://localhost:3306/airport?serverTimeZone=UTC";
	String id="root";
	String pass="abcde12345";
	
	Connection con = DriverManager.getConnection(address, id, pass);
	
	
	Statement dbst = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = dbst.executeQuery("select count(*) from user where id='" + getid + "' and pass=sha1('" + getpass + "')");
	rs.next();
	int login = rs.getInt(1); // login이 1이면 로그인 성공, login이 0이면 로그인 실패

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	
	
		if(login == 1) {
			out.print("로그인 성공");
			Cookie makec = new Cookie("login", "succ");
			response.addCookie(makec);
			
		} else {
			out.print("회원 정보가 없습니다.");
		}
	
	
	
	%>


</body>
</html>