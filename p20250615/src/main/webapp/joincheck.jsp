<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"  %>

<%
	// join.jsp로부터 넘어온 데이터 가져오기
	String getid = request.getParameter("id");
	String getpass = request.getParameter("pass");
	String getname = request.getParameter("name");

	// DB (acompany) 연결하기
	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/airport?serverTimeZone=UTC";
	String id = "root";
	String pass = "abcde12345";
	
	//  DB연결
	Connection conn = DriverManager.getConnection(url, id, pass);

	// select문
	Statement dbst = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	// SQL 명령어 실행, select문의 결과는 resultset 클래스의 객체에 저장됨.
	// order by no asc는 오름차순으로 정렬함. record 추가시 행이 순서대로 저장되지 않기 때문에 출력시 꼭 no기준 오름차순으로 정렬해야 함.
	ResultSet rs = dbst.executeQuery("select * from user order by no asc"); 
	rs.last();  // 마지막줄
	int lastnumber = rs.getInt(1);
	
	
	// 레코드 입력
	Statement insert = conn.createStatement();
	String runmessage = "insert into user values("+(lastnumber+1)+", '" +getid+ "', sha1('"+ getpass +"'), ' "+ getname +" ',  0)";
	insert.executeUpdate( runmessage );
	
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


</body>
</html>












