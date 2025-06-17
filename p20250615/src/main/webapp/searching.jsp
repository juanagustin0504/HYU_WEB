<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"  %>

<%
/* 
문제1. 오사카행 해서 최대 6시간 이내의 항공표만 보이게 함(오늘이 넘어가면 안됨)
문제2. 로그인 하지 않은 사용자가 searching 접근하면 비공식 접근입니다. 로그인하세요 라는 메세지 
문제3. 검색된 항공편  KOREAN AIRLINES 또는ASIANA AIRLINES 레코드 배경에는 배경이 yellow가 되게
hint
String abc = "abc def";
System.out.println(abc.contains("def"));

문제4. 모든비행기의 기본요금은 300,000원이라고 하자 오전 오후 5시까지 30% 할증 오후 5시 이후부터 7시까지 20%할증 7시 이후부터는 0% 할증
table에서 price 컬럼을 하나 더만들고 가격을 나타내는 코드를

 */


%>

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
<!-- 비로그인 시 보여줄 화면 -->
<% if(access_ok==false) { %>
	비공식 접근입니다. 로그인하세요.
<% } %>

<!-- 로그인 시 보여줄 화면 -->
<% if(access_ok) { 
%>

<%

	// main.jsp로부터 넘어온 데이터 가져오기 - 검색에 필요한 데이터
  	String getdeparture = request.getParameter("departure");
	int gethour = Integer.parseInt(request.getParameter("hour"));
	String getampm = request.getParameter("ampm");

	// pm이면 12시를 더해줌 다만, 오후 12시면 더해주지 않음(24:00가 되기 때문에)
	if (getampm.equals("pm") && gethour < 12) {
		gethour += 12;
	} 
	// am이면 12시 일 때만 12시를 빼줌 (오전 12시는 00:00 이기 때문)
	else if (getampm.equals("am") && gethour == 12) {
		gethour -= 12;
	}
	
	//DB (acompany) 연결하기
	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost:3306/airport?serverTimeZone=UTC";
	String id = "root";
	String pass = "abcde12345";

	//  DB연결
	Connection conn = DriverManager.getConnection(url, id, pass);

	// select문
	Statement dbst = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
%>
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
		<td>Price</td>
		<td>select</td>
	</tr>

<%

// for문을 돌리기 위해 레코드 카운트 세기
ResultSet rsCnt = dbst.executeQuery("select count(*) from inchon_departure where Destination like '%"+getdeparture+"%' and str_to_date(TimeOfDeparture,'%H:%i')>str_to_date('" + gethour + "','%H:%i') and str_to_date(TimeOfDeparture, '%H:%i')<str_to_date('23:59', '%H:%i') and str_to_date(TimeOfDeparture,'%H:%i')<str_to_date('" + (gethour + 6) + "', '%H:%i')");
rsCnt.next();
int cnt = rsCnt.getInt(1);
//out.print(cnt);

// 조건: 목적지, 시간(원하는 시간부터, 6시간 이내, 23:59분이 넘지 않게)
ResultSet rs = dbst.executeQuery("select * from inchon_departure where Destination like '%"+getdeparture+"%' and str_to_date(TimeOfDeparture,'%H:%i')>str_to_date('" + gethour + "','%H:%i') and str_to_date(TimeOfDeparture, '%H:%i')<str_to_date('23:59', '%H:%i') and str_to_date(TimeOfDeparture,'%H:%i')<str_to_date('" + (gethour + 6) + "', '%H:%i')");
// cnt 만큼 반복
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
	float price = 300000f; // 기본요금
	
	// price 계산
	// 시간에서 : 심볼을 공백으로 바꾼 후 정수로 변환하여 계산
	int time = Integer.parseInt(timeOfDeparture.replace(":", ""));
	if (time <= 1700) { // 오후 5시까지 17:00
		price *= 1.3f;
	} else if (time <= 1900) { // 오후 7시까지 19:00
		price *= 1.2f;
	} else { // 나머지
		// 0% 할증
	}
	
	// 해당 항공사에 해당하면 bgcolor=yellow
	if (airline.contains("KOREAN AIRLINES") || airline.contains("ASIANA AIRLINES")) {
		out.print("<tr bgcolor='yellow'>");
	} else {
		out.print("<tr>");	
	}
	out.print("<td>" + no + "</td>");
	out.print("<td>" + flightDate + "</td>");
	out.print("<td>" + flightNo + "</td>");
	out.print("<td>" + timeOfDeparture + "</td>");
	out.print("<td>" + periodStart + "</td>");
	out.print("<td>" + periodEnd + "</td>");
	out.print("<td>" + airline + "</td>");
	out.print("<td>" + destination + "</td>");
	out.print("<td>" + price + "</td>");
	out.print("<td><input type='radio' name='selectedFlight' value='" + no + "'></td>");
	out.print("</tr>");
}


%>



</table>
<br>
<input type="submit" value="예약하기">
</form>

<%
} // end of if(access_ok)
%>

</body>
</html>