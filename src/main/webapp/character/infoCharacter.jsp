<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.jacaranda.model.Character" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info Character</title>
</head>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

<body>

<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>

<%

	Character c = null;
	
	try{
		if (request.getParameter("characterName") != null){
				
			c = DbRepository.find(Character.class, request.getParameter("characterName"));
	
			if(c==null){
				session.setAttribute("error", "Error: the character that you selected doesn't exist");
			}
			
			
		}else{
			session.setAttribute("error", "Error: character not found in the uri");

		}
			
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
		return;
	}
		

%>



<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <h1>Info Character</h1>
	          </div>

				<form method="get">
				
				<% if (c != null) { %>
					
				  <!-- Div of the input of the character's name  -->				  
				    <div  class=" mb-3">
					    <label for="inputName" class="form-label">Character's name</label>
					    <input type="text" class="form-control" id="inputName" name="inputName" value= '<%=c.getCharacterName() %>' readonly required>
					</div>
				  <!-- Div of the input of the character's nationality  -->
				    <div class=" mb-3">
					    <label for="inputNationality" class="form-label">Character's nationality </label>
					    <input type="text" class="form-control" id="inputNationality" name="inputNationality" value= '<%=c.getCharacterNationality() %>' readonly required>
					</div>			  
				  <!-- Div of the input of the character's sex  -->
				    <div class=" mb-3">
					    <label for="inputSex" class="form-label">Character's sex</label>
					    <input type="text" class="form-control" id="inputSex" name="inputSex" value="<%= c.getCharacterSex() %>" readonly required>
					</div>				
				  <!-- Div of the submit button and redirect to list button  -->
					    <button class="btn btn-warning" id="submitButton" value="edit" type="submit" name="edit">Edit</button>
			            <button class="btn btn-danger" id="submitButton" value="delete" type="submit" name="delete">Delete</button>
				  
				  <% if (session.getAttribute("error") != null) {%>
					  <div class="textAreaInfoError" > <%= session.getAttribute("error") %> </div>
					  <a href="./listCharacters.jsp"> <button class="btn btn-primary " id="submitButton" type="button"> Return list </button></a>
				  <% }session.removeAttribute("error");%>
				  
			    </form><br>
			    <%} %>
				<% if (c != null) { %>
				    <form method="post" action="./characterFilms.jsp"><button class="btn btn-primary " id="submitButton" value="<%=c.getCharacterName()%>" name="characterFilms">See Filmography</button></form>
				<%} %>
			</div>
	      </div>
	    </div>
	  </div>
	<%
			if (request.getParameter("edit") != null) {
				response.sendRedirect("editCharacter.jsp?characterName=" + request.getParameter("inputName"));
				
			}else if (request.getParameter("delete") != null) {
				response.sendRedirect("deleteCharacter.jsp?characterName=" + request.getParameter("inputName"));
			}
	%>
	</div>


</body>
</html>