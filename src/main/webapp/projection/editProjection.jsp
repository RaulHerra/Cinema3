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
		Projection projection = null;
		Cinema cinema = null; 
		Film film = null;
		Room room = null;
		String error = null;
		Date premiereDate = null;
				
		try{
			//Busco un cine con el parametro que nos ha pasado
			String cinemaParam = request.getParameter("cinema");
			String roomParam = request.getParameter("roomNumber");
			String filmParam = request.getParameter("filmCip");

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
					error = "Error cinema not valid";
				}
			}catch(Exception e){
				error = "Error room number not valid";
			}
			
			
		 	if(error == null && room == null){
				error = "Error room not valida";
			}else if(error == null && cinema == null){
				error = "Error cinema not valid";
			}else if(error == null && film == null){
				error = "Error film not valid";
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
				
			if(request.getParameter("edit") != null){
				int premiereDays = -1;
				int spectators = -1;
				int income = -1;
				
				try{					
					premiereDays = Integer.valueOf(request.getParameter("premiereDays"));
				}catch(Exception e){
					error = "premiere days not valid";
				}
				
				try{					
					spectators = Integer.valueOf(request.getParameter("spectators"));
				}catch(Exception e){
					error = "spectators not valid";
				}
				
				try{					
					income =Integer.valueOf(request.getParameter("income"));
				}catch(Exception e){
					error = "income not valid";
				}
				
				if(error == null){
					projection = new Projection(room,
							film, 
							premiereDate, 
							premiereDays, 
							spectators,
							income);
					DbRepository.editEntity(projection);
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
			          <%if(projection != null){ //Si la proyeccion no es nula muestro los campos%>
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
			    			<input type="date" class="form-control" id="premiereDate" name="premiereDate" value="<%=premiereDate%>" readonly required>
			            </div>
			            
						<div class=" mb-3">
							<label for="premiereDays" class="form-label">Premiere days</label>
			    			<input type="number" min="1" class="form-control" id="premiereDays" name="premiereDays" value="<%=projection.getPremiereDays()%>"  required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="spectators" class="form-label">Spectators</label>
			    			<input type="number" min="1" class="form-control" id="spectators" name="spectators" value="<%=projection.getSpectators()%>"  required>
			            </div>
			            
			            <div class=" mb-3">
							<label for="income" class="form-label">Income</label>
			    			<input type="number" min="1" class="form-control" id="income" name="income" value="<%=projection.getIncome()%>"  required>
			            </div>
			            
			            
			            <!-- Submit button -->
			          <%}%>
			          <%
			         if(error != null){%>
		            	<div class="textAreaInfoError " ><%=error%></div>
		            	<a href="listProjections.jsp"><button class="btn btn-info " id="submitButton" type="button">Return to list</button></a>
		            <%/*Y aqui si se ha enviado el edit y en valor de la variable es nulo significa que se ha editado correctamente, entoces muestro
		            el mensaje de éxito*/
		            }else if(request.getParameter("edit") != null && error == null){%>
		            	<div class="textAreaInfoSuccesfull " >Projection edited successfully!</div> 
		            <%} /*Cuando pase todo esto dejo el error en nulo para que se reinicie por si ocurre otro error cuando envíe de nuevo el formulario */
		            %>
		           
		            <!-- Submit button -->
		             	<%if(request.getParameter("edit") == null && error == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
		             		<button class="btn btn-danger " id="submitButton" value="edit" type="submit" name="edit">Confirm</button>
				     	<%}else if(request.getParameter("edit") != null && error == null){ %>
		            		<a class="btn btn-primary" href="infoProjection.jsp?premiereDate=<%=projection.getPremiereDate()%>&room=<%=projection.getRoom().getRoomNumber()%>&cinema=<%=cinema.getCinema()%>&film=<%=projection.getFilm().getCip()%>">
		            		Show Projection</a>
		            	<%}%>
			       		</form>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>