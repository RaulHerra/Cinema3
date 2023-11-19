<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.exception.FilmException"%>
ç<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Film</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	try{
		/*Compruebo si ya hay alguna pelicula con el cip introducido*/
		if(request.getParameter("cip") != null && DbRepository.find(Film.class, request.getParameter("cip")) != null){
			/*Creo una session de error y le asigno el error correspondiente*/
			session.setAttribute("error", "Error there is already a film with the cip entered");
		}else{	
			/*Si no hay fallo intento creo una pelicula cuando el formulario se envie*/
			try{
				if(request.getParameter("submit") != null){
					Film f = new Film(request.getParameter("cip"),request.getParameter("titleF")
							,request.getParameter("productionYear")
							,request.getParameter("titleS"),request.getParameter("nationality")
							,request.getParameter("budget")
							,request.getParameter("duration"));
					/*Añado la pelicula la base de datos si se crea la pelicula con éxito*/
					DbRepository.addEntity(f);
			}
			}catch(FilmException e){
				//Cuando se produzca un error le asigno el error a la session de error
				session.setAttribute("error", e.getMessage());
			}
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
	            <div class="h1 fw-light">Add Film</div>
	          </div>
	
	          <form method="get">
	
	            <!-- Cip Input -->
	            <div class="form-floating mb-3">
	    			<label for="exampleInputEmail1" class="form-label">Cip</label>
	    			<input type="text" class="form-control" id="cip" name="cip" placeholder="Enter cip" required>
	            </div>
	
	            <!-- Film title Input -->
	            <div class="form-floating mb-3">
	                <label for="exampleInputEmail1" class="form-label">Film title</label>
	    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" required>
	            </div>
	
	            <!-- Production year Input -->
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Production year</label>
	    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" required>
	            </div>
	            
	            <!-- Secundary title Input -->
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Secundary title</label>
	    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title">
	            </div>
	            
	            <!-- Nationality Input -->
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Nationality</label>
	    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality">
	            </div>
	            
	            <!-- Budget Input -->
	            <div class="form-floating mb-3">
					 <label for="exampleInputEmail1" class="form-label">Budget</label>
	    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget">
	            </div>
	            
	            <!-- Duration Input -->
	            <div class="form-floating mb-3">
					<label for="exampleInputEmail1" class="form-label">Duration</label>
	    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration">
	            </div>
	            <%
	           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
	           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
	            if(session.getAttribute("error") != null){%>
	            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
	            <%/*Y aqui si se ha enviado el submit y en valor de la session es nulo significa que se ha creado correctamente, entoces muestro
	            el mensaje de éxito*/
	            }else if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
	            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Film created successfully!</textarea>
	            <%} /*Cuando pase todo esto dejo el error en nulo para que se reinicie por si ocurre otro error cuando envíe de nuevo el formulario */
	            %>
	            <!-- Submit button -->
	            <div class="d-grid">
	              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="submit">Save</button>
	              	<%if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
				     	<!-- Cuando añada la pelicula sin ningún error pongo la opción para que pueda ver la pelicula recién creada -->
				     	<a href="infoFilm.jsp?cip=<%=request.getParameter("cip")%>"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Show film</button></a>
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