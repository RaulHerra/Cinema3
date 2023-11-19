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
<title>Add Task</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	Task t = null;
	try{		
		if(request.getParameter("task") != null && DbRepository.find(Task.class, request.getParameter("task")) != null){//Lo primero antes de añadir una tarea comprobamos que existe
			session.setAttribute("error", "Error. Repeated primary key");//Si existe mostrara el error
		}else{	
			try{
				if(request.getParameter("save") != null){//En el caso de que no exista se crea
					t = new Task(request.getParameter("task"),request.getParameter("sex"));
					DbRepository.addEntity(t);				}
			}catch(TaskException e){
				session.setAttribute("error", e.getMessage());//Si hay algun campo no válido se mostrara el error
			}
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
	            <div class="h1 fw-light">Add Task</div>        
	          </div>
	          <form id="addtask" action="addTask.jsp" method="post">
	            <div class="form-floating mb-3">
	              <label for="task">Task:</label>
	              <input class="form-control" name="task" type="text" placeholder="Add task." required>
	            </div>
	            <div class="form-floating mb-3">
	              <label for="task">Sex:</label>
	              <input class="form-control" name="sex" type="text" placeholder="Add sex: O-H-M" required>
	            </div>
	            <% //Mensaje de error que salta si anteriormente ha saltado alguna excepcion.Mostrara el mensaje correspondiente
	            if(session.getAttribute("error") != null){%>
	            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
	            <%//Mensaje de exito que salta en el caso de que se crea con exito la tarea
	            }else if(request.getParameter("save") != null && session.getAttribute("error") == null){%>
	            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Task created successfully!</textarea>
	            <%} 
	            %>
	            <div class="d-grid">
	              <button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="save">Save</button>
	              <%//Boton disponible para ver los detalles de la tarea creada.El boton aparece si se ha creado con exito la tarea
	              if(request.getParameter("save") != null && session.getAttribute("error") == null && t!= null){%>
				     	<a href="infoTask.jsp?task=<%=request.getParameter("task")%>"><button class="btn btn-primary btn-lg" id="submitButton" type="button">Show task</button></a>
	              <%}session.removeAttribute("error");//Borramos la session para que no arrastre errores
	              %>
	          
	            </div>
	          </form>	
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>