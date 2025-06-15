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


// searching.jsp로부터 넘어온 데이터 가져오기 - 검색에 필요한 데이터 - no
String getSelectedFlight = request.getParameter("selectedFlight");

//DB (acompany) 연결하기
Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://localhost:3306/airport?serverTimeZone=UTC";
String id = "root";
String pass = "abcde12345";

//  DB연결
Connection conn = DriverManager.getConnection(url, id, pass);

// select문
Statement dbst = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
// SQL 명령어 실행, select문의 결과는 resultset 클래스의 객체에 저장됨.
// order by no asc는 오름차순으로 정렬함. record 추가시 행이 순서대로 저장되지 않기 때문에 출력시 꼭 no기준 오름차순으로 정렬해야 함.
ResultSet rs = dbst.executeQuery("select * from inchon_departure where no=" + getSelectedFlight);
rs.next();
int no = rs.getInt(1);
String idFromCookie = yourname;
String flightno = rs.getString(3);
String datetime = rs.getString(4);
String destination = rs.getString(8);
String price = "0";

//레코드 입력
Statement insert = conn.createStatement();
String runmessage = "insert into reservation values(" + no + ", '" + idFromCookie + "', '" + flightno + "', '" + destination + "', '" + datetime + "', '" + price + "')";
insert.executeUpdate( runmessage );

%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>