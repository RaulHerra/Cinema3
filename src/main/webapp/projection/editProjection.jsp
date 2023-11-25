<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.jacaranda.repository.CinemaRepository"%>
<%@page import="com.jacaranda.repository.RoomRepository"%>
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
<title>Edit Projection</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%	
		Projection p = null;
		Cinema cinema = null; 
		Film film = null;
		Room room = null;
		String error = null;
		Date premiereDate = null;
		
		boolean update = false;
		
		try{
			if(request.getParameter("submit")==null){
				String cinemaParam = request.getParameter("cinema");
				String filmParam = request.getParameter("filmCip");
				String roomParam = request.getParameter("roomNumber");
				
				
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
					room = RoomRepository.findRoom(cinema, Integer.parseInt(roomParam));
				}catch(Exception e){
					error = "Error room number not valid";
				}
				
				Projection projectionFind = null;
				
				try{
					 projectionFind = new Projection(room,film,premiereDate);
				}catch(Exception e){
					error = e.getMessage();
				}
				
				if(error == null){
					p = DbRepository.find(Projection.class,projectionFind);				
				}
	
				if(cinema == null || room==null || film==null){
					//Si la proyeccion es nula guardo el error en la variable
					error = "Error there is no cinema with that name";
				}
				
			}else{
				//Extraemos los datos y creamos un nuevo objeto
				
				Cinema tmpCinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
				Room tmpRoom = RoomRepository.findRoom(tmpCinema, Integer.valueOf(request.getParameter("roomNumber")));
				Film tmpFilm = DbRepository.find(Film.class, request.getParameter("filmCip"));
				Date tmpPremiereDate = Date.valueOf(request.getParameter("premiereDate"));
				int tmpPremiereDays = Integer.valueOf(request.getParameter("premiereDays"));
				int tmpSpectators = Integer.valueOf(request.getParameter("spectators"));
				int tmpIncome = Integer.valueOf(request.getParameter("income"));
				
				
				Projection updated = new Projection(tmpRoom,
						tmpFilm, 
						tmpPremiereDate, 
						tmpPremiereDays, 
						tmpSpectators,
						tmpIncome);
				
				try{
					DbRepository.editEntity(updated);
					update = true;
				}catch(Exception e){
					error="Can't edit projection right now, try again later";
				}
				
			}
		}catch(Exception e){
			//En el caso de que haya un error en la base de datos lo redirecciono a la base de datos con el error correspondiente
			error = e.getMessage();
		}
%>
	<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <h1>Edit Projection</h1>
			          </div>
			          <form>
			          <%if(p != null){ //Si la proyeccion no es nula muestro los campos%>
			            <div class=" mb-3">
			    			<label for="cinema" class="form-label">Cinema</label>
			    			<input type="text" class="form-control" id="cinema" name="cinema" value='<%=cinema.getCinema()%>'readonly required>
			            </div>
			            
			            <div class=" mb-3">
			    			<label for="roomNumber" class="form-label">Room number</label>
			    			<input type="text" class="form-control" id="roomNumber" name="roomNumber" value='<%=room.getRoomNumber()%>'readonly required>
			            </div>
			
			            <div class=" mb-3">
			                <label for="filmCip" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="filmCip" name="filmCip" value="<%=film.getCip()%>" hidden required>
			    			<input type="text" class="form-control" id="filmTitle" name="filmTitle" value="<%=film.getTitleS()%>" readonly required>
			            </div>
			
			            <div class=" mb-3">
							<label for="premiereDate" class="form-label">Premiere date</label>
			    			<input type="text" step="1" class="form-control" id="premiereDate" name="premiereDate" value="<%=premiereDate%>" readonly required>
			            </div>
			            
						<div class=" mb-3">
							<label for="premiereDays" class="form-label">Premiere days</label>
			    			<input type="text" step="1" class="form-control" id="premiereDays" name="premiereDays" value="<%=p.getPremiereDays()%>"  required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="spectators" class="form-label">Spectators</label>
			    			<input type="text" step="1" class="form-control" id="spectators" name="spectators" value="<%=p.getSpectators()%>"  required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="income" class="form-label">Income</label>
			    			<input type="text" step="1" class="form-control" id="income" name="income" value="<%=p.getIncome()%>"  required>
			            </div>
			            
			            
			            <!-- Submit button -->
			              	<button name="submit" class="btn btn-warning" value="edit">Confirm Edit</button>
			          <%}%>
			          <%
			      		if(error != null){ //En el caso de haya un erro muestro el error y pongo un boton de volver a la lista%>
			            	<div class="textAreaInfoError " ><%=error%></div><br>
			            	<a href="./listProjections.jsp"><button class="btn btn-primary " id="edit" name="edit" type="button">Return list</button></a>
			       		<%}else if(update){%>
			       			<div class="textAreaInfoSuccesfull">Projection edited successfully!</div>
			       		<%}%>
			       		</form>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>