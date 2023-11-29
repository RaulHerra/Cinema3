<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Task"%>
<%@page import="com.jacaranda.exception.TaskException"%>

<meta charset="UTF-8">
<title>Edit Task</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	try{
		String user = session.getAttribute("user").toString();
		if(!session.getAttribute("role").equals("ADMIN")){
			response.sendRedirect("../signup.jsp");
			return;
		}
	}catch(Exception e){
		response.sendRedirect("../login.jsp");
		return;
	}
	Task task = null;
	String error = null;
	try{
		if(request.getParameter("task") != null && DbRepository.find(Task.class, request.getParameter("task")) != null){//Lo primero antes de añadir una tarea comprobamos que existe
			 task = DbRepository.find(Task.class, request.getParameter("task"));	//En el caso de que exista mostraran los valores
			 if(request.getParameter("comfirmSubmit")!=null){//Si se le da a confirmar se cambian y cargan los nuevos valores
				 try{
					 task = new Task(request.getParameter("task"),request.getParameter("sex"));
				 	 DbRepository.editEntity(task);
				 }catch(TaskException e){
					 error = e.getMessage();
				 }
			 }
		} else {//En el caso de no existir nos mostrara el error correspondiente
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
	            <h1>Edit Task</h1>  
	             
	          </div>
	          <%if(task != null){%>
	          <form id="editTask" action="editTask.jsp" method="get">
	            <div class=" mb-3">
	              <label for="task" class="form-label">Task</label>
	              <input class="form-control" name="task" type="text" value='<%=task.getTask()%>' readonly>
	            </div>
	            <div class=" mb-3">
	              <label for="task" class="form-label">Sex</label>
		          <input class="form-control" name="sex" type="text"  pattern="[H,M,O]" placeholder="Enter task's sex (H, M, or O)" value='<%=task.getSex()%>' required>
	            </div>
	            <%}%>
	            
	            <%//Si hay errores se muestran
	            if(error != null){%>
	            	<div class="textAreaInfoError " ><%=error%></div>
  					<a href="listTasks.jsp"><button class="btn btn-info" id="submitButton" type="button">Return to List</button></a>
	            	
	            	
	            <%//En el caso de que no haya errores y se le de a confirmar se muestra el mensaje de exito
	            }else if(request.getParameter("comfirmSubmit") != null && error == null){%>
	            	<div class="textAreaInfoSuccesfull" >Task edited successfully!</div>
	            <%}
	            %>
	            
	            	<%if(request.getParameter("comfirmSubmit")==null && error == null){%>
	              		<button class="btn btn-danger " id="submitButton" type="submit" name="comfirmSubmit">Confirm</button>
		            <%} if(request.getParameter("comfirmSubmit")!=null && error == null){//Si se le da a confirmar se dara la opcion de ver los detalles de la tarea acualizados%>
		            	<a href="infoTask.jsp?task=<%=request.getParameter("task")%>"><button class="btn btn-primary " id="submitButton" type="button">Show task</button></a>
		            <%}//Borramos la session para que no arrastre errores %>
	            
	          </form>	
	        </div>
	      </div>
	    </div>
	  </div>
	</div>	
</body>