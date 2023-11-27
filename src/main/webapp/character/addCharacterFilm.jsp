<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Film"%>
<%@page import="com.jacaranda.model.Character"%>
<%@page import="com.jacaranda.model.Task"%>
<%@page import="com.jacaranda.model.Work"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Character to Film</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

	<%@include file="../nav.jsp"%>

	<%
	//CREMOS LOS LISTADOS CORRESPONDIENTES
	List<Film> films = null;
	List<Character> characters = null;
	List<Task> tasks = null;
	//CREMOS EL TRABAJO, EL MENSAJE DE ERROR, Y RESCATAMOS EL BOTON DE ENVIAR
	Work work = null;
	String error = null;
	String agregate = request.getParameter("submit");

	try {
		//BUSCAMOS LAS PELICULAS,PERSONAJES Y TAREAS DE LA BASE DE DATOS
		films = DbRepository.findAll(Film.class);
		characters = DbRepository.findAll(Character.class);
		tasks = DbRepository.findAll(Task.class);

		if (agregate != null) {
			
			//CUANDO PULSEMOS EL BOTÓN DE GUADAR...
	
			Film film = DbRepository.find(Film.class, request.getParameter("films")); //BUSCAMOS LA PELICULA PASADA POR EL FORMULARIO
			Character character = DbRepository.find(Character.class, request.getParameter("characters"));//BUSCAMOS EL CARACTER PASADO POR FORMULARIO
			Task task = DbRepository.find(Task.class, request.getParameter("task"));//BUSCAMOS LA TAREA PASADA POR FORMULARIO

			if (film == null || character == null || task == null) { //SI TODO ES NULO ENVIAREMOS UN MENSAJE DE ERROR
				error = "Enter a valid film, character or task.";
			} else {
				work = new Work(character, film, task); //SI TODO EXISTE CREAREMOS UN TRABAJO
			}

			if (DbRepository.find(Work.class, work) != null) //SI EL TRABAJO ES DISTINTO DE NULO
				error = "Error: the character with the entered task already exists."; //ENVIAREMOS UN MENSAJE DE QUE EL TRABAJO YA EXISTE
			else {
				DbRepository.addEntity(work);//SI NO EXISTE LO AGREGAREMOS A LA BASE DE DATOS
			}

		}

	} catch (Exception e) {
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
							<h1>Add Character to Film</h1>
						</div>
						<%
						if (request.getParameter("filmSelected") == null && request.getParameter("characterSelected") == null && error == null) {
						%>
						<form>
							<div class="mb-3">
								<label for="film" class="form-label">Films</label>
								<div class="mb-3">
									<select id="films" name="films" class="form-select" required>
										<option disabled selected>-- Select the film --</option>
										<%
										for (Film film : films) {
										%>
										<option value="<%=film.getCip()%>"><%=film.getTitleP()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
							<button name="filmSelected" type="submit" class="btn btn-success">Select
								film</button>
						</form>
						<%
						} else if (request.getParameter("films") != null && request.getParameter("filmSelected") != null && error == null) {
						Film filmFind = DbRepository.find(Film.class, request.getParameter("films"));
							if (filmFind != null) {
							%>
						<form>
							<div class="mb-3">
								<label for="film" class="form-label">Films</label>
								<div class="mb-3">
									<input value="<%=filmFind.getTitleP()%>" class="form-control"
										readonly required> <input
										value="<%=filmFind.getCip()%>" class="form-control"
										name="films" hidden>
								</div>
							</div>
							<div class="mb-3">
								<label for="characters" class="form-label">Characters</label>
								<div class="mb-3">
									<select id="characters" name="characters" class="form-select"
										required>
										<option disabled selected>-- Select character --</option>
										<%
										for (Character character : characters) {
										%>
										<option value="<%=character.getCharacterName()%>"><%=character.getCharacterName()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
							<button name="characterSelected" type="submit"
								class="btn btn-success">Select Character</button>
						</form>
						<%
							} else {
								error = "Film not valid";
							}
						}
						%>
						<%
						if (request.getParameter("characters") != null && request.getParameter("characterSelected") != null && error == null) {
							Film filmFind = DbRepository.find(Film.class, request.getParameter("films"));
							if (filmFind != null) {
						%>

						<form>
							<div class="mb-3">
								<label for="film" class="form-label">Films</label>
								<div class="mb-3">
									<input class="form-control"
										value="<%=filmFind.getTitleP()%>"
										name="filmTitle" readonly required> <input
										value="<%=filmFind.getCip()%>" class="form-control"
										name="films" hidden>
								</div>
							</div>
							<div class="mb-3">
								<label for="characters" class="form-label">Characters</label>
								<div class="mb-3">
									<input class="form-control"
										value="<%=request.getParameter("characters")%>"
										name="characters" readonly required>
								</div>
							</div>
							<div class="mb-3">
								<label for="task" class="form-label">Tasks</label>
								<div class="mb-3">
									<select id="task" name="task" class="form-select" required>
										<option disabled selected>-- Select task --</option>
										<%
										for (Task task : tasks) {
										%>
										<option value="<%=task.getTask()%>"><%=task.getTask()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
							<button name="submit" type="submit" class="btn btn-success">Save</button>
						</form>
						<%
							} else {
								error = "Film not valid";
							}

						}
						%>
						<%
						if (error != null) {
							%>
							<div class="textAreaInfoError"><%=error%></div>
							<a href="addCharacterFilm.jsp" type="button" type="submit"
								class="btn btn-info">Return to the form</a>
						<%} else if (request.getParameter("submit") != null && error == null) {
							%>
							<div class="textAreaInfoSuccesfull ">Work created
								successfully!</div>
							<%
						}
						%>
						<!-- End of contact form -->
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>