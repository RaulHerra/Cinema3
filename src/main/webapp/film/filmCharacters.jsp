<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.Work" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<%@ page import="com.jacaranda.repository.CharacterRepository" %>
<%@ page import="com.jacaranda.repository.FilmRepository" %>
<%@ page import="org.hibernate.Hibernate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Film</title>
<!-- ======= LINKS BOOTSTRAP NAVBAR ======= -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<!-- ======= LINKS BOOTSTRAP FORM ======= -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
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
	
	Film f = null;
	
	try{
		f = FilmRepository.getFilm(request.getParameter("filmCharacters"));
	}catch(Exception e){
		session.setAttribute("error", "Error: the character that you selected doesn't exist");
		return;
	}

%>

	<table class="table">
	
		<thead>
		
			<tr>
			
				<td scope="col">Character's name</td>
				<td scope="col">Character's rol</td>
			
			</tr>
		
		</thead>
	
		<tbody>
			
			<%for(Work w : f.getCharacters()){ %>
			
				<tr>
				
					<td scope="col"><%=w.getCharacter().getCharacterName() %></td>
					<td scope="col"><%=w.getTask()%></td>
				
				</tr>
				
			<%} %>
		
		</tbody>
	
	</table>
</body>
</html>