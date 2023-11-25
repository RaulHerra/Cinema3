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
<title>Cinema's room</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	List<Room> rooms = null;
	String cinemaId = null;
	String error = null;
	try {
		cinemaId = request.getParameter("cinema");
		Cinema tmpCinema = null;
		if (cinemaId == null) {
			error = "Cinema not found in uri";
		}else{
			 tmpCinema = (Cinema) DbRepository.find(Cinema.class, cinemaId);
		}
		
		if (tmpCinema == null) {
			error = "Cinema doesn't exist";
		}else{
			rooms = tmpCinema.getRooms();
		}

	} catch (Exception e) {
		System.out.print(e.getMessage());
		response.sendRedirect("../error.jsp?msg=Error connecting to database");
		return;
	}
	%>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
					<%if(rooms != null){%>
						<h1 align="center"><%= request.getParameter("cinema")%>'s
							rooms
						</h1>

						<table class="table">
							<thead>
								<tr>
									<th scope="col">Room</th>
									<th scope="col">Capacity</th>
								</tr>

							</thead>
							<%
							for (Room room : rooms) {
							%>
							<tr>
								<td><%=room.getRoomNumber()%></td>
								<td><%=room.getCapacity()%></td>
								<td>
									<a href="infoRoom.jsp?cinema=<%=room.getCinema().getCinema()%>&room=<%=room.getRoomNumber()%>"><button type="button" class="btn btn-primary">Info</button></a>
								</td>	
							</tr>

							<%
							}
							%>
						</table>
			            <%}if(error != null){%>
			            	<div class="textAreaInfoError " ><%=error%></div>
			            	<a href="../cinema/listCinemas.jsp"><button class="btn btn-primary " id="submitButton" type="button">Retry</button></a>
			            <%}%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>