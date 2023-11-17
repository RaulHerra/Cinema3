<%@page import="com.jacaranda.model.Task"%>
<%@page import="com.jacaranda.repository.TaskRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info Task</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-primary">
	  <a class="navbar-brand text-white" href=".././index.jsp">Home</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././film/addFilm.jsp">Add film</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././film/listFilms.jsp">List films</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././character/addCharacter.jsp">Add character</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href=".././character/listCharacters.jsp">List characters</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="addTask.jsp">Add task</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="listTasks.jsp">List tasks</a>
	      </li>
	    </ul>
	  </div>
	</nav>
	<%
		Task t =null;
		if(TaskRepository.getPrimaryKey().contains(request.getParameter("task"))){//Comprueba la tarea pasada por parametros si existe
		 	t = TaskRepository.lookTask(request.getParameter("task"));//En el caso de que exista mostraran los valores
		}else{//En el caso de no existir nos mostrara el error correspondiente
			session.setAttribute("error", "Error. This task does not exist");
		}
	
		 %>
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <div class="h1 fw-light">Info Task</div>        
			          </div>
			          <form>
			          <%if(t!=null) {%>
			            <div class="form-floating mb-3">
			              <label for="task">Task:</label>
			              <input class="form-control" name="task" type="text" value='<%=t.getTask()%>' readonly>
			            </div>
			            <div class="form-floating mb-3">
			              <label for="task">Sex:</label>
			              <input class="form-control" name="sex" type="text" value='<%=t.getSex()%>' readonly>
			            </div>
			             <%
			      		if(session.getAttribute("error") != null){//En el caso de que no exista se muestra el valor y da la opcion al usuario de volver a la lista de tareas
			      		%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
			            	<a href="listTasks.jsp"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Return list</button></a>
			       		<%}session.removeAttribute("error");//Borramos la session para que no arrastre errores
			       		%>
			            <div class="d-grid">
			              <button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="editSubmit">Edit</button>
			              <button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="deleteSubmit">Delete</button>			            
			             </div>
			            <% } %>
			          </form>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>	
			 <%
			if(request.getParameter("editSubmit") != null){//En el caso de dar la opcion de editar nos llevara al jsp de editar
				response.sendRedirect("editTask.jsp?task="+request.getParameter("task"));
			}else if(request.getParameter("deleteSubmit") != null){//En el caso de dar la opcion de borrar nos llevara al jsp de editar
				response.sendRedirect("deleteTask.jsp?task="+request.getParameter("task"));
			}
			 
			%>
</body>
</html>