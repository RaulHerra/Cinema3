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
<title>Info projection</title>
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
					p = DbRepository.find(Projection.class,projectionFind);
					if(p == null) error = "projection not found";
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
			            <h1>Info Proyection</h1>
			          </div>
			          <form method="post">
			          <%if(p != null){ //Si el cine no es nulo muestro los campos%>
			            <div class=" mb-3">
			    			<label for="cinema" class="form-label">Room number</label>
			    			<input type="text" class="form-control" id="roomNumber" name="roomNumber" value='<%=room.getRoomNumber()%>'readonly required>
			            </div>
			
			            <div class=" mb-3">
			                <label for="cinemaCity" class="form-label">Film title</label>
			    			<input type="text" class="form-control" id="filmTitle" name="filmTitle" value="<%=film.getTitleP()%>" readonly required>
			            </div>
			
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Premiere date</label>
			    			<input type="text" step="1" class="form-control" id="premiereDate" name="premiereDate" value="<%=premiereDate%>" readonly required>
			    			<input type="hidden" step="1" class="form-control" id="premiereDate" name="premiereDateDelete" value="<%=premiereDate%>" readonly required>
			            </div>
			            
						<div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Premiere days</label>
			    			<input type="text" step="1" class="form-control" id="premiereDay" name="premiereDay" value="<%=p.getPremiereDays()%>" readonly required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Spectators</label>
			    			<input type="text" step="1" class="form-control" id="spectators" name="spectators" value="<%=p.getSpectators()%>" readonly required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Income</label>
			    			<input type="text" step="1" class="form-control" id="income" name="income" value="<%=p.getIncome()%>" readonly required>
			            </div>
			            
			            
			            <!-- Submit button -->
			              	<a href="editProjection.jsp?premiereDate=<%=p.getPremiereDate()%>&room=<%=p.getRoom().getRoomNumber()%>&projection=<%=p.getPremiereDate()%>&cinema=<%=cinema.getCinema()%>&film=<%=p.getFilm().getCip()%>"><button class="btn btn-warning " id="submitButton" value="edit" type="button" name="edit">Edit</button></a>
			              	<a href="deleteProjection.jsp?premiereDate=<%=p.getPremiereDate()%>&room=<%=p.getRoom().getRoomNumber()%>&projection=<%=p.getPremiereDate()%>&cinema=<%=cinema.getCinema()%>&film=<%=p.getFilm().getCip()%>"><button class="btn btn-danger " id="submitButton" value="delete" type="button" name="delete">Delete</button></a>
			          </form>
			          <%}
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