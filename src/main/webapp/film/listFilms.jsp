<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
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
		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
		return;
	}
	%>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Title</th>
			</tr>
		</thead>
		<%/*Recorro las peliculas y por cada una creo una columa de la tabla que tengo aqui
		   * y creo un bot�n de info que cuando le demos nos lleva a la pagina de info de pelicula
		   * enviado el cip de la pelicula para despues poder recuperarlo en la p�gina de info*/ 
		for (Film f: result){%>
				<tr>
					<td><%=f.getTitleP()%></td>
					<td>
						<form action="infoFilm.jsp">
							<input type="text" name="cip" value='<%=f.getCip()%>' hidden>
							<button type="submit" class="btn btn-primary">Info</button>
						</form>
					</td>
				</tr>
		<% }%>
	</table>
</body>
</html>