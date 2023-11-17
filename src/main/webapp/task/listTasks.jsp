<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.TaskRepository"%>
<%@page import="com.jacaranda.model.Task"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>List Task</title>
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
	<% //Inicializamos una lista con todas las tareas
        List<Task> result = null;
        try{
            result = TaskRepository.getTasks();
        }catch(Exception e){

        }
    %>

    <table class="table">
        <thread>
            <tr>
                <th scope="col">Task</th>
               
            </tr>
        </thread>
        <% for (Task t: result){//Recorremos la lista
        %>
                <tr>
                    <td><%=t.getTask()%></td>
                    

                    <td>
                        <form action="infoTask.jsp"><%//Asignamos un boton para ver los detalles de cada tarea %>
                            <input type="text" name="task" value='<%=t.getTask()%>' hidden>
                            <button class="btn btn-primary btn-lg" type="submit">Info</button>
                        </form>
                    </td>
                </tr>
        <% }%>
    </table>
</body>
</html>