<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


	// client PC에 있는 쿠키값을 가져오기
	Cookie[] getcookie = request.getCookies();
	String aa = getcookie[1].getName();
	String bb = getcookie[1].getValue();


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	
	
		out.print(aa + "<br>");
		out.print(bb + "<br>");
		
		
		for(int i = 0; i < getcookie.length; i++) {
			if(getcookie[i].getName().equals("name")) {
				out.print("당신의 이름은 " + getcookie[i].getValue() + "입니다." + "<br>");
				
			}
		}
	%>

</body>
</html>