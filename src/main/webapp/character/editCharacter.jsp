<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.exception.CharacterException"%>
<%@page import="com.jacaranda.model.Character"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Character</title>
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
			/*I check if the character that I am going to edit exists*/
			if(request.getParameter("characterName") != null 
					&& DbRepository.find(Character.class, request.getParameter("characterName")) != null){
				
				/*I obtain the character with the character's name that I received*/
				character = DbRepository.find(Character.class, request.getParameter("characterName"));
				
				if(request.getParameter("edit") != null){
					
					/*When I push the edit button, I create a new character with the new data*/
					try{
						
						character = new Character(request.getParameter("characterName"),
								request.getParameter("characterNationality"),
								request.getParameter("characterSex"));
						/*I call the method of the repository that edits the character*/
						DbRepository.editEntity(character);
					
					}catch(CharacterException e){
						error = e.getMessage();
					}
				}
			}else{
				error = "Error there is no character with such a name";
			}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Failed to connect to database");
			return;
		}%>
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <h1>Edit Character</h1>
			          </div>
					<%if(character != null){/*If the character that is introduced is not null, I show the information of the character*/ %>
			          <form method="get">
			            <!-- Character Name Input -->
			            <div class=" mb-3">
			    			<label for="characterName" class="form-label">Character's name</label>
			    			<input type="text" class="form-control" id="characterName" name="characterName" value='<%=character.getCharacterName()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class=" mb-3">
			                <label for="characterNationality" class="form-label">Character's nationality</label>
			    			<input type="text" class="form-control" id="characterNationality" name="characterNationality" placeholder="Enter Character Nationality" value="<%=character.getCharacterNationality()%>" required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class=" mb-3">
							<label for="characterSex" class="form-label">Character's sex</label>
			    			<input type="text" step="1" class="form-control" id="characterSex" name="characterSex" pattern="[H,M,O]" placeholder="Enter character's sex (H, M, or O)" value="<%=character.getCharacterSex()%>" required>
			            </div>
			            
			            
			         
			            <%}%>
			            <%
			            /*When the value of the session variable is not null, it is because an error happened. So I show the 
			            textarea that I have below with the value of the session variable, that has the fitting error message*/
			            if(error != null){%>
			            	<div class="textAreaInfoError"><%=error%></div>
							<a href="./listCharacters.jsp"><button class="btn btn-info" id="submitButton" type="button">Return to list</button></a>
			            	
			            <%/*Here, if the submit is sent, and the value of the session variable is null, that means that was edited correctly. Then, I show
			            the success message*/
			            }else if(request.getParameter("edit") != null && error == null) {%>
			            	<div class="textAreaInfoSuccesfull"> Character edited successfully!</div>
			            <%}/*When all of this happens, I set the error value null to reset it if another error occurs when the form is sent again*/
			            %>
			            
			            
			            <!-- All the buttons -->

			            	<!-- This button will appear the moment you enter the page. When I press "Confirm", it will edit the character. There 
			            	must not have errors, so if it detects that the session variable is not null, it will not appear -->
			            	<% if(request.getParameter("edit") == null && error == null){ %>
			             		<button class="btn btn-danger " id="submitButton" value="edit" type="submit" name="edit">Confirm</button>
					     	
					     	<!-- When the "Confirm" button is pressed, this one will appear, and it will redirect to the character that you 
					     	edited. The button takes the character's name from this page, and it will send it to "infoCharacter" to show the 
					     	character there -->
					     	<%}else if(request.getParameter("edit") != null && error == null){ %>
					     		<!-- Y cuando le haya dado a confirmar y no haya ningún error le muestro este botón para que pueda ver los detalles de la pelicula -->
					     		<a href="infoCharacter.jsp?characterName=<%=character.getCharacterName()%>"> <button class="btn btn-primary " id="submitButton" type="button">Show character</button></a>
			            	
			            	<%}%>
	            	
			              	

			          </form>
			          <!-- End of contact form -->
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>