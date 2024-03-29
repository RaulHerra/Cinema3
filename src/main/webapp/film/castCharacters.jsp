<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.Work" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<%@ page import="org.hibernate.Hibernate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cast</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>	

<%
	
	Film film = null;
	String error = null;
	try{
		/*Si el cip de la pelicula es nulo mandamos un mensaje de error*/
		if(request.getParameter("filmCharacters") == null){
			error = "Error: film not found in uri";
		}else{
			/*En caso de no ser nulo buscamos la pelicula con ese cip*/
			film = DbRepository.find(Film.class, request.getParameter("filmCharacters"));
			if(film == null){/*Si la pelicula es nula mandamos un mensaje de error*/
				error = "Error: the selected film doesn't exist";		
			}
		}
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Failed to connect to database");
		return;
	}

%>

	<% if(film != null){ %>
		<div class="container px-5 my-5">
			<div class="row justify-content-center">
				<div class="col-lg-8">
					<div class="card border-0 rounded-3 shadow-lg">
						<div class="card-body p-4">
							<div class="text-center">
								<h1 align="center">Cast from <br><%=film.getTitleP()%></h1>
								<br>
									<table class="table">
										<thead>
	
											<tr>
	
												<th scope="col">Character's name</th>
												<th scope="col">Character's rol</th>
	
											</tr>
	
										</thead>
	
										<tbody>
	
											<%
											for (Work work : film.getWorks()) {
											%>
	
											<tr>
	
												<td scope="col"><%=work.getCharacter().getCharacterName()%></td>
												<td scope="col"><%=work.getTask().getTask()%></td>
	
											</tr>
	
											<%
											}
											%>
	
										</tbody>
	
									</table>
							</div>
			            	<a href="./infoFilm.jsp?cip=<%=film.getCip()%>"><button class="btn btn-info" id="submitButton" type="button">Return</button></a>								
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Return button -->
		<%}else if(error != null){%>
			<div class="container px-5 my-5">
				<div class="row justify-content-center">
					<div class="col-lg-8">
						<div class="card border-0 rounded-3 shadow-lg">
							<div class="card-body p-4">
								<div class="text-center">
									<div class="textAreaInfoError"><%=error%></div>
								</div>
									<a href="./listFilms.jsp"><button class="btn btn-info"
											id="submitButton" type="button">Return to list</button></a>
							</div>
						</div>
					</div>
				</div>
			</div>
	<%}%>
</body>
</html>