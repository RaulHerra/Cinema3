<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List of cinemas</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>
<body>
	<%@include file="../nav.jsp"%>
	<% 
	List<Cinema> cinemas = null;
	try{		
		cinemas = DbRepository.findAll(Cinema.class);			
	}catch(Exception e){
		//Cuando hay un error en la base de datos lo redirecciono a la página de error con el error correspondiente
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
							<h1 align="center">List of cinemas</h1>
							<br>
							<table class="table tableLeft">
								<%
								/*Recorro las cines y por cada una creo una columa de la tabla que tengo aqui
										   * y creo un botón de info que cuando le demos nos lleva a la pagina de info de cine
										   * enviado el nombre del cine para despues poder recuperarlo en la página de info*/
								for (Cinema cinema : cinemas) {
								%>
								<tr>
									<td><%=cinema.getCinema()%></td>
									<td>
										<a href="infoCinema.jsp?cinema=<%=cinema.getCinema()%>"><button type="button" class="btn btn-primary">Info</button></a>
									</td>
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