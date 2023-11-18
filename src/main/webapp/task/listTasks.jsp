<%@page import="com.jacaranda.repository.DbRepository"%>
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