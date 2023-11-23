<%@page import="com.jacaranda.repository.RoomRepository"%>
<%@page import="com.jacaranda.repository.CinemaRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.jacaranda.repository.DbRepository"%>    
<%@ page import="com.jacaranda.model.Projection"%> 
<%@ page import="com.jacaranda.model.Cinema"%>
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
	List<Cinema> result = new ArrayList<Cinema>();

	try{
		result = DbRepository.findAll(Cinema.class);
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Can't access to data base");
		return;
	}
	
%>
<%
	String error = null;
	try{
		if(request.getParameter("cinema") != null && DbRepository.find(Cinema.class, request.getParameter("cinema")) != null){
			error = "Error there is already a cinema with the name entered";
		}else{	
			try{
				if(request.getParameter("submit") != null){
					Cinema cinema = new Cinema(request.getParameter("cinema")
							,request.getParameter("cinemaCity")
							,request.getParameter("cinemaAddress"));
					DbRepository.addEntity(cinema);
			}
			}catch(Exception e){
				error = e.getMessage();
			}
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
				      	<%for (Cinema c : result){ %>
				      		<option value="<%=c.getCinema()%>"><%=c.getCinema()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 <div class=" mb-3">
		           <label for="room" class="form-label">Select Room</label>
		   		   <select id="room" name="room" class="form-select custom-select">
		   		   		<option>-- Select Room --</option>
				      	<%for (Cinema c : result){ %>
				      		<option value="<%=c.getCinema()%>"><%=c.getCinema()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
	    		 <div class=" mb-3">
		           <label for="film" class="form-label">Select Film</label>
		   		   <select id="film" name="film" class="form-select custom-select">
		   		   		<option>-- Select Film --</option>
				      	<%for (Cinema c : result){ %>
				      		<option value="<%=c.getCinema()%>"><%=c.getCinema()%></option>
				      	<% } %>
				   </select>
	    		 </div>
	    		 
		           <div class=" mb-3">
		               <label for="premiere_date" class="form-label">Premiere date</label>
		   			<input type="date" class="form-control" id="premiere_date" name="premiere_date" max="<%=today%>" required>
		           </div>
	
		           <div class=" mb-3">
					<label for="premiere_days" class="form-label">Premiere Days</label>
		   			<input type="number" class="form-control" id="premiere_days" name="premiere_days" required>
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
		            	<div class="textAreaInfoSuccesfull">Cinema created successfully!</div>
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