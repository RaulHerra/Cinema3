<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Film</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>	
	<%	
		/*Creo una pelicula nula*/
		Film f = null; 
		try{
			/*Si existe la pelicula que he recogio con el parametro cip que viene de la pagina de info*/
			if(DbRepository.find(Film.class, request.getParameter("cip")) != null){
				/*Recupero la pelicula que tiene el cip introducido*/
				f = DbRepository.find(Film.class, request.getParameter("cip"));
			}else{//Si no hay peliculas con el cip que he recogido le asigno a la session el mensaje de error
				session.setAttribute("error", "Error there is no movie with the cip entered");
			}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
			return;
		}%>
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <div class="h1 fw-light">Delete Film</div>
			          </div>
					
			          <form>
			          <%if(f != null){ /*Coloco este if aqui para que cuando tenga unas pelicula me lo muestre*/ %>
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
			            <%}%>
			            <%
			           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
			            if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
			            <%/*Y aqui si se ha enviado el submit y en valor de la session es nulo significa que se ha borrado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
			            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Film deleted successfully!</textarea>
			            <%}
			            %>
			            <!-- Submit button -->
			            <div class="d-grid">
							<%
							/*Y aqui borro el cine con el cip que hemos recogido */
							if(request.getParameter("delete") == null && request.getParameter("submit") == null && session.getAttribute("error") == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
				            	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="delete">Are you sure you want to delete it?</button>
							<%}else if(request.getParameter("delete") != null){%>
								<!--Aquí cuando le de a borrar, le pongo otro botón para que me confirme que quiere borrar y le doy la opción
								de que volver atrás para que no se realize en borrado -->
								<button class="btn btn-danger btn-lg" id="submitButton" type="submit" name="submit">Confirm</button>
				            	<a href="./infoFilm.jsp?cip=<%=request.getParameter("cip")%>"><button class="btn btn-primary btn-lg" id="submitButton" type="button" name="undo">Undo</button></a>
							<%}else if(session.getAttribute("error") != null){%>
								<a href="./listFilms.jsp"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Return list</button></a>
							<%}%>
							
							<%if(request.getParameter("submit") != null){
								DbRepository.deleteEntity(f);%>
								<!-- Una vez que haya confirmado que borra la pelicula borro la pelicual y pongo un botón para que pueda volver a la lista de peliculas
								para confirmar que se ha borrado -->
								<a href="./listFilms.jsp"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Return list</button></a>
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