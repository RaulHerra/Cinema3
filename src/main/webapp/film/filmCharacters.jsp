<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.Work" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<%@ page import="org.hibernate.Hibernate" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Film</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>	

<%
	
	Film f = null;
	String error = null;
	try{
		if(request.getParameter("filmCharacters") == null){
			error = "Error: character not found in uri";
		}else{
			f = DbRepository.find(Film.class, request.getParameter("filmCharacters"));
			if(f == null){
				error = "Error: the selected character doesn't exist";		
			}
		}
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
		return;
	}

%>

	<table class="table">
		<% if(f != null){ %>
		<thead>
		
			<tr>
			
				<th scope="col">Character's name</th>
				<th scope="col">Character's rol</th>
			
			</tr>
		
		</thead>
	
		<tbody>
			
			<%for(Work w : f.getWorks()){ %>
			
				<tr>
				
					<td scope="col"><%=w.getCharacter().getCharacterName() %></td>
					<td scope="col"><%=w.getTask().getTask()%></td>
				
				</tr>
				
			<%} %>
		
		</tbody>
	
	</table>
	<%}else if(error != null){%>
		<br>
    	<div class="textAreaInfoError" ><%=error%></div>
       	<a href="./listFilms.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
	<%}%>
</body>
</html>