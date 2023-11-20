<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Task"%>
<meta charset="UTF-8">
<title>Delete task</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	Task t =null;
	try{	
		if(request.getParameter("task") != null && DbRepository.find(Task.class, request.getParameter("task")) != null){//Comprueba la tarea pasada por parametros si existe
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
			            <h1>Delete Task</h1>
			          </div>
			           <%if(t != null){%>
			          <form  method="get">
			            <div class=" mb-3">
			              <label for="task" class="form-label">Task:</label>
			              <input class="form-control" name="task" type="text" value='<%=t.getTask()%>' readonly>
			            </div>
			            <div class=" mb-3">
			              <label for="task" class="form-label">Sex:</label>
			              <input class="form-control" name="sex" type="text" value='<%=t.getSex()%>' readonly>
			            </div>
			             <%}%>
			             
			            <%//Si hay errores se muestran
			            if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea> <br>
			            <%//En el caso de que no haya errores y se le de a confirmar se muestra el mensaje de exito
			            }else if(request.getParameter("comfirmSubmit") != null && session.getAttribute("error") == null){%>
			            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Task delete successfully!</textarea> <br>
			            <%} 
			            %>
			            
			            	<%if(request.getParameter("deleteSubmit")==null && request.getParameter("comfirmSubmit")==null && session.getAttribute("error") == null){ //Preguntamos si se desea eliminar%>
			              		<button class="btn btn-danger " id="submitButton" type="submit" name="deleteSubmit">Are you sure you want to delete it?</button>
				            <%}if(request.getParameter("deleteSubmit")!=null){//Se muestra el boton para confirmar%>
				            	<button class="btn btn-danger " id="submitButton" type="submit" name="comfirmSubmit">Confirm</button>
				            	<a href="infoTask.jsp?task=<%=request.getParameter("task")%>"><button class="btn btn-primary " id="submitButton" type="button" name="undo">Undo</button></a>	
				            <%} else if(request.getParameter("comfirmSubmit")!=null || session.getAttribute("error") != null){//Una vez eliminado se da la opcion de volver a la lista de las demas tareas%>
				            	<a href="listTasks.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return List</button></a>
				            <%}session.removeAttribute("error");//Borramos la session para que no arrastre errores%>
				            
			          </form>	
			        </div>
			      </div>
			    </div>
			  </div>
			</div>	
		<%//Si se da a confirmar se borra la tarea definitivamente
	if(request.getParameter("comfirmSubmit")!=null){
		try{
			DbRepository.deleteEntity(t);
		}catch(Exception e){
			
		}
	}
		%>
</body>