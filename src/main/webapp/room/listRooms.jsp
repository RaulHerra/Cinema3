<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.model.Room"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Room list</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">


</head>
<body>
	<%@include file="../nav.jsp"%>
	<% 
	List<Room> result = null;
	String cinemaId = null;
	String error = null;
	try{		
	
		cinemaId = request.getParameter("cinema");
		
		if(cinemaId == null){
			response.sendRedirect("../error.jsp?msg=Cinema not found in uri");
			return;
		}
		
		
		Cinema tmpCinema = (Cinema)DbRepository.find(Cinema.class, cinemaId);
	
		if(tmpCinema == null){
			response.sendRedirect("../error.jsp?msg=Cinema doesn't exist");
			return;
		}
		result = tmpCinema.getRooms();
		
	}catch(Exception e){
		System.out.print(e.getMessage());
		response.sendRedirect("../error.jsp?msg=Error connecting to database");
		return;
	}
	%>
	
	<table class="table">
		<thead>
			<tr>
				<th scope="col">Sala</th>
				<th scope="col">Capacidad</th>
				<td>
	   				 <form method="get" action="../room/addRoom.jsp"><button class="btn btn-primary " id="submitButton" value="<%=request.getParameter("cinema")%>" name="cinema">Add rooms</button></form>
				</td>
			</tr>

		</thead>
		<%
		for (Room room: result){%>
			<tr>
				<td><%=room.getRoomNumber()%></td>
				<td><%=room.getCapacity()%></td>
			</tr> 
		

		<% }%>
    </table>
</body>
</html>