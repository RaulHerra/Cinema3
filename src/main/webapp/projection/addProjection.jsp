<%@page import="com.jacaranda.repository.RoomRepository"%>
<%@page import="com.jacaranda.repository.CinemaRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.jacaranda.repository.DbRepository"%>    
<%@ page import="com.jacaranda.model.Projection"%> 
<%@ page import="com.jacaranda.model.Cinema"%>
<%@ page import="com.jacaranda.model.Room"%>
<%@ page import="com.jacaranda.model.Film"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.sql.Date"%>
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
	List<Cinema> result = new ArrayList<Cinema>();
	List<Room> roomResult = new ArrayList<Room>();
	List<Film> filmResult = new ArrayList<Film>();
	String requestCinema = request.getParameter("cinema");

	try{
		if(requestCinema==null){
			result = DbRepository.findAll(Cinema.class);
		}else{
			roomResult = CinemaRepository.getRooms(requestCinema);
			filmResult = DbRepository.findAll(Film.class);
		}
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Can't access to data base");
		return;
	}
	String error = null;
	try{
		if(false/*Añadir toda la primary key de projection*/){
			error = "Error there is already a projection with that parameters";
		}else{	
			try{				
				if(request.getParameter("submit") != null){
					
					String requestRoom = request.getParameter("room");
					String requestFilm = request.getParameter("film");
					String requestPremiereDate = request.getParameter("premiere_date");
					String requestPremiereDays = request.getParameter("premiere_days");
					String requestSpectators = request.getParameter("spectators");
					String requestIncome = request.getParameter("income");
					
					Cinema cinemaFind = DbRepository.find(Cinema.class,requestCinema);
					Room roomFind =	RoomRepository.findRoom(Room.class,requestCinema, requestRoom);
					Film filmFind = DbRepository.find(Film.class,requestFilm);
					Date premiereDate = Date.valueOf(requestPremiereDate);
					int premiereDays = Integer.parseInt(requestPremiereDays);
					int spectators = Integer.parseInt(requestSpectators);
					int income = Integer.parseInt(requestIncome);
					 
					Projection newProjection = new Projection(
							cinemaFind,
							roomFind,
							filmFind,
							premiereDate,
							premiereDays,
							spectators,
							income);
			}
			}catch(Exception e){
				error = e.getMessage();
			}
		}
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Can't access to data base");
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
	      	 <% if(requestCinema==null){ %>
		         <div class=" mb-3">
		           <label for="cinema" class="form-label">Select Cinema</label>
		   		   <select id="cinema" name="cinema" class="form-select custom-select">
		   		   		<option>-- Select Cinema --</option>
				      	<%for (Cinema c : result){ %>
				      		<option value="<%=c.getCinema()%>"><%=c.getCinema()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 <%} if(requestCinema!=null){ %>
	    		 <div class=" mb-3">
		               <label for="cinema" class="form-label">Selected Cinema</label>
		   			<input type="text" class="form-control" id="cinema" name="cinema" value="<%= requestCinema %>" required readonly>
		           </div>
		           
	    		 <div class=" mb-3">
		           <label for="room" class="form-label">Select Room</label>
		   		   <select id="room" name="room" class="form-select custom-select">
		   		   		<option>-- Select Room --</option>
				      	<%for (Room r : CinemaRepository.getRooms(requestCinema)){ %>
				      		<option value="<%=r.getCinema()%>"><%=r.getRoomNumber()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
	    		 <div class=" mb-3">
		           <label for="film" class="form-label">Select Film</label>
		   		   <select id="film" name="film" class="form-select custom-select">
		   		   		<option>-- Select Film --</option>
				      	<%for (Film f : filmResult){ %>
				      		<option value="<%=f.getCip()%>"><%=f.getTitleS()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
		           <div class=" mb-3">
		               <label for="premiere_date" class="form-label">Premiere date</label>
		   			<input type="date" class="form-control" id="premiere_date" name="premiere_date" max="<%=today%>" required>
		           </div>
	
		           <div class=" mb-3">
					<label for="premiere_days" class="form-label">Premiere Days</label>
		   			<input type="number" class="form-control" id="premiere_days" min="1" placeholder="Enter premiere days number" name="premiere_days" required>
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
		            	<div class="textAreaInfoError" ><%=error%></div>
		            <%
		            }else if(request.getParameter("submit") != null && error == null){%>
		            	<div class="textAreaInfoSuccesfull">Projection added successfully!</div>
		            <%} 
		            %>
	            <!-- Submit button -->
	  				
	              	<button class="btn btn-success " id="submitButton" type="submit" name="submit">Save</button>
	              	<%}else{%>
	              	<button class="btn btn-success " id="selectCinema" type="submit" name="selectCinema">Select cinema</button>
	    		 	<%} if(request.getParameter("submit") != null && error == null){%>
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