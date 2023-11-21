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
		Cinema tmpCinema = (Cinema)DbRepository.find(Cinema.class, cinemaId);
		result = tmpCinema.getRooms();
		
		try{
			cinemaId="La Catilica";//ESTO ES SOLO PARA PRUEBAS
			
			cinemaId = request.getParameter("cinema");
			
		}catch(Exception e){
			
		}
		
		
	}catch(Exception e){
		System.out.print(e.getMessage());
		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
		return;
	}
	%>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Sala</th>
				<th scope="col">Capacidad</th>
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