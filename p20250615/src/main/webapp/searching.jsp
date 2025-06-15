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


// main.jsp로부터 넘어온 데이터 가져오기 - 검색에 필요한 데이터
String getdeparture = request.getParameter("departure");
String getampm = request.getParameter("ampm");
String gethour = request.getParameter("hour");


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
//ResultSet rs = dbst.executeQuery("select * from inchon_departure where departure='"+getdeparture+"' and str_to_date(TimeOfDeparture,'%H:%i')>str_to_date('" + gethour + "','%H:%i')");
//rs.next();
//int lastnumber = rs.getInt(1);

%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>

<form method="post" action="reservation.jsp">
<table border="1">

	<tr>
		<td>no</td>
		<td>FlightDate</td>
		<td>FlightNo</td>
		<td>TimeOfDeparture</td>
		<td>PeriodStart</td>
		<td>PeriodEnd</td>
		<td>Airline</td>
		<td>Destination</td>
		<td>select</td>
	</tr>

<%

ResultSet rsCnt = dbst.executeQuery("select count(*) from inchon_departure where Destination like '%"+getdeparture+"%' and str_to_date(TimeOfDeparture,'%H:%i')>str_to_date('" + gethour + "','%H:%i')");
rsCnt.next();
int cnt = rsCnt.getInt(1);
out.print(cnt);


ResultSet rs = dbst.executeQuery("select * from inchon_departure where Destination like '%"+getdeparture+"%' and str_to_date(TimeOfDeparture,'%H:%i')>str_to_date('" + gethour + "','%H:%i')");
for(int i = 0; i < cnt; i++) {
	rs.next();
	int no = rs.getInt(1);
	String flightDate = rs.getString(2);
	String flightNo = rs.getString(3);
	String timeOfDeparture = rs.getString(4);
	String periodStart = rs.getString(5);
	String periodEnd = rs.getString(6);
	String airline = rs.getString(7);
	String destination = rs.getString(8);
	
	//String value = flightNo + "," + destination + "," + timeOfDeparture + ",0"; // price는 임시로 0원 필요시 거리 계산 후 가격 측정
	
	out.print("<tr>");
	out.print("<td>" + no + "</td>");
	out.print("<td>" + flightDate + "</td>");
	out.print("<td>" + flightNo + "</td>");
	out.print("<td>" + timeOfDeparture + "</td>");
	out.print("<td>" + periodStart + "</td>");
	out.print("<td>" + periodEnd + "</td>");
	out.print("<td>" + airline + "</td>");
	out.print("<td>" + destination + "</td>");
	out.print("<td><input type='radio' name='selectedFlight' value='" + no + "'></td>");
	out.print("</tr>");
}


%>

</table>
<br>
<input type="submit" value="예약하기">
</form>

</body>
</html>