<%@page import="com.jacaranda.model.Film"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.FilmRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List Films</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-primary">
	  <a class="navbar-brand text-white" href="../index.jsp">Home</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link text-white" href="addFilm.jsp">Add film</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="listFilms.jsp">List films</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././character/addCharacter.jsp">Add character</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././character/listCharacters.jsp">List characters</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././task/addTask.jsp">Add task</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././task/listTasks.jsp">List tasks</a>
	      </li>
	    </ul>
	  </div>
	</nav>
	<% 
		List<Film> result = FilmRepository.getFilms(); //Recupero todas las peliculas de la base de datos			
	%>

	<table class="table">
		<thread>
			<tr>
				<th scope="col">Title</th>
			</tr>
		</thread>
		<%/*Recorro las peliculas y por cada una creo una columa de la tabla que tengo aqui
		   * y creo un botón de info que cuando le demos nos lleva a la pagina de info de pelicula
		   * enviado el cip de la pelicula para despues poder recuperarlo en la página de info*/ 
		for (Film f: result){%>
				<tr>
					<td><%=f.getTitleP()%></td>
					<td>
						<form action="infoFilm.jsp">
							<input type="text" name="cip" value='<%=f.getCip()%>' hidden>
							<button type="submit" class="btn btn-primary btn-lg">Info</button>
						</form>
					</td>
				</tr>
		<% }%>
	</table>
</body>
</html>