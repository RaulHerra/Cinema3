<%@page import="java.util.List"%>
<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.model.Room"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Room</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	
	//para pruebas    http://localhost:8080/CinemaTeam/room/addRoom.jsp?cinema=Zayra	

	List<Cinema> allCinemas = null;
	String error = null;
	try{
		allCinemas = DbRepository.findAll(Cinema.class);
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Error connecting to database");
		return; 
	}
	
	if(allCinemas == null){
		response.sendRedirect("../error.jsp?msg=Cinema doesn't exist");
		return; 
	}
	
		Room tmpRoom = null;
		if(request.getParameter("save") != null){

			if(request.getParameter("room") != null && request.getParameter("capacity") != null && request.getParameter("cinema") != null){
			
				Cinema tmpCinema = null;
				int roomId;
				int capacity;
				try{
					roomId = Integer.parseInt((String)request.getParameter("room") );
					capacity = Integer.parseInt((String)request.getParameter("capacity"));
					tmpCinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
					tmpRoom = new Room(tmpCinema,roomId, capacity);
					
					try{
						if(DbRepository.find(Room.class, tmpRoom) == null){
							DbRepository.addEntity(tmpRoom);		
						}else{
							error = "Error. Room already exist ";
						}
					}catch(Exception e){
						error = "Error. Error adding to database ";
					}
				}catch(Exception e){
					error = "Error. Datas not valid";
				}
				
			}else{
				error = "Error. Datas can't be null";
			}				
		}
		%>
	
	<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
				<h1>Add Room</h1>   
	          </div>
	          <form id="addRoom" action="addRoom.jsp" method="get">
	            <div class="mb-3">
	              <label for="cinema" class="form-label">Cinema</label>
			      		      
			      <select id="cinema" name="cinema" class="form-select" required>
			      	<option  disabled selected>-- Select a cinema --</option>
			      	<%for(Cinema cinema : allCinemas){ %>
			        	<option value="<%=cinema.getCinema()%>"><%=cinema.getCinema() %></option>
			        <%} %>
			      </select>	            
	            </div>
	            
	            
	            
	            <div class=" mb-3">
	              <label for="room" class="form-label">Room Number</label>
	              <input class="form-control" id="room" name="room" type="number" min="1" step="1" placeholder="Enter Room number" required>
	            </div>
	            
	              <div class=" mb-3">
	              <label for="capacity" class="form-label">Capacity</label>
	              <input class="form-control" id="capacity" name="capacity" type="number" min="20" step="1" placeholder="Enter Room capacity" required>
	            </div>
	            
	            <% //Mensaje de error que salta si anteriormente ha saltado alguna excepcion.Mostrara el mensaje correspondiente
	            if(error != null){%>
	            	<div class="textAreaInfoError"><%=error%></div>
	            	
	            <%//Mensaje de exito que salta en el caso de que se crea con exito la tarea
	            }else if(request.getParameter("save") != null && error == null){%>
		            <div class="textAreaInfoSuccesfull">Room created successfully!</div>
	            <%} 
	            %>
	            
	            
	              <button class="btn btn-success " id="submitButton" type="submit" name="save">Save</button>
	              
	          
	            
	          </form>	
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>