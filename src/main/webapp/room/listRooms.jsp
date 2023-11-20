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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">

</head>
<body>
	<%@include file="../nav.jsp"%>
	<% 
	List<Room> result = null;
	
	try{		
		String cinemaId = request.getParameter("cinema");
		cinemaId="La Catilica";
		Cinema tmpCinema = (Cinema)DbRepository.find(Cinema.class, cinemaId);
		result = tmpCinema.getRooms();
		
		
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