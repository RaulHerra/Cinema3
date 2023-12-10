<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.model.User"%>
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

<title>List of Users</title>
</head>
<body>
	<%@include file="../nav.jsp"%>
	<% 
	try{
		String user = session.getAttribute("username").toString();
		if(!session.getAttribute("userRole").equals("ADMIN")){
			response.sendRedirect("../index.jsp");
			return;
		}
	}catch(Exception e){
		response.sendRedirect("../login.jsp");
		return;
	}
	    List<User> result = null;
        try{
            result = DbRepository.findAll(User.class);
        }catch(Exception e){
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
							<h1 align="center">List of Users</h1>
							<br>
							<table class="table tableLeft">
							<tr>
								<th>Username</th>
								<th>Owner</th>
								<th></th>
							</tr>
								<% for (User User: result){//Recorremos la lista%>
								<tr>
									<td><%=User.getUsername()%></td>
									<td><%=User.getName()%> <%=User.getSurname()%></td>

									<td>
										<form action="editUser.jsp">
											<%//Asignamos un boton para ver los detalles de cada usuario %>
											<input type="text" name="User" value='<%=User.getUsername()%>'
												hidden>
											<button class="btn btn-primary" type="submit">Edit</button>
										</form>
									</td>
								</tr>
								<% } %>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>