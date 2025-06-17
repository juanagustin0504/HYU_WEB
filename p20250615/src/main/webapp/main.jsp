<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"  %>


<%
// 너의 pc에 쿠키가 있는지 없는지 check
// 모든 쿠키를 가져와서 array cookies에 저장함.
Cookie[] cookies = request.getCookies();

boolean access_ok = false;
String yourname="";

for(int i=0; i<cookies.length; i++) {
	if(cookies[i].getName().equals("login")) {
		access_ok = true;
		yourname = cookies[i].getValue();
		break;
	}
}


%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% if(access_ok==false) { %>
<form action="logincheck.jsp" method=POST>
	아이디:<input type="text" name="id"><br>
	패스워드:<input type="text" name="pass"><br>
	<input type="submit" value="로그인"><br>
</form>
<a href="join.jsp">회원가입</a>
<% } %>

<% if(access_ok) { 
	out.print(yourname+"님 반갑습니다.<br>");
	out.print("<a href='logout.jsp'>로그아웃</a>");
%>
	<p>
	항공권예약<br>
	<form action="searching.jsp" method="post">
		목적지: 
		<select name="departure">
			<option value="atlanta">ATLANTA/USA</option>
			<option value="osaka">OSAKA/JAPAN</option>
			<option value="MADRID">MADRID/SPAIN</option>
		</select><br>
		시간:
		<select name="ampm">
			<option value="am">오전</option>
			<option value="pm">오후</option>
		</select>
		<select name="hour">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
		</select> 
		<br>
		<input type="submit" value="예약하기">
	</form>
	
<%
} 
%>
 

</body>
</html>








