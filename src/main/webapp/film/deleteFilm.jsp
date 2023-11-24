<%@page import="com.jacaranda.repository.FilmRepository"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Film</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>	
	<%	
		/*Creo una pelicula nula*/
		Film film = null;
		String error = null;
		try{
			/*Si existe la pelicula que he recogio con el parametro cip que viene de la pagina de info*/
			film = DbRepository.find(Film.class, request.getParameter("cip"));
			if(film == null){
				error = "Error there is no movie with the cip entered";
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
			            <h1>Delete Film</h1>
			          </div>
					
			          <form>
			          <%if(film != null){ /*Coloco este if aqui para que cuando tenga unas pelicula me lo muestre*/ %>
			            <!-- Cip Input -->
			            <div class=" mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Cip</label>
			    			<input type="text" class="form-control" id="cip" name="cip" value='<%=film.getCip()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class=" mb-3">
			                <label for="exampleInputEmail1" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" value="<%=film.getTitleP()%>" readonly required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Production year</label>
			    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" value="<%=film.getYearProduction()%>" readonly required>
			            </div>
			            
			            <!-- Secundary title Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Secundary title</label>
			    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title" value="<%=film.getTitleS()%>" readonly>
			            </div>
			            
			            <!-- Nationality Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Nationality</label>
			    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality" value="<%=film.getNationality()%>" readonly>
			            </div>
			            
			            <!-- Budget Input -->
			            <div class=" mb-3">
							 <label for="exampleInputEmail1" class="form-label">Budget</label>
			    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget" value="<%=film.getBudget()%>" readonly>
			            </div>
			            
			            <!-- Duration Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Duration</label>
			    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration" value="<%=film.getDuration()%>" readonly>
			            </div>
			            <%}%>
			            <%
			           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
			            if(error != null){%>
			            	<div class="textAreaInfoError"><%=error%></div> 
			            <%/*Y aqui si se ha enviado el submit y en valor de la session es nulo significa que se ha borrado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("submit") != null && error == null){%>
			            	<div class="textAreaInfoSuccesfull">Film deleted successfully!</div>
			            <%}
			            %>
			            	
			            <!-- Submit button -->
							<%
							/*Y aqui borro el cine con el cip que hemos recogido */
							if(request.getParameter("delete") == null && request.getParameter("submit") == null && error == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
				            	<button class="btn btn-danger" id="submitButton" type="submit" name="delete">Are you sure you want to delete it?</button>
							<%}else if(request.getParameter("delete") != null){%>
								<!--Aquí cuando le de a borrar, le pongo otro botón para que me confirme que quiere borrar y le doy la opción
								de que volver atrás para que no se realize en borrado -->
								<button class="btn btn-danger" id="submitButton" type="submit" name="submit">Confirm</button>
				            	<a href="./infoFilm.jsp?cip=<%=request.getParameter("cip")%>"><button class="btn btn-primary  " id="submitButton" type="button" name="undo">Undo</button></a>
							<%}else if(error != null){%>
								<a href="./listFilms.jsp"><button class="btn btn-primary" id="submitButton" type="button">Return list</button></a>
							<%}%>
							
							<%if(request.getParameter("submit") != null && error == null){
								FilmRepository.delete(film);%>
								<!-- Una vez que haya confirmado que borra la pelicula borro la pelicual y pongo un botón para que pueda volver a la lista de peliculas
								para confirmar que se ha borrado -->
								<a href="./listFilms.jsp"><button class="btn btn-primary" id="submitButton" type="button">Return list</button></a>
							<%}%>
			          </form>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>