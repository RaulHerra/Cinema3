<%@page import="com.jacaranda.repository.RoomRepository"%>
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
	String error = null;
	List<Cinema> cinemas = null;
	try {

		try {
			cinemas = (List<Cinema>) DbRepository.findAll(Cinema.class);

		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Failed to connect to database");
			return;
		}

		if (cinemas == null) {
			response.sendRedirect("../error.jsp?msg=Cinema doesn't exist");
			return;
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
					
						<table class="table">
							<thead>
								<tr>
									<td colspan="2">
										<h1>List rooms</h1>
									</td>
								</tr>

							</thead>
							<%
							for (Cinema cinema : cinemas) {
							%>
							<tr>
								<th colspan="2">Cinema: <%=cinema.getCinema()%></th>
							</tr>

							<tr>
								<th>Room number</th>
								<th>Room capacity</th>
							</tr>
							<%
								for (Room room : cinema.getRooms()) {
								%>
								<tr>
									<td><%=room.getRoomNumber()%></td>
									<td><%=room.getCapacity()%></td>
								</tr>
								<%
								}
								%>
							<%
							}
							%>
						</table>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>