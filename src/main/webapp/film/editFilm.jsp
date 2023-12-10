<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.exception.FilmException"%>
<%@page import="com.jacaranda.model.Film"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Film</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
		<%@include file="../nav.jsp"%>
		<%
		try{
			String user = session.getAttribute("username").toString();
			if(!session.getAttribute("userRole").equals("ADMIN")){
				response.sendRedirect("../index.jsp");
				return;
			}
		}catch(Exception e){
			response.sendRedirect("../login.jsp");
			return;
		}
		Film film = null;
		String error = null;
		try{
			/*Compruebo que existe la pelicula que quiere editar*/
			film = DbRepository.find(Film.class, request.getParameter("cip"));
			if(film != null){
				if(request.getParameter("edit") != null){
					/*Cuando le de al boton de editar, actualizo la pelicula con los nuevos datos introducidos*/
					try{
						film = new Film(request.getParameter("cip"),request.getParameter("titleF")
								,request.getParameter("productionYear")
								,request.getParameter("titleS"),request.getParameter("nationality")
								,request.getParameter("budget")
								,request.getParameter("duration"));
						/*Llamo al metodo del repositorio que edita la pelicula*/
						DbRepository.editEntity(film);
					}catch(FilmException e){
						/*Si ocurre algun error creo una session que almacena el mensaje para despues
							* comprobar si hay error y mostrarlo más abajo*/
						error = e.getMessage();
					}
				}
			/*Si no existe ninguna pelicula con el cip que le hemos pasado por parametro a la session de error
			 * le asigno el error de que no hay niguna pelicula con ese cip*/
			}else{
				error = "Error there is no film with the cip entered";
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
			            <h1>Edit Film</h1>
			          </div>
					<%if(film != null){/*Si el cine que hemos introducido es diferente a null muestro la informacion del cine*/ %>
			          <form>
			            <!-- Cip Input -->
			            <div class="  mb-3">
			    			<label for="cip" class="form-label">Cip</label>
			    			<input type="text" class="form-control" id="cip" name="cip" value='<%=film.getCip()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class="  mb-3">
			                <label for="titleF" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" value="<%=film.getTitleP()%>" required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class="  mb-3">
							<label for="productionYear" class="form-label">Production year</label>
			    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" value="<%=film.getYearProduction()%>" required min="1890">
			            </div>
			            
			            <!-- Secundary title Input -->
			            <div class="  mb-3">
							<label for="titleS" class="form-label">Secundary title</label>
			    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title" value="<%=film.getTitleS()%>">
			            </div>
			            
			            <!-- Nationality Input -->
			            <div class="  mb-3">
							<label for="nationality" class="form-label">Nationality</label>
			    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality" value="<%=film.getNationality()%>">
			            </div>
			            
			            <!-- Budget Input -->
			            <div class="  mb-3">
							 <label for="budget" class="form-label">Budget</label>
			    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget" value="<%=film.getBudget()%>" min="1">
			            </div>
			            
			            <!-- Duration Input -->
			            <div class="  mb-3">
							<label for="duration" class="form-label">Duration</label>
			    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration" value="<%=film.getDuration()%>" min="1">
			            </div>
			            <%}%>
			            <%
			           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
			            if(error != null){%>
			            	<div class="textAreaInfoError " ><%=error%></div>
			            	<!-- Este botón no es necesario, pero si me da algún error que no se quede solo con el error, le he puesto un botón para 
			            	que reintente editar la pelicula si quiere-->
			            		<a href="listFilms.jsp"><button class="btn btn-info " id="submitButton" type="button">Return to list</button></a>
			            <%/*Y aqui si se ha enviado el edit y en valor de la session es nulo significa que se ha editado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("edit") != null && error == null){%>
			            	<div class="textAreaInfoSuccesfull " >Film edited successfully!</div> 
			            <%} /*Cuando pase todo esto dejo el error en nulo para que se reinicie por si ocurre otro error cuando envíe de nuevo el formulario */
			            %>
			           
			            <!-- Submit button -->
			             	<%if(request.getParameter("edit") == null && error == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
			             		<button class="btn btn-danger " id="submitButton" value="edit" type="submit" name="edit">Confirm</button>
					     	<%}else if(request.getParameter("edit") != null && error == null){ %>
					     		<!-- Y cuando le haya dado a confirmar y no haya ningún error le muestro este botón para que pueda ver los detalles de la pelicula -->
					     		<a href="infoFilm.jsp?cip=<%=request.getParameter("cip")%>"><button class="btn btn-primary " id="submitButton" type="button">Show film</button></a>
			            	<%}%>	
			          </form>

			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>