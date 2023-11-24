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
	LocalDate today = LocalDate.now();
	List<Cinema> cinemas = new ArrayList<Cinema>();
	List<Room> rooms = new ArrayList<Room>();
	List<Film> films = new ArrayList<Film>();
	Date premiereDate = null;

	try{
		cinemas = DbRepository.findAll(Cinema.class);
		rooms = DbRepository.findAll(Room.class);
		films = DbRepository.findAll(Film.class);
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Can't access to data base");
		return;
	}
	
%>
<%
	String error = null;
	try{
		try{
			if(request.getParameter("submit") != null){
					Cinema cinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
					Room room = new Room(cinema, Integer.valueOf(request.getParameter("room")));
					Film film = DbRepository.find(Film.class, request.getParameter("film"));
					
					if(DbRepository.find(Room.class, room)!=null && cinema!=null&& film!=null){
						Projection p = new Projection(cinema, room, film, Date.valueOf(request.getParameter("premiere_date")), 
								Integer.valueOf(request.getParameter("premiere_days")), Integer.valueOf(request.getParameter("spectators")),
								Integer.valueOf(request.getParameter("income")));
						
						DbRepository.addEntity(p);
					}else{
						error = "The cinema, the room or the film not exist!";
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
	
	          <form method="get">
		         <div class=" mb-3">
		           <label for="cinema" class="form-label">Select Cinema</label>
		   		   <select id="cinema" name="cinema" class="form-select custom-select">
		   		   		<option>-- Select Cinema --</option>
				      	<%for (Cinema c : cinemas){ %>
				      		<option value="<%=c.getCinema()%>"><%=c.getCinema()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 <div class=" mb-3">
		           <label for="room" class="form-label">Select Room</label>
		   		   <select id="room" name="room" class="form-select custom-select">
		   		   		<option>-- Select Room --</option>
				      	<%for (Room r : rooms){ %>
				      		<option value="<%=r.getRoomNumber()%>"><%=r.getRoomNumber()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
	    		 <div class=" mb-3">
		           <label for="film" class="form-label">Select Film</label>
		   		   <select id="film" name="film" class="form-select custom-select">
		   		   		<option>-- Select Film --</option>
				      	<%for (Film f : films){ %>
				      		<option value="<%=f.getCip()%>"><%=f.getTitleP()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
		           <div class=" mb-3">
		               <label for="premiere_date" class="form-label">Premiere date</label>
		   			<input type="date" class="form-control" id="premiere_date" name="premiere_date" max="<%=today%>" required>
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
		            <%
		            if(error != null){%>
		            	<div class="textAreaInfoError " ><%=error%></div>
		            <%
		            }else if(request.getParameter("submit") != null && error == null){%>
		            	<div class="textAreaInfoSuccesfull " >Cinema created successfully!</div>
		            <%} 
		            %>
	            <!-- Submit button -->
	  
	              	<button class="btn btn-success " id="submitButton" type="submit" name="submit">Save</button>
	              	<%if(request.getParameter("submit") != null && error == null){%>
				     	<a href="infoCinema.jsp?cinema=<%=request.getParameter("cinema")%>"><button class="btn btn-primary" id="submitButton" type="button">Show cinema</button></a>
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