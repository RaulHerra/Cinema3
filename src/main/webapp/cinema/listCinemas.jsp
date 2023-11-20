<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List Cinemas</title>

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
		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
		return;
	}
	%>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Cinema</th>
			</tr>
		</thead>
		<%/*Recorro las peliculas y por cada una creo una columa de la tabla que tengo aqui
		   * y creo un botón de info que cuando le demos nos lleva a la pagina de info de pelicula
		   * enviado el cip de la pelicula para despues poder recuperarlo en la página de info*/ 
		for (Cinema c: cinemas){%>
				<tr>
					<td><%=c.getCinema()%></td>
					<td>
						<form action="infoCinema.jsp">
							<input type="text" name="cinema" value='<%=c.getCinema()%>' hidden>
							<button type="submit" class="btn btn-primary">Info</button>
						</form>
					</td>
				</tr>
		<% }%>
	</table>
</body>
</html>