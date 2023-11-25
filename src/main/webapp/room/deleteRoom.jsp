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
<title>Delete Room</title>
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

	int roomId;
	int capacity;
	Room tmpRoom = null;
	Cinema tmpCinema = null;
	String error = null;
	try {
		//Validamos que ambos campos existan 
		roomId = Integer.parseInt((String) request.getParameter("room"));
		tmpCinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
		tmpRoom = DbRepository.find(Room.class, new Room(tmpCinema, roomId));
		
	} catch (Exception e) {
		System.out.println(e.getMessage());
		response.sendRedirect("../error.jsp?msg=Datas not valid");
		return;
	}
	


	%>

	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">

						<div class="text-center">
							<h1>Delete the room</h1>
						</div>
						<form id="addRoom" action="addRoom.jsp" method="get">
							<div class="mb-3">
								<label for="cinema" class="form-label">Cinema</label> 
								<select id="cinema" name="cinema" class="form-select readonly" required >
										<option  selected value="<%=tmpRoom.getCinema().getCinema()%>"><%=tmpRoom.getCinema().getCinema()%></option>
								</select>
							</div>



							<div class="mb-3">
								<label for="room" class="form-label">Room Number</label> <input
									class="form-control" id="room" name="room" type="number"
									min="1" step="1" placeholder="Enter Room number" required readonly
									value="<%= tmpRoom.getRoomNumber()%>">
							</div>

							<div class="mb-3">
								<label for="capacity" class="form-label">Capacity</label> 
								<input
									class="form-control" id="capacity" name="capacity"
									type="number" min="21" step="1"
									placeholder="Enter Room capacity" required readonly
									value="<%= tmpRoom.getCapacity()%>">
							</div>
		
							
							<%
							if(request.getParameter("delete") == null && request.getParameter("submit") == null && error == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
				            	<button class="btn btn-danger" id="submitButton" type="submit" name="delete">Are you sure you want to delete it?</button>
							<%}else if(request.getParameter("delete") != null && error == null){//Cuando le de al boton de borrar muestro el confirmar y el de retroceder%>
								<button class="btn btn-danger" id="submitButton" type="submit" name="submit">Confirm</button>
				            	<a href="./infoCinema.jsp?cinema=<%=request.getParameter("cinema")%>"><button class="btn btn-primary  " id="submitButton" type="button" name="undo">Undo</button></a>
							<%}else if(error != null){ //Si hay algun error le doy la opción de reintentar%>
								<a href="./listCinemas.jsp"><button class="btn btn-primary" id="submitButton" type="button">Retry</button></a>
							<%}%>
							
							<%if(request.getParameter("submit") != null){ //Cuando le de a borrar confirmado borro el cinema
								RoomRepository.delete(tmpRoom);
								//Y muestro un botón de volver a la lista%>
								
								<a href="./listCinemas.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
							<%}%>




						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>