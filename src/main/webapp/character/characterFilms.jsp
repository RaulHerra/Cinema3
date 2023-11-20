<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="com.jacaranda.model.Work" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Character</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

	<%@include file="../nav.jsp"%>

<%

	Character c = null;

	try{
		 c = DbRepository.find(Character.class, request.getParameter("characterFilms")) ;
		 
 	}catch(Exception e){
		session.setAttribute("error", "Error: the character that you selected doesn't exist");
		return;
	}

%>

<table class="table">
	
	<thead>
		<tr>
			<td scope="col">Title</td>
			<td scope="col">Release year</td>
			<td scope="col">Character's rol</td>
		</tr>
	</thead>
	
	<tbody>
	
		<%for(Work w : c.getFilms()){%>
			<tr>
				<td scope="col"><%=w.getFilm().getTitleP()%></td>
				<td scope="col"><%=w.getFilm().getYearProduction()%></td>
				<td scope="col"><%=w.getTask().getTask()%></td>
			</tr>
		<%}%>
	</tbody>
	
</table>

</body>
</html>