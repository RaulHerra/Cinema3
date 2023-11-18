<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.repository.CharacterRepository"%>
<%@page import="com.jacaranda.model.Character"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Character</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
		<%@include file="../nav.jsp"%>

		<%
		/*I create a new Character with null value*/
		Character c = null; 
		try{
			/*If the character with the name that I recovered from the parameter from the info page exists...*/
			if(request.getParameter("characterName") != null 
					&& DbRepository.find(Character.class, request.getParameter("characterName")) != null){
				/*I get the character with the name I received*/
				c = DbRepository.find(Character.class, request.getParameter("characterName"));
			
			}else{//If there isn't any characters, I assign to the session variable the text of the error
				session.setAttribute("error", "Error there is no character with the character's name entered");
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
			            <div class="h1 fw-light">Delete Character</div>
			          </div>
					
			          <form>
			          <%if(c != null){ /*This if shows the character*/ %>
			            <!-- Character's name Input -->
			            <div class="form-floating mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Character's name</label>
			    			<input type="text" class="form-control" id="characterName" name="characterName" value='<%= c.getCharacterName() %>'readonly required>
			            </div>
			
			            <!-- Character's nationality Input -->
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Character's nationality</label>
			    			<input type="text" class="form-control" id="characterNationality" name="characterNationality" placeholder="Enter Character Nationality" value="<%= c.getCharacterNationality() %>" readonly required>
			            </div>
			
			            <!-- Character's sex Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Character's sex</label>
			    			<input type="text" step="1" class="form-control" id="characterSex" name="characterSex" placeholder="Enter Character Sex" value="<%= c.getCharacterSex() %>" readonly required>
			            </div>
			            
			            
			            <%}%>
			            <%
			            /*When the value of the session variable is null is when an error occured, so I show a textarea
			            with the value of the session variable with the error message*/
			            if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
			            <%
			            
			            /*And here if it is sent the submit, and the value of the session variable 
			            is null, that means that the character was deleted, so I show the success message*/
			            }else if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
			            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Character deleted successfully!</textarea>
			            
			            <%}
			            %>
			            
			            
			            
			            <!-- All of the buttons -->
			            <div class="d-grid">
			            	
			            	<!--  This button is the one that will appear at first, telling you if you are sure of deleting the character.
			            	When pressed, it will appear the red "Confirm" button, and the "Undo" one. -->
			            	<% if ((request.getParameter("delete") == null) && (request.getParameter("submit") == null) && (session.getAttribute("error") == null)) { %>
			            		<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="delete"> Are you sure you want to delete it?</button>
			            	
				            
				            <!-- The buttons "Confirm" and "Undo" will appear after the first one, and when "Confirm" is pressed to delete
			            	the character, it will disappear because this 'if' detects if the "Are you sure" button is pressed because it has
			            	the "submit" value in it. The "Undo" button will send you back to the infoCharacter.jsp page -->	
			            	<%} else if (request.getParameter("delete") != null) { %>
			            		<button class="btn btn-danger btn-lg" id="submitButton" type="submit" name="submit">Confirm</button>
				        	    <a href="./infoCharacter.jsp?characterName=<%=request.getParameter("characterName")%>"> 
				        	    	<button class="btn btn-primary btn-lg" id="submitButton" type="button" name="undo">Undo</button>
				        	    </a>
				            	
				            
			            	<!-- Here I delete the character with the character's name that I recovered, and it appears a "Return to list" button.
							The "Confirm" and "Undo" buttons will disappear once "Confirm" is pressed, and the "Return to list" button will
							appear-->
			            	<%} else if (request.getParameter("submit") != null) {
			            		DbRepository.deleteEntity(c);%>
				           		<a href="./listCharacters.jsp"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Return to list</button></a>
			            	<%}else if(session.getAttribute("error") != null){%>
        					    <a href="./listCharacters.jsp"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Return to list</button></a>
		            		<%}session.removeAttribute("error"); /*When all of this happens, I set the error value null to reset it if another error occurs when the form is sent again*/
		            		%>
			            	
			            	
			       
							
			            </div>
			          </form>
			          <!-- End of contact form -->
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>