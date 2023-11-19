<%@page import="com.jacaranda.repository.FilmRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Info Film</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-primary">
	  <a class="navbar-brand text-white" href="../index.jsp">Home</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link text-white" href="addFilm.jsp">Add film</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="listFilms.jsp">List films</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././character/addCharacter.jsp">Add character</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././character/listCharacters.jsp">List characters</a>
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
		Film f = null; 
		if(FilmRepository.getCipFilms().contains(request.getParameter("cip"))){
			f = FilmRepository.getFilm(request.getParameter("cip"));
		}else{
			session.setAttribute("error", "Error there is no task with the cip entered");
		}%>
	<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <div class="h1 fw-light">Info Film</div>
			          </div>
			          <form>
			          <%if(f != null){ /*Esto lo pongo porque si no hay peliculas con el cip 
			        	  que hemos recuperado no salga el formulario con los datos y solo salga el mensaje de error*/ %>
			            <!-- Cip Input -->
			            <div class="form-floating mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Cip</label>
			    			<input type="text" class="form-control" id="cip" name="cip" value='<%=f.getCip()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" value="<%=f.getTitleP()%>" readonly required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Production year</label>
			    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" value="<%=f.getYearProduction()%>" readonly required>
			            </div>
			            
			            <!-- Secundary title Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Secundary title</label>
			    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title" value="<%=f.getTitleS()%>" readonly>
			            </div>
			            
			            <!-- Nationality Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Nationality</label>
			    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality" value="<%=f.getNationality()%>" readonly>
			            </div>
			            
			            <!-- Budget Input -->
			            <div class="form-floating mb-3">
							 <label for="exampleInputEmail1" class="form-label">Budget</label>
			    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget" value="<%=f.getBudget()%>" readonly>
			            </div>
			            
			            <!-- Duration Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Duration</label>
			    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration" value="<%=f.getDuration()%>" readonly>
			            </div>
			            

			            <!-- Submit button -->
			            <div class="d-grid">
			              	<button class="btn btn-primary btn-lg" id="submitButton" value="edit" type="submit" name="edit">Edit</button>
			              	<button class="btn btn-primary btn-lg" id="submitButton" value="delete" type="submit" name="delete">Delete</button>
			            </div>
			          </form>
			          <%}%>
			          <form method="post" action="./filmCharacters.jsp"><button class="btn btn-primary btn-lg" id="submitButton" name="filmCharacters" value="<%=f.getCip()%>">See the repart</button></form>
			          <%
			           	/*Cuando el valor de la sessi�n no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesi�n que ser� el mensaje de error correspondiente*/
			      		if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
			            	<a href="./listFilms.jsp"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Return list</button></a>
			       		<%}session.removeAttribute("error");%>
			          <!-- End of contact form -->
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
		<%
			if(request.getParameter("edit") != null){
				/*Cuando le de a editar la pelicula que quiere lo redirijo a la p�gina de 
				editar pasandole el cip para que pueda motrar la pelicula en la otra p�gina*/
				response.sendRedirect("editFilm.jsp?cip="+f.getCip());
			}else if(request.getParameter("delete") != null){
				/*Cuando le de a borrar la pelicula que quiere lo redirijo a la p�gina de 
				editar pasandole el cip para que pueda motrar la pelicula en la otra p�gina*/
				response.sendRedirect("deleteFilm.jsp?cip="+f.getCip());
			}
		%>
</body>
</html>