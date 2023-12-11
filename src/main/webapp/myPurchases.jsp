<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.model.User"%>
<%@page import="com.jacaranda.repository.ticketRepository"%>
<%@page import="com.jacaranda.model.Projection"%>
<%@page import="com.jacaranda.model.Ticket"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Purchases</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="./style/style.css">

</head>
<body>
	<%@include file="../nav.jsp"%>
	<% 
	List<Object[]> tickets = null;
	try{
		tickets = ticketRepository.findByUser(session.getAttribute("username").toString());
	}catch(Exception e){
		//Cuando hay un error en la base de datos lo redirecciono a la página de error con el error correspondiente
		response.sendRedirect("./error.jsp?msg=Failed to connect to database");
		return;
	}
	%>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
						<div class="text-center">
							<h1 align="center">List of tickets</h1>
							<br>
							<table class="table tableLeft">
								<%
								for (Object[] t : tickets) {
									Film film = DbRepository.find(Film.class,t[2]);
								%>
								
								<tr>
									<td>Cinema: <%=t[0]%> Room: <%=t[1]%> Date: <%=t[3]%> <%=film.getTitleP()%></td>
								</tr>
								<% }%>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>