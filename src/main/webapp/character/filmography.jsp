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

	Character c = null;
	String error = null;
	try{
		 c = DbRepository.find(Character.class, request.getParameter("characterFilms")) ;
		 
 	}catch(Exception e){
 		error = "Error: the character that you selected doesn't exist";
		return;
	}

%>
	<%if(c != null){ %>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
						<div class="text-center">
							<h1 align="center">
								Filmography of
								<%=c.getCharacterName()%></h1>
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
									for (Work w : c.getWorks()) {
									%>
									<tr>
										<td scope="col"><%=w.getFilm().getTitleP()%></td>
										<td scope="col"><%=w.getFilm().getYearProduction()%></td>
										<td scope="col"><%=w.getTask().getTask()%></td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
							<a
								href="infoCharacter.jsp?characterName=<%=c.getCharacterName()%>">
								<button class="btn btn-info " id="submitButton" type="button">Return</button>
							</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%}else{%>
	
		<div class="textAreaInfoError">Error: the character that you selected doesn't exist</div>
		<a href="./listCharacters.jsp"> <button class="btn btn-primary " id="submitButton" type="button">Return</button></a>
		
	<%}%>

</body>
</html>