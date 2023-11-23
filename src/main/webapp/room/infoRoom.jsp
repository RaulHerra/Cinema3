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
<title>Info Room</title>
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

	try {
		//Validamos que ambos campos existan 
		roomId = Integer.parseInt((String) request.getParameter("room"));
		tmpCinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
		tmpRoom = DbRepository.find(Room.class, new Room(tmpCinema, roomId));
/*
		try {
			if (DbRepository.find(Room.class, tmpRoom) == null) {
				DbRepository.addEntity(tmpRoom);
			} else {
				error = "Error. Room "+ roomId + " in cinema " + tmpCinema + " already exist ";
			}
		} catch (Exception e) {
			error = "Error. Error adding to database ";
		}
*/
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
							<h1>Info about the room</h1>
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
							<a href="editRoom.jsp?cinema=<%=tmpRoom.getCinema().getCinema()%>&room=<%=tmpRoom.getRoomNumber()%>"><button type="button" class="btn btn-warning">Edit</button></a>
							<a href="deleteRoom.jsp?cinema=<%=tmpRoom.getCinema().getCinema()%>&room=<%=tmpRoom.getRoomNumber()%>"><button type="button" class="btn btn-danger">Delete</button></a>

						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>