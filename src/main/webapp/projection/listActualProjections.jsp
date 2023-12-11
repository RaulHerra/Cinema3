<%@page import="com.jacaranda.repository.RoomRepository"%>
<%@page import="com.jacaranda.repository.CinemaRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.repository.ProjectionRepository"%>    
<%@ page import="com.jacaranda.model.Projection"%> 
<%@ page import="com.jacaranda.model.Cinema"%>
<%@ page import="com.jacaranda.model.Room"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of projections</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>

<body>


<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>
<% 
//A list variable with Projections is created with empty value
		List<Projection> result = new ArrayList<Projection>();
		try{
			//I get a list of the Projections from the data base
			result = ProjectionRepository.findAllInActualDate();
			
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
								for (Projection projection : result) {
									Cinema cine = projection.getRoom().getCinema();
									Room room = projection.getRoom();
								%>
								<tr>
									<th colspan="5"><h4>
											Cinema:
											<%=cine.getCinema()%>
											Sala:
											<%=room.getRoomNumber()%></h4></th>
								</tr>

								<tr>
									<th>Title</th>
									<th>Premiere</th>
									<th>Days</th>
									<th>Address</th>
								</tr>

								<tr>
									<td><%=projection.getFilm().getTitleP()%></td>
									<td><%=projection.getPremiereDate()%></td>
									<td><%=projection.getPremiereDays()%></td>
									<td><%=projection.getRoom().getCinema().getAddressCinema()%></td>
									<td>
										<a class="btn btn-primary" href="../ticket/buyTickets.jsp?premiereDate=<%=projection.getPremiereDate()%>&room=<%=projection.getRoom().getRoomNumber()%>&cinema=<%=cine.getCinema()%>&film=<%=projection.getFilm().getCip()%>">Projection Info</a>
									</td>
								</tr>
								<%
								}%>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>