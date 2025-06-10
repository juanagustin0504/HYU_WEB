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
 			cookies[i].setMaxAge(0); // setMaxAge는 쿠키의 수명을 뜻함. (100)은 100초 수명, (0)은 0초 수명
 			response.addCookie(cookies[i]); // 세팅값을 pc에 저장되어 있는 쿠키에 저장시킨다.
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
로그아웃 되었습니다.
</body>
</html>