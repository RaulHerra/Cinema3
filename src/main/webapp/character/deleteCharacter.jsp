<%@page import="com.jacaranda.repository.CharacterRepository"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Character"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Character</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>
<body>
		<%@include file="../nav.jsp"%>

		<%
		/*I create a new Character with null value*/
		Character c = null;
		String error = null;
		try{
			/*If the character with the name that I recovered from the parameter from the info page exists...*/
			if(request.getParameter("characterName") != null 
					&& DbRepository.find(Character.class, request.getParameter("characterName")) != null){
				/*I get the character with the name I received*/
				c = DbRepository.find(Character.class, request.getParameter("characterName"));
			
			}else{
				error = "Error there is no character with the character's name entered";
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
			            <h1>Delete Character</h1>
			          </div>
					
			          <form method="get">
			          <%if(c != null){ /*This if shows the character*/ %>
			            <!-- Character's name Input -->
			            <div class=" mb-3">
			    			<label for="characterName" class="form-label">Character's name</label>
			    			<input type="text" class="form-control" id="characterName" name="characterName" value='<%= c.getCharacterName() %>'readonly required>
			            </div>
			
			            <!-- Character's nationality Input -->
			            <div class="mb-3">
			                <label for="characterNationality" class="form-label">Character's nationality</label>
			    			<input type="text" class="form-control" id="characterNationality" name="characterNationality" placeholder="Enter Character Nationality" value="<%= c.getCharacterNationality() %>" readonly required>
			            </div>
			
			            <!-- Character's sex Input -->
			            <div class=" mb-3">
							<label for="characterSex" class="form-label">Character's sex</label>
			    			<input type="text" step="1" class="form-control" id="characterSex" name="characterSex" placeholder="Enter Character Sex" value="<%= c.getCharacterSex() %>" readonly required>
			            </div>
			            
			            
			            <%}%>
			            <%

			            if(error != null){%>
			            	<div class="textAreaInfoError "><%=error%></div>
			            <%
			            

			            }else if(request.getParameter("submit") != null && error == null){%>
			            	<div class="textAreaInfoSuccesfull " >Character deleted successfully!</div>
			            
			            <%}
			            %>
			            
			            
			            
			            <!-- All of the buttons -->
			            	
			            	<% if ((request.getParameter("delete") == null) && (request.getParameter("submit") == null) && (error == null)) { %>
			            		<button class="btn btn-danger" id="submitButton" type="submit" name="delete"> Are you sure you want to delete it?</button>
			            	
			            	<%} else if (request.getParameter("delete") != null) { %>
			            		<button class="btn btn-danger " id="submitButton" type="submit" name="submit">Confirm</button>
				        	    <a href="./infoCharacter.jsp?characterName=<%=request.getParameter("characterName")%>"> 
				        	    	<button class="btn btn-primary " id="submitButton" type="button" name="undo">Undo</button>
				        	    </a>
				            	
				            
			            	
			            	<%} else if (request.getParameter("submit") != null) {
			            		CharacterRepository.delete(c);%>
				           		<a href="./listCharacters.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return to list</button></a>
		            		<%}else if(error != null){%>
				           		<a href="./listCharacters.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return to list</button></a>
		            		<%}%>
							
			          </form>

			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>