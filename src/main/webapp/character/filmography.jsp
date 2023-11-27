<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="com.jacaranda.model.Work" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Filmography</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

	<%@include file="../nav.jsp"%>

<%

	Character character = null;
	String error = null;
	try{
		//Si el id del caracter no existe en este caso su nombre mandamos un mensaje de error
		if(request.getParameter("characterFilms") == null){
			error = "Error: character not found in uri";
		}else{//En caso de no ser nulo lo buscaremos
		 	character = DbRepository.find(Character.class, request.getParameter("characterFilms"));
		 	if(character == null){//Si el caracter es nulo mandamos un mensaje de error
				error = "Error: the selected character doesn't exist";		
			}
		}
 	}catch(Exception e){
 		error = "Error: the character that you selected doesn't exist";
		return;
	}

%>
	<%if(character != null){ %>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
						<div class="text-center">
							<h1 align="center">
								Filmography of
								<%=character.getCharacterName()%></h1>
							<br>
							<table class="table">
								<thead>
									<tr>
										<th scope="col">Title</th>
										<th scope="col">Release year</th>
										<th scope="col">Character's rol</th>
									</tr>
								</thead>

								<tbody>

									<%
									for (Work work : character.getWorks()) {
									%>
									<tr>
										<td scope="col"><%=work.getFilm().getTitleP()%></td>
										<td scope="col"><%=work.getFilm().getYearProduction()%></td>
										<td scope="col"><%=work.getTask().getTask()%></td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
							<a
								href="infoCharacter.jsp?characterName=<%=character.getCharacterName()%>">
								<button class="btn btn-info " id="submitButton" type="button">Return</button>
							</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Return button -->
	<%}else{%>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
						<div class="text-center">
							<div class="textAreaInfoError">Error: the character that
								you selected doesn't exist</div>
						</div>
						<a href="./listCharacters.jsp">
							<button class="btn btn-info " id="submitButton" type="button">Return to list</button>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%}%>

</body>
</html>