<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 너의 pc에 쿠키가 있는지 없는지 check 해볼게요
	// 모든 쿠키를 가져와서 array cookies에 저장함.
	Cookie[] cookies = request.getCookies();

	boolean access_ok = false;
	String yourname = "";
	for(int i = 0; i < cookies.length; i++) {
		//out.print(cookies[i].getName() + "<br>");
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

<% if(access_ok == false) { %>

<form action="logincheck.jsp" method=POST>

	아이디:<input type="text" name="id"><br>
	패스워드:<input type="text" name="pass"><br>
	<input type="submit" value="로그인">
	
</form>

<a href="join.jsp">회원가입</a>
<% } %>


<% 
if(access_ok) {
	out.print(yourname + "님 반갑습니다.<br>");
	out.print("<a href='logout.jsp'>로그아웃</a>");
} 
%>












</body>
</html>