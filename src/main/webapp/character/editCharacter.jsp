<%@page import="com.jacaranda.exception.CharacterException"%>
<%@page import="com.jacaranda.model.Character"%>
<%@page import="com.jacaranda.repository.CharacterRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Character</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>


<body>
	
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
		<%
		
		Character c = null;
		
		/*I check if the character that I am going to edit exists*/
		if(CharacterRepository.getCharactersNames().contains(request.getParameter("characterName"))){
			
			/*I obtain the character with the character's name that I received*/
			c = CharacterRepository.getCharacter(request.getParameter("characterName"));
			
			if(request.getParameter("edit") != null){
				
				/*When I push the edit button, I create a new character with the new data*/
				try{
					
					c = new Character(request.getParameter("characterName"),
							request.getParameter("characterNationality"),
							request.getParameter("characterSex"));
					/*I call the method of the repository that edits the character*/
					CharacterRepository.editCharacter(c);%>
				
				<%}catch(CharacterException e){
					/*If an error happens I create a session variable that contains 
					the message to check if there is an error and show it below*/
					session.setAttribute("error", e.getMessage());
				}
			}
		%>
		
		<%
		/*If not a single character exists with the name of the parameter, 
		I assign to the session variable an error message saying that there is no character with that name*/
		}else{
			session.setAttribute("error", "Error there is no character with such a name");
		}%>
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <div class="h1 fw-light">Edit Character</div>
			          </div>
					<%if(c != null){/*If the character that is introduced is not null, I show the information of the character*/ %>
			          <form>
			            <!-- Character Name Input -->
			            <div class="form-floating mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Character's name</label>
			    			<input type="text" class="form-control" id="characterName" name="characterName" value='<%=c.getCharacterName()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Character's nationality</label>
			    			<input type="text" class="form-control" id="characterNationality" name="characterNationality" placeholder="Enter Character Nationality" value="<%=c.getCharacterNationality()%>" required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Character's sex</label>
			    			<input type="text" step="1" class="form-control" id="characterSex" name="characterSex" placeholder="Enter Character Sex" value="<%=c.getCharacterSex()%>" required>
			            </div>
			            
			            
			         
			            <%}%>
			            <%
			            /*When the value of the session variable is not null, it is because an error happened. So I show the 
			            textarea that I have below with the value of the session variable, that has the fitting error message*/
			            if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
			            <%/*Here, if the submit is sent, and the value of the session variable is null, that means that was edited correctly. Then, I show
			            the success message*/
			            }else if(request.getParameter("edit") != null && session.getAttribute("error") == null) {%>
			            	<textarea class="textAreaInfoSuccesfull ml-25" readonly> Character edited successfully!</textarea>
			            <%}session.removeAttribute("error"); /*When all of this happens, I set the error value null to reset it if another error occurs when the form is sent again*/
			            %>
			            
			            
			            
			            <!-- All the buttons -->
			            <div class="d-grid">
			            	
			            	<!-- This button will appear the moment you enter the page. When I press "Confirm", it will edit the character. There 
			            	must not have errors, so if it detects that the session variable is not null, it will not appear -->
			            	<% if(request.getParameter("edit") == null && session.getAttribute("error") == null){ %>
			             		<button class="btn btn-danger btn-lg" id="submitButton" value="edit" type="submit" name="edit">Confirm</button></a>
					     	
					     	<!-- When the "Confirm" button is pressed, this one will appear, and it will redirect to the character that you 
					     	edited. The button takes the character's name from this page, and it will send it to "infoCharacter" to show the 
					     	character there -->
					     	<%}else if(request.getParameter("edit") != null && session.getAttribute("error") == null){ %>
					     		<!-- Y cuando le haya dado a confirmar y no haya ningún error le muestro este botón para que pueda ver los detalles de la pelicula -->
					     		<a href="infoCharacter.jsp?characterName=<%=c.getCharacterName()%>"> <button class="btn btn-primary btn-lg" id="submitButton" type="button">Show character</button></a>
			            	
			            	<%}session.removeAttribute("error");%>
			              	
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