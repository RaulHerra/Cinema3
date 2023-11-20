<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jacaranda.repository.DbRepository"%>    
<%@ page import="com.jacaranda.model.Projection"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Projections' list</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">

</head>

<body>


<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>
<% 
		//A list variable with Projections is created with null value
		List<Projection> result = new ArrayList(0);

		try{
			//I get a list of the Projections from the data base
			result = DbRepository.findAll(Projection.class);
			
		}catch(Exception e) {
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
			return;
		}
	%>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Projection</th>
			</tr>
		</thead>
		<% for (Projection p: result){%>
				<tr>
					<td><%=p.getCinema()%></td>
	
					<!-- 
						TODO
						Tengo un problema al compilar que me dice que la clase List no existe
						java.lang.ClassNotFoundException: List
						fecha de comentario: 20/11/2023
					 -->
				
					<td>
						<form action="infoProjection.jsp">
							<input type="text" name="ProjectionName" value='<%=p.getCinema()%>' hidden>
							<button class="btn btn-primary" type="submit" name="info"> details </button>
						</form>
					</td>
				</tr>
		<% }%>
	</table>


</body>

</html>






