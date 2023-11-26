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
<title>Projection's info</title>
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
				error = "Error film not valid";
			}
			
			if(cinemaParam != null){
				 cinema = DbRepository.find(Cinema.class, cinemaParam);
			}else{
				error = "Error cinema not valid";
			}
			
			try{
				if(cinema != null){
					room = new Room(cinema,Integer.valueOf(roomParam),23);					
				}else{
					error = "cinema not valid";
				}
			}catch(Exception e){
				error = "Error room number not valid";
			}
			
			
		 	if(error == null && room == null){
				error = "The room not valida";
			}else if(error == null && cinema == null){
				error = "The cinema not valid";
			}else if(error == null && film == null){
				error = "The film not valid";
			}
			
			Projection projectionFind = null;
			if(error == null){
				try{
					 projectionFind = new Projection(room,film,premiereDate);
				}catch(Exception e){
					error = e.getMessage();
				}
				
				projection = DbRepository.find(Projection.class,projectionFind);				
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
			            <h1>Projection's info</h1>
			          </div>
			          <form>
			          <%if(projection != null){ //Si el cine no es nulo muestro los campos%>
			            <div class=" mb-3">
			    			<label for="cinema" class="form-label">Cinema</label>
			    			<input type="text" class="form-control" id="cinema" name="cinema" value='<%=cinema.getCinema()%>'readonly required>
			            </div>
			            <div class=" mb-3">
			    			<label for="cinema" class="form-label">Room number</label>
			    			<input type="text" class="form-control" id="roomNumber" name="roomNumber" value='<%=room.getRoomNumber()%>'readonly required>
			            </div>
			
			            <div class=" mb-3">
			                <label for="filmTitle" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="filmTitle" name="filmTitle" value="<%=film.getTitleP()%>" readonly required>
			            </div>
			
			            <div class=" mb-3">
							<label for="premiereDate" class="form-label">Premiere date</label>
			    			<input type="text" step="1" class="form-control" id="premiereDate" name="premiereDate" value="<%=premiereDate%>" readonly required>
			            </div>
			            
						<div class=" mb-3">
							<label for="premiereDays" class="form-label">Premiere days</label>
			    			<input type="text" step="1" class="form-control" id="premiereDays" name="premiereDays" value="<%=projection.getPremiereDays()%>" readonly required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="spectators" class="form-label">Spectators</label>
			    			<input type="text" step="1" class="form-control" id="spectators" name="spectators" value="<%=projection.getSpectators()%>" readonly required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="income" class="form-label">Income</label>
			    			<input type="text" step="1" class="form-control" id="income" name="income" value="<%=projection.getIncome()%>" readonly required>
			            </div>
			            
			            
			            <!-- Submit button -->
			              	<a href="editProjection.jsp?premiereDate=<%=projection.getPremiereDate()%>&roomNumber=<%=projection.getRoom().getRoomNumber()%>&cinema=<%=cinema.getCinema()%>&filmCip=<%=projection.getFilm().getCip()%>"><button class="btn btn-warning " id="submitButton" type="button">Edit</button></a>
			              	<a href="deleteProjection.jsp?premiereDate=<%=projection.getPremiereDate()%>&roomNumber=<%=projection.getRoom().getRoomNumber()%>&cinema=<%=cinema.getCinema()%>&filmCip=<%=projection.getFilm().getCip()%>"><button class="btn btn-danger " id="submitButton" value="delete" type="button" name="delete">Delete</button></a>
			          </form>
			          <%}%>
			          <%
			      		if(error != null){ //En el caso de haya un erro muestro el error y pongo un boton de volver a la lista%>
			            	<div class="textAreaInfoError " ><%=error%></div><br>
			            	<a href="./listProjections.jsp"><button class="btn btn-info" id="submitButton" type="button">Return list</button></a>
			       		<%}%>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>