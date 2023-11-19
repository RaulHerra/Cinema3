<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.mysql.cj.xdevapi.DbDoc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Characters' list </title>

<!-- ======= LINKS BOOTSTRAP NAVBAR ======= -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<!-- ======= LINKS BOOTSTRAP FORM ======= -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

</head>


<body>


<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>
<% 
		//A list variable with Characters is created with null value
		List<Character> result = null;

		try{
			//I get a list of the characters from the data base
			result = DbRepository.findAll(Character.class);
			
		}catch(Exception e) {
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
			return;
		}
	%>

	<table class="table">
		<thread>
			<tr>
				<th scope="col">Name</th>
			</tr>
		</thread>
		
		<!-- With the list full of the Characters from the database, we go throught all of it using a For loop. 
		For every Character, it will create a row and two columns. 
		The first column will have the Character's name, and the second column will contain 
		a hidden input, and a button that redirects to the "Info Character" page. 
		
		The hidden input, that stays with the button, has the name of the Character of its own in the "value"
		When you press the button, it will send the value to the "infoCharacter" page. It will be used there
		to get that specific character using the "getCharacter()" method, and show the other fields of 
		the Character.
		 -->
		<% for (Character c: result){%>
				<tr>
					<td><%=c.getCharacterName()%></td>

					<td>
						<form action="infoCharacter.jsp">
							<input type="text" name="characterName" value='<%=c.getCharacterName()%>' hidden=>
							<button class="btn btn-primary btn-lg" type="submit" name="info"> Info </button>
						</form>
					</td>
				</tr>
		<% }%>
	</table>


</body>

</html>






