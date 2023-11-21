<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.model.Character"%>
<%@page import="com.jacaranda.model.Task"%>
<%@page import="com.jacaranda.model.Work"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Character to Film</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

<%@include file="../nav.jsp"%>

<%

	List<Film>films = null;
	List<Character>characters = null;
	List<Task>tasks = null;
	
	Work w = null;
	String error = null;
	try{
		
		films = DbRepository.findAll(Film.class);
		characters = DbRepository.findAll(Character.class);
		tasks = DbRepository.findAll(Task.class);
		
		String agregate = request.getParameter("submit");
		
		if(agregate!=null){
			
			Film film = DbRepository.find(Film.class, request.getParameter("films"));
			Character character = DbRepository.find(Character.class, request.getParameter("characters"));
			Task task = DbRepository.find(Task.class, request.getParameter("task"));
			
			if(film==null  || character==null || task==null){
				error = "Enter a valid movie, character or task.";
			}else{
				w = new Work(character,film,task);
			}
			
			if(DbRepository.find(Work.class, w) != null) error = "Error: the character with the entered task already exists.";
			else{
				DbRepository.addEntity(w);				
			}
			
		}
		
	}catch(Exception e){
		e.getMessage();
	}

%>
<div class="container px-5 my-5">
  <div class="row justify-content-center">
	<div class="col-lg-8">
		<div class="card border-0 rounded-3 shadow-lg">
			<div class="card-body p-4">
				<div class="text-center">
					<h1>Add Character to Film</h1>
				</div>
					<form>
					  <div class="mb-3">
					    <label for="films" class="form-label">Films</label> 
					    <div class="mb-3">
					      <select id="films" name="films" class="form-select" required>
					      	<option disabled selected>-- Select the film --</option>
					      	<%for(Film f : films){ %>
					        	<option value="<%=f.getCip()%>"><%=f.getTitleP() %></option>
					        <%} %>
					      </select>
					    </div>
					  </div>
					  <div class="mb-3">
					    <label for="characters" class="form-label">Characters</label> 
					    <div class="mb-3">
					      <select id="characters" name="characters" class="form-select" required>
					   		<option disabled selected>-- Select character --</option>
					        <%for(Character c : characters){ %>
					        	<option value="<%=c.getCharacterName()%>"><%=c.getCharacterName() %></option>
					        <%} %>
					      </select>
					    </div>
					  </div>
					  <div class="mb-3">
					    <label for="task" class="form-label">Tasks</label> 
					    <div class="mb-3">
					      <select id="task" name="task" class="form-select" required>
					      	<option disabled selected>-- Select task --</option>
					      	<%for(Task t : tasks){ %>
					        	<option value="<%=t.getTask()%>"><%=t.getTask()%></option>
					        <%} %>
					      </select>
					    </div>
					  </div>
			          <%
				        /*Cuando el valor de la sessi�n no se nulo es que se ha producido un error entonces muestro
				        el textarea que tengo abajo con el valor de la sesi�n que ser� el mensaje de error correspondiente*/
				      	if(error != null){%>
				            <div class="textAreaInfoError" ><%=error%></div>
				       	<%}else if(request.getParameter("submit") != null && error == null){%>
					   		<div class="textAreaInfoSuccesfull ">Work created successfully! </div>
				       <%}%>
				         <!-- End of contact form -->
					  <div class="mb-3">
					      <button name="submit" type="submit" class="btn btn-success">Save</button>
					  </div>
					</form>
			   </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>