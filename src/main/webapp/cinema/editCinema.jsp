<%@page import="com.jacaranda.exception.CinemaException"%>
<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Cinema</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
		<%@include file="../nav.jsp"%>
		<%
		Cinema cinema = null;
		String error = null;
		try{
			//Busco un cine con el parametro que nos ha pasado
			cinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
			if(cinema != null){ //Si el cine no es nulo
				if(request.getParameter("edit") != null){//Y le de al botón de editar
					try{
						//Actualizo los datos del cine que hemos recuperado
						cinema.setCinema(request.getParameter("cinema"));
						cinema.setAddressCinema(request.getParameter("cinemaAddress"));
						cinema.setCityCinema(request.getParameter("cinemaCity"));
						//Y lo edito
						DbRepository.editEntity(cinema);
					}catch(CinemaException e){
						error = e.getMessage(); //Si hay algún error lo almaceno el la variable de error
					}
				}
			}else{
				error = "Error there is no cinema with the name entered"; //Si el cine es nulo guardo el error en la variable
			}
		}catch(Exception e){
			//En el caso de que haya un error en la base de datos lo redirecciono a la base de datos con el error correspondiente
			response.sendRedirect("../error.jsp?msg=Failed to connect to database"); 
			return;
		}%>	
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <h1>Edit Film</h1>
			          </div>
					<%if(cinema != null){ //Si el cine no es nulo muestro los campos%>
			          <form>
		            	<div class=" mb-3">
			   				<label for="cinema" class="form-label">Cinema</label>
			   				<input type="text" class="form-control" id="cinema" name="cinema" value="<%=cinema.getCinema()%>" required readonly>
			           </div>
			
			           <div class=" mb-3">
			           		<label for="cinemaCity" class="form-label">Cinema city</label>
			   				<input type="text" class="form-control" id="cinemaCity" name="cinemaCity" value="<%=cinema.getCityCinema()%>" required>
			           </div>
			
			           <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Cinema address</label>
			   				<input type="text" step="1" class="form-control" id="cinemaAddress" name="cinemaAddress" value="<%=cinema.getAddressCinema()%>" required>
			           </div>
			            <%}%>
			            <%
			           	/*Cuando el valor de la variable no se nulo es que se ha producido un error entonces muestro
			           	el div que tengo abajo con el valor de la variable que será el mensaje de error correspondiente*/
			            if(error != null){%>
			            	<div class="textAreaInfoError " ><%=error%></div>
			            	<a href="listCinemas.jsp"><button class="btn btn-primary " id="submitButton" type="button">Retry</button></a>
			            <%/*Y aqui si se ha enviado el edit y en valor de la variable es nulo significa que se ha editado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("edit") != null && error == null){%>
			            	<div class="textAreaInfoSuccesfull " >Cinema edited successfully!</div> 
			            <%} /*Cuando pase todo esto dejo el error en nulo para que se reinicie por si ocurre otro error cuando envíe de nuevo el formulario */
			            %>
			           
			            <!-- Submit button -->
			             	<%if(request.getParameter("edit") == null && error == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
			             		<button class="btn btn-danger " id="submitButton" value="edit" type="submit" name="edit">Confirm</button>
					     	<%}else if(request.getParameter("edit") != null && error == null){ %>
					     		<a href="infoCinema.jsp?cinema=<%=request.getParameter("cinema")%>"><button class="btn btn-primary " id="submitButton" type="button">Show Cinema</button></a>
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