<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<%@ page import="com.jacaranda.repository.CharacterRepository" %>
<%@ page import="com.jacaranda.repository.FilmRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<!-- ======= LINKS BOOTSTRAP NAVBAR ======= -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<!-- ======= LINKS BOOTSTRAP FORM ======= -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

<%

	Character c = null;
	List<Film>films = new ArrayList<>();

	try{
		 c = CharacterRepository.getCharacter(request.getParameter("characterFilms"));
		 films = c.getFilms();
 	}catch(Exception e){
		session.setAttribute("error", "Error: the character that you selected doesn't exist");
		return;
	}

%>

<table class="table">
	
	<thead>
	
		<tr>
		
			<td>Title</td>
			<td>Release year</td>
			<td>Character's rol</td>
			
		</tr>
	
	</thead>
	
	<tbody>
	
		<%for(Film f : films){%>
			<tr>
				<td><%=f.getTitleP()%></td>
				<td><%=f.getYearProduction() %></td>
				<td><%=c.getCharacterName() %></td>
			</tr>
		<%}%>
	</tbody>
	
</table>

</body>
</html>