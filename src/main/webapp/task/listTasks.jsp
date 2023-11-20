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
    		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
    		return;
        }
    %>

    <table class="table">
        <thead>
            <tr>
                <th scope="col">Task</th>
            </tr>
        </thead>
        <% for (Task t: result){//Recorremos la lista
        %>
                <tr>
                    <td><%=t.getTask()%></td>
                    

                    <td>
                        <form action="infoTask.jsp"><%//Asignamos un boton para ver los detalles de cada tarea %>
                            <input type="text" name="task" value='<%=t.getTask()%>' hidden>
                            <button class="btn btn-primary " type="submit">Info</button>
                        </form>
                    </td>
                </tr>
        <% }%>
    </table>
</body>
</html>