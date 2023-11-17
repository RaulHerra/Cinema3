<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="com.jacaranda.repository.CharacterRepository" %>
<%@ page import="com.jacaranda.exception.CharacterException" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Add Character </title>

<!-- ======= LINKS BOOTSTRAP NAVBAR ======= -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<!-- ======= LINKS BOOTSTRAP FORM ======= -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>

<body>
	
	<%
		
		Character c = null;
	

		if (CharacterRepository.getCharactersNames().contains(request.getParameter("inputName"))) {
			session.setAttribute("error", "Error: a character with that name already exists in the database");
			
		}else {
				
				try {
					
					if ((request.getParameter("submit") != null)) {
						
						c = new Character (request.getParameter("inputName"), request.getParameter("inputNationality"), request.getParameter("inputSex"));
						CharacterRepository.addCharacter(c);
					}
						
				}catch (CharacterException e) {
					session.setAttribute("error", e.getMessage());
				}
			}
		
		
	%>



<!-- ======= NAVBAR ======= -->
<nav class="navbar navbar-expand-lg navbar-light bg-primary ">
	<a class="navbar-brand text-white" href="../index.jsp">Home</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	  <span class="navbar-toggler-icon"></span>
	</button>
	
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	  <ul class="navbar-nav mr-auto">
	    <li class="nav-item">
	      <a class="nav-link text-white" href=".././film/addFilm.jsp">Add film</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href=".././film/listFilms.jsp">List films</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href="./addCharacter.jsp">Add character</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href="./listCharacters.jsp">List characters</a>
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



<!-- ======= INPUTS FORM ======= -->
<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <div class="h1 fw-light">Add Character</div>
	          </div>

				<form method="get" action="addCharacter.jsp">
				
				  <!-- Div of the input 'inputName' of the character's name  -->
				  <div>
				  
				    <div class="form-floating mb-3">
					    <label for="exampleInputEmail1" class="form-label">Character's name</label>
					    <input type="text" class="form-control" id="inputName" name="inputName" placeholder="Enter character's name" required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input 'inputNationality' of the character's nationality  -->
				  <div>
				    
				    <div class="form-floating mb-3">
					    <label for="exampleInputEmail1" class="form-label">Character's nationality</label>
					    <input type="text" class="form-control" id="inputNationality" name="inputNationality" placeholder="Enter character's nationality" required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input 'inputSex' of the character's sex  -->
				  <div>
				   
				    <div class="form-floating mb-3">
					    <label for="exampleInputEmail1" class="form-label">Character's sex</label>
					    <input type="text" class="form-control" id="inputSex" name="inputSex" placeholder="Enter character's sex (H, M, or O)" required>
					</div>
					
				  </div> 
				  
				  
				  <% if (session.getAttribute("error") != null) {%>
					  <br> <textarea class="textAreaInfoError ml-25" readonly> <%= session.getAttribute("error") %> </textarea>
					  
				  <% }else if ((request.getParameter("submit") != null) && (session.getAttribute("error") == null)) {%>
					  <br> <textarea class="textAreaInfoSuccesfull ml-25" readonly> Character created successfully! </textarea>
				  <% } %>
				  
				  
				  			  
				  <!-- Div of the submit button and redirect to list button  -->
				  <div class="d-grid">
				  	
				  	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="submit"> Save </button>
				  	
				  	<% if ((request.getParameter("submit") != null) && (session.getAttribute("error") == null) && (c != null)) { %>
						<a href="infoCharacter.jsp?characterName=<%=c.getCharacterName()%> "> 
							<button class="btn btn-primary btn-lg" id="submitButton" type="button"> Show character </button> 
						</a>
				  </div>
				  <%} session.setAttribute("error", null);%>
				  
			    </form>
			</div>
	      </div>
	    </div>
	  </div>
	</div>

</body>


</html>