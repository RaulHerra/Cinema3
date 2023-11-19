<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Task"%>
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
	<%@include file="../nav.jsp"%>
	<%
		Task t =null;
		try{	
			if(request.getParameter("task") != null && DbRepository.find(Task.class, request.getParameter("task")) != null){//Lo primero antes de añadir una tarea comprobamos que existe
			 	t = DbRepository.find(Task.class, request.getParameter("task"));//En el caso de que exista mostraran los valores
			}else{//En el caso de no existir nos mostrara el error correspondiente
				session.setAttribute("error", "Error. This task does not exist");
			}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
			return;
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