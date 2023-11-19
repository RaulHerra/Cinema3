<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.jacaranda.model.CharacterFilm" %>
<%@ page import="com.jacaranda.model.Film" %>
<%@ page import="java.util.*" %>
<%@ page import="com.jacaranda.repository.CharacterRepository" %>
<%@ page import="com.jacaranda.repository.FilmRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	
	Film f = null;
	
	try{
		f = FilmRepository.getFilm(request.getParameter("filmCharacters"));
	}catch(Exception e){
		session.setAttribute("error", "Error: the character that you selected doesn't exist");
		return;
	}

%>

<table>

<thead>

	<tr>
	
		<td>Character's name</td>
		<td>Character's rol</td>
	
	</tr>

</thead>

<tbody>
	
	<%for(CharacterFilm cf : f.getCharacters()){ %>
	
		<tr>
		
			<td><%=cf.getCharacter().getCharacterName() %></td>
			<td><%=cf.getCharacter().getCharacterSex() %></td>
		
		</tr>
		
	<%} %>

</tbody>

</table>
</body>
</html>