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
<title>Film's info</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%		
		Film film = null; 
		String error = null;
		try{
			
			if( request.getParameter("cip") != null){
				film = DbRepository.find(Film.class, request.getParameter("cip"));
				if(film == null){
					error = "Error there is no film with the cip entered";
				}
			}else{
				error = "Not cip found in the uri";

			}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Failed to connect to database");
			return;
		}
%>
	<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <h1>Film's info</h1>
			          </div>
			          <form>
			          <%if(film != null){ /*Esto lo pongo porque si no hay peliculas con el cip 
			        	  que hemos recuperado no salga el formulario con los datos y solo salga el mensaje de error*/ %>
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
			            

			          </form>
			          <%}%>
				          <%
				      		if(error!= null){%>
				            	<div class="textAreaInfoError" ><%=error%></div>
				       		<%}%>
				            	<a href="./listFilms.jsp"><button class="btn btn-info" id="submitButton" type="button">Return list</button></a>
			          <% if (film != null && session.getAttribute("userRole").equals("ADMIN")) { %>
			              	<a href="editFilm.jsp?cip=<%=film.getCip()%>"><button class="btn btn-warning "  type="button" name="edit">Edit</button></a>
			              	<a href= "deleteFilm.jsp?cip=<%=film.getCip()%>"><button class="btn btn-danger "  type="submit" name="delete">Delete</button></a>
					  <%} %>
					  	<a href="./castCharacters.jsp?filmCharacters=<%=film.getCip()%>"><button class="btn btn-primary " id="submitButton" value="<%=film.getCip()%>" name="filmCharacters">Cast</button></a>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>