<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String address = "jdbc:mysql://localhost:3306/studentdb?serverTimeZone=UTC";
	String id = "root";
	String pass = "abcde12345";
	
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
		// request는 한페이지에서 넘어온 데이터를 받기 위해서 쓰는 class
		// .setCharacterEncoding 은 () 안에 코드로 인코딩하여 text를 읽겠다
		request.setCharacterEncoding("UTF-8");
	
		// 값을 가져오기. .getParameter를 통하여 값을 문자열 형식으로 가져온다.
		String name1 = request.getParameter("name");
		String id1 = request.getParameter("id");
		String pass1 = request.getParameter("pass");
		String[] fm1 = request.getParameterValues("fm");
		
		out.println("아.. 너의 이름은 " + name1 + "이구나?!<br>");
		out.println("아.. 너의 id는 " + id1 + "이구나?!<br>");
		out.println("아.. 너의 pass는 " + pass1 + "이구나?!<br>");
		
		out.println("<table border=1>");
			out.println("<tr>");
				out.println("<td>이름</td>");
				out.println("<td>" + name1 + "</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td>");
					out.println("id");
				out.println("</td>");
				out.println("<td>");
					out.println(id1);
				out.println("</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td>");
					out.println("pass");
				out.println("</td>");
				out.println("<td>");
				out.println(pass1);
				out.println("</td>");
			out.println("</tr>");
			
			out.println("<tr>");
				out.println("<td>");
					out.println("성별");
				out.println("</td>");
				out.println("<td>");
					out.println(fm1[0] + " " + fm1[1]);
				out.println("</td>");
			out.println("</tr>");
		out.println("</table>");
		
		// SQL로 record 넣기.
		String command = "insert into member values(2, '" + name1 + "', '" + id1 + "', '" + pass1 + "')";
		
		// SQL 명령어 실행하기
		Statement st = con.createStatement();
		st.executeUpdate(command);
		
		
		
		
		
		
		
	%>
	
	
	
</body>
</html>