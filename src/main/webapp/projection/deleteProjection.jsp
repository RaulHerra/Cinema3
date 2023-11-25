<%@page import="com.jacaranda.exception.ProjectionException"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.model.Projection"%>
<%@page import="com.jacaranda.model.Room"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit projection</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%	
		Projection projection = null;
		Cinema cinema = null; 
		Film film = null;
		Room room = null;
		String error = null;
		Date premiereDate = null;
		
		try{
			//Busco un cine con el parametro que nos ha pasado
			String cinemaParam = request.getParameter("cinema");
			String roomParam = request.getParameter("room");
			String filmParam = request.getParameter("film");
			
			try{
				premiereDate = Date.valueOf(request.getParameter("premiereDate"));
			}catch(Exception e){
				error = "Error Premiere Date not valid";
			}
			
			
			if(filmParam != null){
				film = DbRepository.find(Film.class,filmParam);					
			}else{
				error = "Error film is empty";
			}
			
			if(cinemaParam != null){
				 cinema = DbRepository.find(Cinema.class, cinemaParam);
			}else{
				error = "Error cinema  is empty";
			}
			
			try{
				int roomParamInt = Integer.valueOf(roomParam);
				if(cinema != null){
					room = new Room(cinema,roomParamInt,23);					
				}else{
					error = "cinema not valid";
				}
			}catch(Exception e){
				error = "Error room number not valid";
			}
			
			if(room != null)room = DbRepository.find(Room.class, room);				
			
			
			if(error == null){
				Projection projectionFind = null;
				
				try{
					 if(film != null)projectionFind = new Projection(room,film,premiereDate);
					 else error = "film not valid";
				}catch(Exception e){
					error = e.getMessage();
				}
				
				if(projectionFind != null){
					projection = DbRepository.find(Projection.class,projectionFind);
					if(projection == null) error = "projection not found";
				}
			}
		}catch(Exception e){
			//En el caso de que haya un error en la base de datos lo redirecciono a la base de datos con el error correspondiente
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
			            <h1>Delete Proyection</h1>
			          </div>
			          <form>
			          <%if(projection != null){ //Si la proyeccion no es nula muestro los campos%>
						<div class=" mb-3">
							<label for="cinema" class="form-label">Cinema</label>
						   <input type="text" class="form-control" id="cinema" name="cinema" value="<%=request.getParameter("cinema")%>" required readonly>
					 </div>

			            <div class=" mb-3">
			    			<label for="roomNumber" class="form-label">Room number</label>
			    			<input type="text" class="form-control" id="roomNumber" name="room" value='<%=request.getParameter("room")%>'readonly required>
			            </div>
			
			            <div class=" mb-3">
			                <label for="cinemaCity" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="filmTitle" name="film" value="<%=request.getParameter("film")%>" readonly required>
			            </div>
			
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Premiere date</label>
			    			<input type="text" step="1" class="form-control" id="premiereDate" name="premiereDate" readonly value="<%=premiereDate%>" readonly required>
			            </div>
			            
						<div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Premiere days</label>
			    			<input type="text" step="1" class="form-control" id="premiereDay" name="premiereDay" readonly value="<%=projection.getPremiereDays()%>"  required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Spectators</label>
			    			<input type="text" step="1" class="form-control" id="spectators" name="spectators" readonly value="<%=projection.getSpectators()%>"  required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Income</label>
			    			<input type="text" step="1" class="form-control" id="income" name="income" readonly value="<%=projection.getIncome()%>"  required>
			            </div>
			            
			          <%}%>
			            
			            <!-- Submit button -->
			            <%if(error != null){%>
			            	<div class="textAreaInfoError " ><%=error%></div> 
			            <%/*Y aqui si se ha enviado el submit y en valor de la session es nulo significa que se ha borrado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("submit") != null && error == null){%>
			            	<div class="textAreaInfoSuccesfull " >Projection deleted successfully!</div> 
			            <%}
			            %>
			            	
			            <!-- Submit button -->
							<%
							if(request.getParameter("delete") == null && request.getParameter("submit") == null && error == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
				            	<button class="btn btn-danger" id="submitButton" type="submit" name="delete">Are you sure you want to delete it?</button>
							<%}else if(request.getParameter("delete") != null && error == null){//Cuando le de al boton de borrar muestro el confirmar y el de retroceder%>
								<button class="btn btn-danger" id="submitButton" type="submit" name="submit">Confirm</button>
				            	<a href="infoProjection.jsp?premiereDate=<%=projection.getPremiereDate()%>&room=<%=projection.getRoom().getRoomNumber()%>&cinema=<%=cinema.getCinema()%>&film=<%=projection.getFilm().getCip()%>"><button class="btn btn-primary" id="submitButton" type="button" name="undo">Undo</button></a>
							<%}else if(error != null){ //Si hay algun error le doy la opción de reintentar%>
								<a href="./listProjections.jsp"><button class="btn btn-primary" id="submitButton" type="button">Retry</button></a>
							<%}else if(request.getParameter("submit") != null && error == null){ //Cuando le de a borrar confirmado borro
								try{
									DbRepository.deleteEntity(projection);%>
									<a href="./listProjections.jsp"><button class="btn btn-info " id="submitButton" type="button">Return list</button></a>
								<%}catch(Exception e){
									error = "Projection not found";
								}
							}%>
			          </form>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>