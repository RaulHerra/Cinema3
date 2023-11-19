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

<!-- ======= LINKS BOOTSTRAP NAVBAR ======= -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<!-- ======= LINKS BOOTSTRAP FORM ======= -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

<body>

<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>

<%

	Character c = null;
	
	try{
		if (request.getParameter("characterName") != null 
				&& DbRepository.find(Character.class, request.getParameter("characterName")) != null) {
	
			try {
				
				c = DbRepository.find(Character.class, request.getParameter("characterName"));
				
			}catch (Exception e) {
				session.setAttribute("error", "Error: the character that you selected doesn't exist");
	
			}
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
	            <div class="h1 fw-light">Info Character</div>
	          </div>

				<form method="get">
				
				<% if (c != null) { %>
					
				  <!-- Div of the input of the character's name  -->
				  <div>
				  
				    <div class="form-floating mb-3">
					    <label for="exampleInputEmail1" class="form-label">Character's name</label>
					    <input type="text" class="form-control" id="inputName" name="inputName" value= '<%=c.getCharacterName() %>' readonly required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input of the character's nationality  -->
				  <div>
				    
				    <div class="form-floating mb-3">
					    <label for="exampleInputEmail1" class="form-label">Character's nationality </label>
					    <input type="text" class="form-control" id="inputName" name="inputNationality" value= '<%=c.getCharacterNationality() %>' readonly required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input of the character's sex  -->
				  <div>
				   
				    <div class="form-floating mb-3">
					    <label for="exampleInputEmail1" class="form-label">Character's sex</label>
					    <input type="text" class="form-control" id="inputSex" name="inputSex" value="<%= c.getCharacterSex() %>" readonly required>
					</div>
					
				  </div> 
				  
				  
				  <!-- Div of the submit button and redirect to list button  -->
				  <div>
				  
					<div class="d-grid">
					    <button class="btn btn-primary btn-lg" id="submitButton" value="edit" type="submit" name="edit">Edit</button>
			            <button class="btn btn-primary btn-lg" id="submitButton" value="delete" type="submit" name="delete">Delete</button>
			            
					</div>
					
				  </div>
				  
				  
				  <% if (session.getAttribute("error") != null) {%>
					  <br> <textarea class="textAreaInfoError ml-25" readonly> <%= session.getAttribute("error") %> </textarea>
					  <a href="./listCharacters.jsp"> <button class="btn btn-primary btn-lg" id="submitButton" type="button"> Return list </button></a>
					  
				  <% }session.removeAttribute("error");%>
				  
			    </form>
			    <%} %>
			</div>
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

</body>
</html>