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
			response.sendRedirect("../error.jsp?msg=Can't access to data base");
			return;
		}
	%>

	<table class="table">
		<% for (Cinema c: result){%>
		
			<tr><td colspan="7"><h3>Cinema: <%=c.getCinema()%></h3></td></tr>
	
			<% for (Room r: CinemaRepository.getRooms(c.getCinema())){%>
				<tr>
					<td colspan="7"><h4>Sala: <%=r.getRoomNumber()%></h4></td>
				</tr>

					<tr>
						<th>Titulo</th>
						<th>Premiere</th>
						<th>Days</th>
						<th>Income</th>
						<th>Income</th>
					</tr>

				<% for (Projection p: RoomRepository.getProjections(c, r.getRoomNumber())){%>
					
					<tr>
						<td><%=p.getCip().getTitleP()%></td>
						<td><%=p.getPremiere_date()%></td>
						<td><%=p.getPremiere_days()%></td>
						<td><%=p.getIncome()%></td>
						<td><%=p.getSpectators()%></td>
						<td>
							<form action="infoProjection.jsp">
								<input type="text" name="ProjectionName" value='<%=p.getRoom()%>' hidden>
								<input type="text" name="ProjectionName" value='<%=p.getCip()%>' hidden>
								<input type="text" name="ProjectionName" value='<%=p.getPremiere_date()%>' hidden>
								<button class="btn btn-primary" type="submit" name="info"> Projection Info </button>
							</form>
						</td>
					<td>
						<form action="infoCinema.jsp">
							<input type="text" name="ProjectionName" value='<%=c.getCinema()%>' hidden>
							<button class="btn btn-primary" type="submit" name="info"> Cinema Info </button>
						</form>
					</td>
					</tr>
		<% }}}%>
	</table>


</body>

</html>