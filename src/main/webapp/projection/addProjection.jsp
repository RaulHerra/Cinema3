<%@page import="com.jacaranda.exception.ProjectionException"%>
<%@page import="com.jacaranda.repository.RoomRepository"%>
<%@page import="com.jacaranda.repository.CinemaRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>    
<%@ page import="com.jacaranda.model.Projection"%> 
<%@ page import="com.jacaranda.model.Cinema"%>
<%@ page import="com.jacaranda.model.Film"%>
<%@ page import="com.jacaranda.model.Room"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Projection</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>
<body>

<% 
	List<Cinema> cinemas = new ArrayList<Cinema>();
	List<Room> rooms = new ArrayList<Room>();
	List<Film> films = new ArrayList<Film>();
	Date premiereDate = null;

	try{
		cinemas = DbRepository.findAll(Cinema.class);
		rooms = DbRepository.findAll(Room.class);
		films = DbRepository.findAll(Film.class);
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Failed to connect to database");
		return;
	}
	
%>
<%
	String error = null;
	try{
		try{
			if(request.getParameter("submit") != null){
				String cinemaParam = request.getParameter("cinema");
				String roomParam = request.getParameter("room");
				String filmParam = request.getParameter("film");
				
				Film film = null;
				if(filmParam != null){
					film = DbRepository.find(Film.class,filmParam);					
				}else{
					error = "Error film not valid";
				}
				
				Cinema cinema = null;
				if(cinemaParam != null){
					 cinema = DbRepository.find(Cinema.class, cinemaParam);
					
				}else{
					error = "Error cinema not valid";
				}
				
				Room room = null;
				try{
					room = new Room(cinema,Integer.valueOf(roomParam),23);
				}catch(Exception e){
					error = "Error room number not valid";
				}
	
				try{
					premiereDate = Date.valueOf(request.getParameter("premiere_date"));
				}catch(Exception e){
					error = "Date not valid";

				}
				
				int premiereDays = 0;
				
				try{
					premiereDays = Integer.valueOf(request.getParameter("premiere_days"));
				}catch(Exception e){
					error = "Premiere Days not valid";
				}
				
				int income = 0;
				
				try{
					income = Integer.valueOf(request.getParameter("income"));
				}catch(Exception e){
					error = "Income Days not valid";
				}
				
				
				if(room!=null && cinema!=null && film!=null && error == null){
					Projection projection = null;
					try{
						int tmpSpectators = Integer.valueOf(request.getParameter("spectators"));
						projection = new Projection(room, film, premiereDate, 
								premiereDays, 
								tmpSpectators,
								income);
		 
					}catch(ProjectionException pe){
						error = pe.getMessage();
					}
					
					if(projection!=null && DbRepository.find(Projection.class, projection) == null){
						DbRepository.addEntity(projection);							
					}else if(projection!=null && DbRepository.find(Projection.class, projection) != null){
						error = "The projection already exist!";
					}
				
				}else if(room == null){
					error = "The room not valid";
				}else if(cinema == null){
					error = "The cinema not valid";
				}else if(film == null){
					error = "The film not valid";
				}
			}
		}catch(Exception e){
			error = e.getMessage();
		}
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
		return;
	}

		%>

<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>

	<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <h1>Add Projection</h1>
	          </div>
	          <%if(request.getParameter("selectCinema") == null && request.getParameter("cinema") == null){%>
			      <form method="get">
			         <div class=" mb-3">
			           <label for="cinema" class="form-label">Select Cinema</label>
			   		   <select id="cinema" name="cinema" class="form-select custom-select">
			   		   		<option disabled selected>-- Select Cinema --</option>
					      	<%for (Cinema cinema : cinemas){ %>
					      		<option value="<%=cinema.getCinema()%>"><%=cinema.getCinema()%></option>
					      	<% }%>
					   </select>
	   	              	<button class="btn btn-success " id="selectCinema" type="submit" name="selectCinema">Select cinema</button>
		    		 </div>
		    		 
		    		 </form>	          
			<%}else{ 
				Cinema cinemaRooms = null;
				if(request.getParameter("cinema") != null){
					cinemaRooms = DbRepository.find(Cinema.class, request.getParameter("cinema"));					
				}
				if(cinemaRooms != null){
			%>
			
	          <form method="get">
		         <div class=" mb-3">
		           <label for="cinema" class="form-label">Cinema</label>
	   				<input type="text" class="form-control" id="cinema" name="cinema" value="<%=request.getParameter("cinema")%>" required readonly>
	    		 </div>
	    		 <div class=" mb-3">
		           <label for="room" class="form-label">Select Room</label>
		   		   <select id="room" name="room" class="form-select custom-select">
		   		   		<option disabled selected >-- Select Room --</option>
				      	<%for (Room room : cinemaRooms.getRooms()){ %>
				      		<option value="<%=room.getRoomNumber()%>"><%=room.getRoomNumber()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
	    		 <div class=" mb-3">
		           <label for="film" class="form-label">Select Film</label>
		   		   <select id="film" name="film" class="form-select custom-select">
		   		   		<option disabled selected>-- Select Film --</option>
				      	<%for (Film film : films){ %>
				      		<option value="<%=film.getCip()%>"><%=film.getTitleP()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
		           <div class=" mb-3">
		               <label for="premiere_date" class="form-label">Premiere date</label>
		   				<input type="date" class="form-control" id="premiere_date" name="premiere_date" required>
		           </div>
	
		           <div class=" mb-3">
					<label for="cinemaAddress" class="form-label">Premiere Days</label>
		   			<input type="number" class="form-control" id="premiere_days" name="premiere_days" min="1" placeholder="Enter premiere days" required>
		           </div>
		           
		           <div class=" mb-3">
					<label for="spectators" class="form-label">Spectators</label>
		   			<input type="number" class="form-control" id="spectators" min="1" placeholder="Enter spectators number" name="spectators" required>
		           </div>
		           
		           <div class=" mb-3">
					<label for="income" class="form-label">Income</label>
		   			<input type="number" class="form-control" id="income" name="income" min="1" placeholder="Enter income" required>
		           </div>
		            <%}else{
		            	error = "The cinema not found";
		            }
		            if(error != null){%>
		            	<div class="textAreaInfoError" ><%=error%></div>
		            	<a href="addProjection.jsp"><button class="btn btn-info" id="submitButton" type="button" name="submit">Retry</button></a>
		            <%
		            }else if(request.getParameter("submit") != null && error == null){%>
		            	<div class="textAreaInfoSuccesfull">Projection created successfully!</div>
		            <%} 
		            %>
	            <!-- Submit button -->
	  				<%if(error == null){%>
		              	<button class="btn btn-success " id="submitButton" type="submit" name="submit">Save</button>
	  				<%}%>
	              	<%if(request.getParameter("submit") != null && error == null){%>
				     	<a href="infoProjection.jsp?cinema=<%=request.getParameter("cinema")%>&room=<%=request.getParameter("room")%>&film=<%=request.getParameter("film")%>&premiereDate=<%=request.getParameter("premiere_date")%>"><button class="btn btn-primary" id="submitButton" type="button">Show projection</button></a>
	              	<%}%>
	              		<a href="addProjection.jsp"><button class="btn btn-warning" id="submitButton" type="button">Change cinema</button></a>	

	          </form>
	          <!-- End of contact form -->
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	<%}%>

</body>
</html>
