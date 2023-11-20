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
		
		Character c = null;
	
		try{
			if (request.getParameter("inputName") != null 
					&& DbRepository.find(Character.class, request.getParameter("inputName")) != null) {
				session.setAttribute("error", "Error: a character with that name already exists in the database");
				
			}else {
					
					try {
						
						if ((request.getParameter("submit") != null)) {
							c = new Character (request.getParameter("inputName"), request.getParameter("inputNationality"), request.getParameter("inputSex"));
							DbRepository.addEntity(c);
						}
							
					}catch (CharacterException e) {
						session.setAttribute("error", e.getMessage());
					}
				}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
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
				  
				  

				  <% if (session.getAttribute("error") != null) {%>
					  <br> <textarea class="textAreaInfoError ml-25" readonly > <%= session.getAttribute("error") %> </textarea>
					  
				  <% }else if ((request.getParameter("submit") != null) && (session.getAttribute("error") == null)) {%>
					  <br> <textarea class="textAreaInfoSuccesfull ml-25" readonly > Character created successfully! </textarea>
				  <% } %>
				  
				  			  
				  <!-- Div of the submit button and redirect to list button  -->
				  <div class="d-grid">
				  	
				  	<button class="btn btn-primary btn-success" id="submitButton" type="submit" name="submit"> Save </button>
				  	
				  	<% if ((request.getParameter("submit") != null) && (session.getAttribute("error") == null) && (c != null)) { %>
						<a href="infoCharacter.jsp?characterName=<%=c.getCharacterName()%> "> 
							<button class="btn btn-primary" id="submitButton" type="button"> Show character </button> 
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