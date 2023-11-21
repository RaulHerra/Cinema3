<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.model.Room"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.exception.TaskException"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.jacaranda.model.Task"%>
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

	Cinema tmpCinema = null;
	String error = null;
	try{
		tmpCinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Error connecting to database");
		return; 
	}
	
	if(tmpCinema == null){
		response.sendRedirect("../error.jsp?msg=Cinema doesn't exist");
		return; 
	}
	
		Room tmpRoom = null;
		if(request.getParameter("save") != null){
			if(request.getParameter("room") != null && request.getParameter("capacity") != null ){
			
					int roomId;
					int capacity;
					try{
						roomId = Integer.parseInt((String)request.getParameter("room") );
						capacity = Integer.parseInt((String)request.getParameter("capacity"));
						tmpRoom = new Room(tmpCinema,roomId, capacity);
						
						try{
							if(!tmpCinema.getRooms().contains(tmpRoom)){
								DbRepository.addEntity(tmpRoom);		
							}else{
								error = "Error. Room already exist ";
							}
						}catch(Exception e){
							error = "Error. Error adding to database ";
							/*
							response.sendRedirect("../error.jsp?msg=Error. Room and cinema should exist");
							return; 
							*/
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
	          <form id="addtask" action="addRoom.jsp" method="get">
	            <div class="mb-3">
	              <label for="cinema" class="form-label">Cinema</label>
	              <input class="form-control" id="cinema" name="cinema" type="text" placeholder="Cinema" require readonly value="<%=tmpCinema.getCinema() %>">
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
		            <div class="textAreaInfoSuccesfull">Task created successfully!</div>
	            <%} 
	            %>
	            
	            
	              <button class="btn btn-success " id="submitButton" type="submit" name="save">Save</button>
	              <%//Boton disponible para ver los detalles de la tarea creada.El boton aparece si se ha creado con exito la tarea
	              if(request.getParameter("save") != null && error == null  ){%>
				     	<a href="infoTask.jsp?task=<%=request.getParameter("task")%>"><button class="btn btn-primary " id="submitButton" type="button">Show task</button></a>
	              <%}//Borramos la session para que no arrastre errores
	              %>
	          
	            
	          </form>	
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>