<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Info Film</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%		
		Film f = null; 
		try{
			
			if( request.getParameter("cip") != null){
				f = DbRepository.find(Film.class, request.getParameter("cip"));
				if(f == null){
					session.setAttribute("error", "Error there is no task with the cip entered");
				}
			}else{
				session.setAttribute("error", "Not cip found in the uri");

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
			            <h1>Info Film</h1>
			          </div>
			          <form>
			          <%if(f != null){ /*Esto lo pongo porque si no hay peliculas con el cip 
			        	  que hemos recuperado no salga el formulario con los datos y solo salga el mensaje de error*/ %>
			            <!-- Cip Input -->
			            <div class=" mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Cip</label>
			    			<input type="text" class="form-control" id="cip" name="cip" value='<%=f.getCip()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class=" mb-3">
			                <label for="exampleInputEmail1" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" value="<%=f.getTitleP()%>" readonly required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Production year</label>
			    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" value="<%=f.getYearProduction()%>" readonly required>
			            </div>
			            
			            <!-- Secundary title Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Secundary title</label>
			    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title" value="<%=f.getTitleS()%>" readonly>
			            </div>
			            
			            <!-- Nationality Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Nationality</label>
			    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality" value="<%=f.getNationality()%>" readonly>
			            </div>
			            
			            <!-- Budget Input -->
			            <div class=" mb-3">
							 <label for="exampleInputEmail1" class="form-label">Budget</label>
			    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget" value="<%=f.getBudget()%>" readonly>
			            </div>
			            
			            <!-- Duration Input -->
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Duration</label>
			    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration" value="<%=f.getDuration()%>" readonly>
			            </div>
			            

			            <!-- Submit button -->
			              	<button class="btn btn-warning " id="submitButton" value="edit" type="submit" name="edit">Edit</button>
			              	<button class="btn btn-danger " id="submitButton" value="delete" type="submit" name="delete">Delete</button>
			          </form>
			          <%}%>
			          <%
			           	/*Cuando el valor de la sessi�n no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesi�n que ser� el mensaje de error correspondiente*/
			      		if(session.getAttribute("error") != null){%>
			            	<div class="textAreaInfoError" ><%=session.getAttribute("error")%></div>
			            	<a href="./listFilms.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
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