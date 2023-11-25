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
<title>List of characters
</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

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
							<h1 align="center">List of characters</h1>
							<br>
							<table class="table tableLeft">
								<!-- With the list full of the Characters from the database, we go throught all of it using a For loop. 
								For every Character, it will create a row and two columns. 
								The first column will have the Character's name, and the second column will contain 
								a hidden input, and a button that redirects to the "Info Character" page. 
								
								The hidden input, that stays with the button, has the name of the Character of its own in the "value"
								When you press the button, it will send the value to the "infoCharacter" page. It will be used there
								to get that specific character using the "getCharacter()" method, and show the other fields of 
								the Character.
								 -->
								<%
								for (Character character : result) {
								%>
								<tr>
									<td><%=character.getCharacterName()%></td>

									<td>
										<a href="infoCharacter.jsp?characterName=<%=character.getCharacterName()%>"><button class="btn btn-primary " type="submit" name="info">
											Info</button></a>
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






