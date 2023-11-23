<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Task"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info Task</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
		<%@include file="../nav.jsp"%>
	
	<%
		Task t =null;
	String error = null;
		try{	
			if(request.getParameter("task") != null && DbRepository.find(Task.class, request.getParameter("task")) != null){//Lo primero antes de añadir una tarea comprobamos que existe
			 	t = DbRepository.find(Task.class, request.getParameter("task"));//En el caso de que exista mostraran los valores
			}else{//En el caso de no existir nos mostrara el error correspondiente
				error = "Error. This task does not exist";
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
			            <h1>Info Task</h1>   
			          </div>
			          <form>
			          <%if(t!=null) {%>
			            <div class=" mb-3">
			              <label for="task" class="form-label">Task</label>
			              <input class="form-control" name="task" type="text" value='<%=t.getTask()%>' readonly>
			            </div>
			            <div class=" mb-3" >
			              <label for="task" class="form-label">Sex</label>
			              <input class="form-control" name="sex" type="text" value='<%=t.getSex()%>' readonly>
			            </div>
			              <button class="btn btn-warning " id="submitButton" type="submit" name="editSubmit">Edit</button>
			              <button class="btn btn-danger " id="submitButton" type="submit" name="deleteSubmit">Delete</button>			            
			            <% } %>
			             <%
			      		if(error!= null){//En el caso de que no exista se muestra el valor y da la opcion al usuario de volver a la lista de tareas
			      		%>
			            	<div class="textAreaInfoError" ><%=error%></div>
			            	<a href="listTasks.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
			       		<%};//Borramos la session para que no arrastre errores
			       		%>
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