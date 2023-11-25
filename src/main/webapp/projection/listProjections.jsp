<%@page import="com.jacaranda.repository.RoomRepository"%>
<%@page import="com.jacaranda.repository.CinemaRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jacaranda.repository.DbRepository"%>    
<%@ page import="com.jacaranda.model.Projection"%> 
<%@ page import="com.jacaranda.model.Cinema"%>
<%@ page import="com.jacaranda.model.Room"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Projections' list</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>

<body>


<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>
<% 
//A list variable with Projections is created with null value
		List<Cinema> result = new ArrayList<Cinema>();
		try{
			//I get a list of the Projections from the data base
			result = DbRepository.findAll(Cinema.class);
			
		}catch(Exception e) {
			response.sendRedirect("../error.jsp?msg=Failed to connect to database");
			return;
		}
	%>
	<div class="container px-7 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
						<div class="text-center">
							<h1 align="center">List of projections</h1>
							<br>
							<table class="table">
								<%
								for (Cinema cinema : result) {
								%>

								<tr>
									<th colspan="7"><h3>
											Cinema:
											<%=cinema.getCinema()%></h3></th>
								</tr>

								<%
								for (Room room : CinemaRepository.getRooms(cinema.getCinema())) {
								%>
								<tr>
									<th colspan="7"><h4>
											Sala:
											<%=room.getRoomNumber()%></h4></th>
								</tr>

								<tr>
									<th>Titulo</th>
									<th>Premiere</th>
									<th>Days</th>
									<th>Income</th>
									<th>Spectators</th>
								</tr>

								<%
								for (Projection projection : RoomRepository.getProjections(cinema, room.getRoomNumber())) {
								%>

								<tr>
									<td><%=projection.getFilm().getTitleP()%></td>
									<td><%=projection.getPremiereDate()%></td>
									<td><%=projection.getPremiereDays()%></td>
									<td><%=projection.getIncome()%></td>
									<td><%=projection.getSpectators()%></td>
									<td>
										<a class="btn btn-primary" href="infoProjection.jsp?premiereDate=<%=projection.getPremiereDate()%>&room=<%=projection.getRoom().getRoomNumber()%>&projection=<%=projection.getPremiereDate()%>&cinema=<%=cinema.getCinema()%>&film=<%=projection.getFilm().getCip()%>">
												Projection Info</a>
									</td>
									<td>
										<a href="../cinema/infoCinema.jsp?cinema=<%=cinema.getCinema() %>">
											<button class="btn btn-primary" type="button" name="cinema"
												value='<%=cinema.getCinema()%>'>Cinema Info</button></a>
									</td>
								</tr>
								<%
								}}}%>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>