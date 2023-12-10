<%@page import="com.jacaranda.exception.RoomException"%>
<%@page import="com.jacaranda.repository.RoomRepository"%>
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
<title>Edit Room</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	try{
		String user = session.getAttribute("username").toString();
		if(!session.getAttribute("userRole").equals("ADMIN")){
			response.sendRedirect("../index.jsp");
			return;
		}
	}catch(Exception e){
		response.sendRedirect("../login.jsp");
		return;
	}
		int roomId = -1;
		int capacity = -1;
		Room tmpRoom = null;
		Cinema tmpCinema = null;
		String error = null;

		try {
			//Validamos que ambos campos existan 
			roomId = Integer.parseInt((String) request.getParameter("room"));
		} catch (Exception e) {
			error = "Error: Room id isn't valid";
		}
		if(error == null){
			tmpCinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
			if(tmpCinema != null){
				tmpRoom = DbRepository.find(Room.class, new Room(tmpCinema, roomId));
				if(tmpRoom == null && session.getAttribute("oldRoom") == null){
					error = "Error: Room doesn't exist";
				}
			}else{
				error = "Error: Cinema doesn't exist";
			}
		}
			
	
				if(request.getParameter("edit") != null && error == null){
					if(session.getAttribute("oldRoom") == null){
						error = "Not editable room, try again";
					}
					
					try {
						capacity = Integer.parseInt((String) request.getParameter("capacity"));
						tmpRoom = new Room(tmpCinema, roomId,capacity);
						Room originalRoom = (Room) session.getAttribute("oldRoom");
						RoomRepository.updateTo(originalRoom, tmpRoom);
					} catch (RoomException e) {
						error = e.getMessage();
					} catch (Exception e) {
						error = "Not editable room, try again";
					}	
					
					session.removeAttribute("oldRoom");
			} else if (error == null){
				session.setAttribute("oldRoom", tmpRoom);
			}

	%>
	
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">

						<div class="text-center">
							<h1>Edit Room</h1>
						</div>
						<% if(error == null && tmpRoom != null){%>
						<form  method="get">
							<div class="mb-3">
								<label for="cinema" class="form-label">Cinema</label> 
								<select id="cinema" name="cinema" class="form-select readonly" required>
									<option value="<%=tmpRoom.getCinema().getCinema()%>"><%=tmpRoom.getCinema().getCinema()%></option>
								</select>
							</div>

							<div class=" mb-3">
								<label for="room" class="form-label">Room Number</label> 
								<input
									class="form-control" id="room" name="room" type="number"
									min="1" step="1" placeholder="Enter Room number" required
									value="<%=tmpRoom.getRoomNumber()%>">
							</div>

							<div class=" mb-3">
								<label for="capacity" class="form-label">Capacity</label> 
								<input
									class="form-control" id="capacity" name="capacity"
									type="number" min="21" step="1"
									placeholder="Enter Room capacity" required
									value="<%=tmpRoom.getCapacity()%>">
							</div>

							<%
							}
							%>
							<%
							//Mensaje de error que salta si anteriormente ha saltado alguna excepcion.Mostrara el mensaje correspondiente
							if (error != null) {
									session.removeAttribute("oldRoom");
							%>
							<div class="textAreaInfoError"><%=error%></div>
	
					            	<a href="../cinema/listCinemas.jsp"><button class="btn btn-info " id="submitButton" type="button">Return to cinemas</button></a>
					            	<a href="../room/listRooms.jsp"><button class="btn btn-info " id="submitButton" type="button">Return to rooms</button></a>
							<%
							//Mensaje de exito que salta en el caso de que se crea con exito la tarea
							}else if (request.getParameter("edit") != null && error == null) {%>
								<div class="textAreaInfoSuccesfull">Room edited successfully!</div>
							<%}
							
							if (request.getParameter("edit") == null && error == null && tmpRoom != null) {%>
								<button class="btn btn-danger" id="submitButton" type="submit"
								name="edit">Confirm</button>
							<%} else if (tmpRoom != null && error == null) {%>
							<a href="infoRoom.jsp?cinema=<%=tmpRoom.getCinema().getCinema()%>&room=<%=tmpRoom.getRoomNumber()%>">
							<button	type="button" class="btn btn-primary">Show details</button></a>
							
							<%}%>
					
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>