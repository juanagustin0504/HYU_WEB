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
String flightDate = rs.getString(2);
String flightNo = rs.getString(3);
String dateTime = rs.getString(4);
String airline = rs.getString(7);
String destination = rs.getString(8);
String price = "0";

/*
// price 구하는 과정 
// - 도착지(destination)로 IATA, ICAO 값을 구함(airport_code table)
// - IATA, ICAO 값으로 거리를 구함(distance table)
// - 문제에 제출된 단가?를 곱해줌

// 도착지로 IATA, ICAO 값을 구하기 위해 select 문 사용
ResultSet rs_airport_code = dbst.executeQuery("select * from airport_code where eng_airport like '%" + destination + "%'");
rs_airport_code.next(); // 첫번째 행으로 이동
// airport_code 테이블 구조
// 1. eng_airport
// 2. kor_airport// 3. IATA
// 4. ICAO
String iata = rs_airport_code.getString(3); // IATA
String icao = rs_airport_code.getString(4); // ICAO

// IATA, ICAO 값으로 거리를 구하기 위해 select 문 사용
ResultSet rs_distance = dbst.executeQuery("select * from distance where IATA='" + iata + "' and ICAO='" + icao + "'");
rs_distance.next(); // 첫번째 행으로 이동
// distance 테이블 구조
// 1. IATA
// 2. ICAO
// 3. distance_km

String ori_distance_km = rs_distance.getString(3); // distance_km. ex) 9,986
String distance_km = ori_distance_km.replace(",", ""); // ',' 문자를 공백으로 치환
int unit_price = 10; // 단가. 임시로 10원 지정
int multi_with_distance = Integer.parseInt(distance_km) * unit_price; // 거리 * 단가
price = multi_with_distance + "원"; // 금액(정수)을 문자열로 변환하기 위해서 "원"과 결합, 필요에 따라 ""(공백)으로 변경
*/

//레코드 입력
Statement insert = conn.createStatement();
String runmessage = "insert into reservation values("+no+",'" + flightNo + "','" + flightDate + "','" + dateTime + "','" + yourname + "','" + airline + "', '" + destination + "','" + price + "')";
insert.executeUpdate( runmessage );



%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p style="text-align:center;">예약완료</p>
    <table align="center" border="1">
        <tr>
            <td>No</td>
            <td>FlightNo</td>
            <td>Date</td>
         	<td>DateTime</td>
            <td>ID</td>
            <td>Airline</td>
            <td>Destination</td>
            <td>Price</td>           
        </tr>
        <%
         // 예약 내역 전체 테이블로 보여주기 테이블 마지막 괄호 챙겨 (tr)끝에
            /* for (int i = 0; i < cnt; i++) {
               rs1.next();
                int no1 = rs1.getInt(1);
                String flightNo1 = rs1.getString(2);
                String flightDate1 = rs1.getString(3);
                String timeOfDeparture1 = rs1.getString(4);
                String id1 = rs1.getString(5);
                String airline1 = rs1.getString(6);
                String destination1 = rs1.getString(7);
                String price1 = rs1.getString(8);
            */     
%>
  <tr>
            <td><%= no %></td>
            <td><%= flightNo %></td>
            <td><%= flightDate  %></td>
            <td><%= dateTime  %></td>
            <td><%= yourname %></td>
            <td><%= airline %></td>
            <td><%= destination %></td>
            <td><%= price %></td>
        </tr>
<%        
            // }    
%>       
</table>


</body>
</html>