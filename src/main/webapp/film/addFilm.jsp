F<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.exception.FilmException"%>
<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Film</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	try{
		String user = session.getAttribute("user").toString();
		if(!session.getAttribute("role").equals("ADMIN")){
			response.sendRedirect("../signup.jsp");
			return;
		}
	}catch(Exception e){
		response.sendRedirect("../login.jsp");
		return;
	}
	String error = null;
	try{
		/*Compruebo si ya hay alguna pelicula con el cip introducido*/
		if(request.getParameter("cip") != null && DbRepository.find(Film.class, request.getParameter("cip")) != null){
			/*Creo una session de error y le asigno el error correspondiente*/
			error = "Error there is already a film with the cip entered";
		}else{	
			/*Si no hay fallo intento creo una pelicula cuando el formulario se envie*/
			try{
				if(request.getParameter("submit") != null){
					Film film = new Film(request.getParameter("cip"),request.getParameter("titleF")
							,request.getParameter("productionYear")
							,request.getParameter("titleS"),request.getParameter("nationality")
							,request.getParameter("budget")
							,request.getParameter("duration"));
					/*Añado la pelicula la base de datos si se crea la pelicula con éxito*/
					DbRepository.addEntity(film);
			}
			}catch(FilmException e){
				//Cuando se produzca un error le asigno el error a la session de error
				error =  e.getMessage();
			}
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
	            <h1>Add Film</h1>
	          </div>
	
	          <form method="get">
	
	            <!-- Cip Input -->
	            <div class=" mb-3">
	    			<label for="cip" class="form-label">Cip</label>
	    			<input type="text" class="form-control" id="cip" name="cip" placeholder="Enter cip" required >
	            </div>
	
	            <!-- Film title Input -->
	            <div class=" mb-3">
	                <label for="titleF" class="form-label">Film title</label>
	    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" required>
	            </div>
	
	            <!-- Production year Input -->
	            <div class=" mb-3">
					<label for="productionYear" class="form-label">Production year</label>
					<!-- La primera pelicula de la historia hecha en 1895 asi que un minimo de 1890 es suficiente-->
	    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" required min="1890">
	            </div>
	            
	            <!-- Secundary title Input -->
	            <div class=" mb-3">
					<label for="titleS" class="form-label">Secundary title</label>
	    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title">
	            </div>
	            
	            <!-- Nationality Input -->
	            <div class=" mb-3">
					<label for="nationality" class="form-label">Nationality</label>
	    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality">
	            </div>
	            
	            <!-- Budget Input -->
	            <div class=" mb-3">
					 <label for="budget" class="form-label">Budget</label>
	    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget" min="1">
	            </div>
	            
	            <!-- Duration Input -->
	            <div class=" mb-3">
					<label for="duration" class="form-label">Duration</label>
	    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration" min="1">
	            </div>
	            <%
	           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
	           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
	            if(error != null){%>
	            	<div class="textAreaInfoError " ><%=error%></div>
	            <%/*Y aqui si se ha enviado el submit y en valor de la session es nulo significa que se ha creado correctamente, entoces muestro
	            el mensaje de éxito*/
	            }else if(request.getParameter("submit") != null && error == null){%>
	            	<div class="textAreaInfoSuccesfull " >Film created successfully!</div>
	            <%} /*Cuando pase todo esto dejo el error en nulo para que se reinicie por si ocurre otro error cuando envíe de nuevo el formulario */
	            %>
	            <!-- Submit button -->
              	<button class="btn btn-success " id="submitButton" type="submit" name="submit">Save</button>
              	<%if(request.getParameter("submit") != null && error == null){%>
			     	<!-- Cuando añada la pelicula sin ningún error pongo la opción para que pueda ver la pelicula recién creada -->
			     	<a href="infoFilm.jsp?cip=<%=request.getParameter("cip")%>"><button class="btn btn-primary" id="submitButton" type="button">Show film</button></a>
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