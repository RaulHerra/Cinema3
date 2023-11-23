<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List Films</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>
<body>
	<%@include file="../nav.jsp"%>
	<% 
	List<Film> result = null;
	try{		
		result = DbRepository.findAll(Film.class);			
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Failed to connect to database");
		return;
	}
	%>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
						<div class="text-center">
						<h1 align="center">List of films</h1>
							<br>
							<table class="table tableLeft">
								<%
								/*Recorro las peliculas y por cada una creo una columa de la tabla que tengo aqui
										   * y creo un botón de info que cuando le demos nos lleva a la pagina de info de pelicula
										   * enviado el cip de la pelicula para despues poder recuperarlo en la página de info*/
								for (Film f : result) {
								%>
								<tr>
									<td><%=f.getTitleP()%></td>
									<td>
										<form action="infoFilm.jsp">
											<button type="submit" class="btn btn-primary" name="cip" value='<%=f.getCip()%>'>Info</button>
										</form>
									</td>
								</tr>
								<%
								}
								%>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>