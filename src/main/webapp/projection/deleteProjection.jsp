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
			//Busco una proyeccion con el parametro que nos ha pasado
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
				error = "Error film not valid";
			}
			
			if(cinemaParam != null){
				 cinema = DbRepository.find(Cinema.class, cinemaParam);
			}else{
				error = "Error cinema not valid";
			}
			
			try{
				room = new Room(cinema,Integer.valueOf(roomParam),23);
			}catch(Exception e){
				error = "Error room number not valid";
			}
			
			cinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
			room = DbRepository.find(Room.class, room);
			film = DbRepository.find(Film.class, request.getParameter("film"));
			Projection projectionFind = null;
			
			try{
				 projectionFind = new Projection(room,film,premiereDate);
			}catch(Exception e){
				error = e.getMessage();
			}
			
			if(error == null){
				projection = DbRepository.find(Projection.class,projectionFind);
			}

			if(cinema == null || room==null || film==null){
				//Si la proyeccion es nula guardo el error en la variable
				error = "Error there is no cinema with that name";
			}
			
			if(request.getParameter("delete")!=null){
				
				if(projection!=null){
					DbRepository.deleteEntity(projection);
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
			            
			            
			            <!-- Submit button -->
			           	<a href="deleteProjection.jsp?premiereDate=<%=premiereDate%>&room=<%=projection.getRoom().getRoomNumber()%>&projection=<%=projection.getPremiereDate()%>&cinema=<%=cinema.getCinema()%>&film=<%=projection.getFilm().getCip()%>"><button class="btn btn-danger " id="submitButton" value="delete" type="submit" name="delete">Delete</button></a>
			          </form>
			          <%}%>
			          <%
			      		if(error != null){ //En el caso de haya un erro muestro el error y pongo un boton de volver a la lista%>
			            	<div class="textAreaInfoError " ><%=error%></div><br>
			            	<a href="./listProjections.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
			       		<%}%>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>