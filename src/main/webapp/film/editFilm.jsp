<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.exception.FilmException"%>
<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.repository.FilmRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Film</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
		<%@include file="../nav.jsp"%>
		<%
		Film f = null;
		try{
			/*Compruebo que existe la pelicula que quiere editar*/
			if(DbRepository.find(Film.class, request.getParameter("cip")) != null){
				/*Obtengo la pelicula con su cip que lo he recogido de la lista*/
				f = DbRepository.find(Film.class, request.getParameter("cip"));
				if(request.getParameter("edit") != null){
					/*Cuando le de al boton de editar, actualizo la pelicula con los nuevos datos introducidos*/
					try{
						f = new Film(request.getParameter("cip"),request.getParameter("titleF")
								,request.getParameter("productionYear")
								,request.getParameter("titleS"),request.getParameter("nationality")
								,request.getParameter("budget")
								,request.getParameter("duration"));
						/*Llamo al metodo del repositorio que edita la pelicula*/
						DbRepository.editEntity(f);
					}catch(FilmException e){
						/*Si ocurre algun error creo una session que almacena el mensaje para despues
							* comprobar si hay error y mostrarlo más abajo*/
						session.setAttribute("error", e.getMessage());
					}
				}
			/*Si no existe ninguna pelicula con el cip que le hemos pasado por parametro a la session de error
			 * le asigno el error de que no hay niguna pelicula con ese cip*/
			}else{
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
			            <div class="h1 fw-light">Edit Film</div>
			          </div>
					<%if(f != null){/*Si el cine que hemos introducido es diferente a null muestro la informacion del cine*/ %>
			          <form>
			            <!-- Cip Input -->
			            <div class="form-floating mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Cip</label>
			    			<input type="text" class="form-control" id="cip" name="cip" value='<%=f.getCip()%>'readonly required>
			            </div>
			
			            <!-- Film title Input -->
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="titleF" name="titleF" placeholder="Enter Film Title" value="<%=f.getTitleP()%>" required>
			            </div>
			
			            <!-- Production year Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Production year</label>
			    			<input type="number" step="1" class="form-control" id="productionYear" name="productionYear" placeholder="Enter Production Year" value="<%=f.getYearProduction()%>" required>
			            </div>
			            
			            <!-- Secundary title Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Secundary title</label>
			    			<input type="text" class="form-control" id="titleS" name="titleS" placeholder="Enter Secundary Title" value="<%=f.getTitleS()%>">
			            </div>
			            
			            <!-- Nationality Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Nationality</label>
			    			<input type="text" class="form-control" id="nationality" name="nationality" placeholder="Enter Nationality" value="<%=f.getNationality()%>">
			            </div>
			            
			            <!-- Budget Input -->
			            <div class="form-floating mb-3">
							 <label for="exampleInputEmail1" class="form-label">Budget</label>
			    			<input type="number" step="1" class="form-control" id="budget" name="budget" placeholder="Enter Budget" value="<%=f.getBudget()%>">
			            </div>
			            
			            <!-- Duration Input -->
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Duration</label>
			    			<input type="number" step="1" class="form-control" id="duration" name="duration" placeholder="Enter Duration" value="<%=f.getDuration()%>">
			            </div>
			            <%}%>
			            <%
			           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
			            if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
			            	<!-- Este botón no es necesario, pero si me da algún error que no se quede solo con el error, le he puesto un botón para 
			            	que reintente editar la pelicula si quiere-->
			            	<div class="d-grid">
			            		<a href="editFilm.jsp?cip=<%=request.getParameter("cip")%>"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Retry</button></a>
			            	</div>
			            <%/*Y aqui si se ha enviado el edit y en valor de la session es nulo significa que se ha editado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("edit") != null && session.getAttribute("error") == null){%>
			            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Film edited successfully!</textarea>
			            <%} /*Cuando pase todo esto dejo el error en nulo para que se reinicie por si ocurre otro error cuando envíe de nuevo el formulario */
			            %>
			            <!-- Submit button -->
			            <div class="d-grid">
			             	<%if(request.getParameter("edit") == null && session.getAttribute("error") == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
			             		<button class="btn btn-danger btn-lg" id="submitButton" value="edit" type="submit" name="edit">Confirm</button></a>
					     	<%}else if(request.getParameter("edit") != null && session.getAttribute("error") == null){ %>
					     		<!-- Y cuando le haya dado a confirmar y no haya ningún error le muestro este botón para que pueda ver los detalles de la pelicula -->
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