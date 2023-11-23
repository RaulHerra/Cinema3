<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.model.Task"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

<title>List Task</title>
</head>
<body>
	<%@include file="../nav.jsp"%>
	<% //Inicializamos una lista con todas las tareas
        List<Task> result = null;
        try{
            result = DbRepository.findAll(Task.class);
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
							<h1 align="center">List of task</h1>
							<br>
							<table class="table tableLeft">
								<% for (Task t: result){//Recorremos la lista%>
								<tr>
									<td><%=t.getTask()%></td>


									<td>
										<form action="infoTask.jsp">
											<%//Asignamos un boton para ver los detalles de cada tarea %>
											<input type="text" name="task" value='<%=t.getTask()%>'
												hidden>
											<button class="btn btn-primary " type="submit">Info</button>
										</form>
									</td>
								</tr>
								<% }%>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>