<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.jacaranda.model.Character" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Character's info</title>
</head>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

<body>

<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>

<%

	Character character = null;
	String error = null;
	try{
		if (request.getParameter("characterName") != null){
				
			character = DbRepository.find(Character.class, request.getParameter("characterName"));
	
			if(character==null){
				error = "Error: the character that you selected doesn't exist";
			}
			
			
		}else{
			error = "Error: character not found in the uri";

		}
			
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
	            <h1>Character's info</h1>
	          </div>

				<form method="get">
				
				<% if (character != null) { %>
					
				  <!-- Div of the input of the character's name  -->				  
				    <div  class=" mb-3">
					    <label for="inputName" class="form-label">Character's name</label>
					    <input type="text" class="form-control" id="inputName" name="inputName" value= '<%=character.getCharacterName() %>' readonly required>
					</div>
				  <!-- Div of the input of the character's nationality  -->
				    <div class=" mb-3">
					    <label for="inputNationality" class="form-label">Character's nationality </label>
					    <input type="text" class="form-control" id="inputNationality" name="inputNationality" value= '<%=character.getCharacterNationality() %>' readonly required>
					</div>			  
				  <!-- Div of the input of the character's sex  -->
				    <div class=" mb-3">
					    <label for="inputSex" class="form-label">Character's sex</label>
					    <input type="text" class="form-control" id="inputSex" name="inputSex" value="<%= character.getCharacterSex() %>" readonly required>
					</div>				
				  <!-- Div of the submit button and redirect to list button  -->
				  <% if(session.getAttribute("userRole").equals("ADMIN")){%>
				    <a href="editCharacter.jsp?characterName=<%=character.getCharacterName()%>"><button class="btn btn-warning" id="submitButton" value="edit" type="button" name="edit">Edit</button></a>
		            <a href="deleteCharacter.jsp?characterName=<%=character.getCharacterName()%>"><button class="btn btn-danger" id="submitButton" value="delete" type="button" name="delete">Delete</button></a>
				  <% } %>
			    </form>
			    <%} %>
			  <% if (error != null) {%>
				  <div class="textAreaInfoError" > <%=error%> </div>
			  <% }%>
				  <a href="./listCharacters.jsp"> <button class="btn btn-info" id="submitButton" type="button"> Return list </button></a>
			<% if (character != null) { %>
				<a href="./filmography.jsp?characterFilms=<%=character.getCharacterName()%>"><button class="btn btn-primary " id="submitButton" value="<%=character.getCharacterName()%>" name="characterFilms">See Filmography</button></a>
			<%} %>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>