<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.jacaranda.model.Character" %>
<%@ page import="com.jacaranda.repository.CharacterRepository" %>
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
<nav class="navbar navbar-expand-lg navbar-light bg-primary ">
	<a class="navbar-brand text-white" href="../index.jsp">Home</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	  <span class="navbar-toggler-icon"></span>
	</button>
	
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	  <ul class="navbar-nav mr-auto">
	    <li class="nav-item">
	      <a class="nav-link text-white" href=".././film/addFilm.jsp">Add film</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href=".././film/listFilms.jsp">List films</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href="./addCharacter.jsp">Add character</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href="./listCharacters.jsp">List characters</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href=".././task/addTask.jsp">Add task</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href=".././task/listTasks.jsp">List tasks</a>
	    </li>
	  </ul>
	</div>
</nav>



<% 
		//A list variable with Characters is created with null value
		List<Character> result = null;


		try{
			//I get a list of the characters from the data base
			result = CharacterRepository.getCharacters();
			
		}catch(Exception e) {
			//It shouldn't have errors, even if there is no characters in the data base. 
			//It just shows whatever you have in the Character table from the data base, 100 or 0 characters.
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






