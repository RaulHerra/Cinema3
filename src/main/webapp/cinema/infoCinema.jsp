<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Info Cinema</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%		
		Cinema c = null; 
		String error = null;
		try{
			c = DbRepository.find(Cinema.class, request.getParameter("cinema"));
			if(c == null){
				error = "Error there is no cinema with that name";
			}
		}catch(Exception e){
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
			            <h1>Info Cinema</h1>
			          </div>
			          <form>
			          <%if(c != null){ %>
			            <div class=" mb-3">
			    			<label for="cinema" class="form-label">Cinema</label>
			    			<input type="text" class="form-control" id="cinema" name="cinema" value='<%=c.getCinema()%>'readonly required>
			            </div>
			
			            <div class=" mb-3">
			                <label for="cinemaCity" class="form-label">Cinema city</label>
			    			<input type="text" class="form-control" id="cinemaCity" name="cinemaCity" value="<%=c.getCityCinema()%>" readonly required>
			            </div>
			
			            <div class=" mb-3">
							<label for="cinemaAddress" class="form-label">Cinema address</label>
			    			<input type="text" step="1" class="form-control" id="cinemaAddress" name="cinemaAddress" value="<%=c.getAddressCinema()%>" readonly required>
			            </div>
			            

			            <!-- Submit button -->
			              	<a href="editCinema.jsp?cinema=<%=c.getCinema()%>"><button class="btn btn-warning " id="submitButton" value="edit" type="button" name="edit">Edit</button></a>
			              	<a href="deleteCinema.jsp?cinema=<%=c.getCinema()%>"><button class="btn btn-danger " id="submitButton" value="delete" type="button" name="delete">Delete</button></a>
			          </form>
			          <%}%>
			          <%
			      		if(error != null){%>
			            	<div class="textAreaInfoError " ><%=error%></div><br>
			            	<a href="./listCinemas.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
			       		<%}%>
			          <!-- End of contact form -->
			          	<% if (c != null) { %>
			   				 <a href="../room/cinemasRooms.jsp?cinema=<%=c.getCinema()%>"><button class="btn btn-primary " id="submitButton" name="cinema">Rooms</button></a>
						<%} %>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>