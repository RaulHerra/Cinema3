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
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	Task t = null;
	String error = null;
	try{		
		if(request.getParameter("task") != null && DbRepository.find(Task.class, request.getParameter("task")) != null){//Lo primero antes de añadir una tarea comprobamos que existe
			error = "Error. Repeated primary key";

		}else{	
			try{
				if(request.getParameter("save") != null){//En el caso de que no exista se crea
					t = new Task(request.getParameter("task"),request.getParameter("sex"));
					DbRepository.addEntity(t);				}
			}catch(TaskException e){
				error = e.getMessage();
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
				<h1>Add Task</h1>   
	          </div>
	          <form id="addtask" action="addTask.jsp" method="get">
	            <div class="mb-3">
	              <label for="task" class="form-label">Task</label>
	              <input class="form-control" id="task" name="task" type="text" placeholder="Enter task" required>
	            </div>
	            <div class=" mb-3">
	              <label for="sex" class="form-label">Sex</label>
	              <input class="form-control" id="sex" name="sex" type="text"  pattern="[H,M,O]" placeholder="Enter task's sex (H, M, or O)" required>
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
	              if(request.getParameter("save") != null && error == null && t!= null){%>
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