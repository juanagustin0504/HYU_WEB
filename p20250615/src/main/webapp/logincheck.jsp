<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"  %>
    
<%
	// main.jsp로부터 넘어온 데이터 가져오기
	String getid = request.getParameter("id");
	String getpass = request.getParameter("pass");

	// DB (acompany) 연결하기
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/airport?serverTimeZone=UTC";
	String id = "root";
	String pass = "abcde12345";
	
	//  DB연결
	Connection conn = DriverManager.getConnection(url, id, pass);

	// select문
	Statement dbst = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = dbst.executeQuery("select count(*) from user where id='"+getid+"' and pass=sha1('"+getpass+"')"); // SQL 명령어 실행, select문의 결과는 resultset 클래스의 객체에 저장됨.
	rs.next();  // 마지막줄
	int login = rs.getInt(1);   // login이 1이면 로그인 성공, login이 0이면 실패
	
	
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
		// 로그인 성공하였을 경우 쿠키 생성.
		Cookie makec = new Cookie("login", "succ");
		response.addCookie(makec);
	} else {
		out.print("회원 정보가 없습니다.");
	}
%>

</body>
</html>





