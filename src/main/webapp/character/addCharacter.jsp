<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="com.jacaranda.exception.CharacterException" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Add Character </title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>

<body>
	<!-- ======= NAVBAR ======= -->
	<%@include file="../nav.jsp"%>
	<%
		try{
			String user = session.getAttribute("user").toString();
			if(!session.getAttribute("role").equals("ADMIN")){
				response.sendRedirect("../signup.jsp");
				return;
			}
		}catch(Exception e){
			response.sendRedirect("../login.jsp");
			return;
		}
	
	
		Character character = null;
		String error = null;
		try{
			if (request.getParameter("inputName") != null 
					&& DbRepository.find(Character.class, request.getParameter("inputName")) != null) {
				error = "Error: a character with that name already exists in the database";
				
			}else {
					
					try {
						
						if ((request.getParameter("submit") != null)) {
							character = new Character (request.getParameter("inputName"), request.getParameter("inputNationality"), request.getParameter("inputSex"));
							DbRepository.addEntity(character);
						}
							
					}catch (CharacterException e) {
						error = e.getMessage();
					}
				}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Failed to connect to database");
			return;
		}	
	%>



<!-- ======= INPUTS FORM ======= -->
<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <h1>Add Character</h1>
	          </div>

				<form method="get" action="addCharacter.jsp">
				
				  <!-- Div of the input 'inputName' of the character's name  -->
				  <div>
				  
				    <div class=" mb-3">
					    <label for="inputName" class="form-label">Character's name</label>
					    <input type="text" class="form-control" id="inputName" name="inputName" placeholder="Enter character's name" required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input 'inputNationality' of the character's nationality  -->
				  <div>
				    
				    <div class=" mb-3">
					    <label for="inputNationality" class="form-label">Character's nationality</label>
					    <input type="text" class="form-control" id="inputNationality" name="inputNationality" placeholder="Enter character's nationality" required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input 'inputSex' of the character's sex  -->
				  <div>
				   
				    <div class=" mb-3">
					    <label for="inputSex" class="form-label">Character's sex</label>
					    <input type="text" class="form-control" id="inputSex" name="inputSex" pattern="[H,M,O]" placeholder="Enter character's sex (H, M, or O)" required>
					</div>
					
				  </div> 
				  
				  

				  <% if (error != null) {%>
					   <div class="textAreaInfoError "> <%= error %> </div>
					  
				  <% }else if ((request.getParameter("submit") != null) && (error == null)) {%>
					   <div class="textAreaInfoSuccesfull "  > Character created successfully! </div>
				  <% } %>
				  
				  			  
				  <!-- Div of the submit button and redirect to list button  -->
				  	
				  	<button class="btn  btn-success" id="submitButton" type="submit" name="submit"> Save </button>
				  	
				  	<% if ((request.getParameter("submit") != null) && (error == null) && (character != null)) { %>
						<a href="infoCharacter.jsp?characterName=<%=character.getCharacterName()%> "> 
							<button class="btn btn-primary" id="submitButton" type="button"> Show character </button> 
						</a>
				  <%}%>
				  
				  
			    </form>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>