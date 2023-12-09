<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="./style/style.css">
</head>
<body>

<% 
	//when the user click on log out, this will trigger
	if(request.getParameter("logout")!=null){
		session.removeAttribute("username");
		session.removeAttribute("userRole");
	}
%>
	<%@include file="../nav.jsp"%>
	<h1 class="welcome">WELCOME</h1>
	<div class="textWelcome text-center">This is the cinema of the group of Gonzalo, Jesús, Francisco Javier and Raúl. <br> Modified By Raúl Herrá for Sprint 3</div>
	
	<div align="center">
	<% if(session.getAttribute("username")==null){ %>
	<div>It looks like you don't have log in yet <br> Create an account?</div>
     <form action="/CinemaTeam/signup.jsp">
	    <button class="btn btn-outline-success me-2" type="submit">Sign up</button>				  
	 </form>
  	<% } %>
	</div>
	
	<div class="slider-frame">
        <ul>
            <li><img src="./img/imagen1.jpg"></li>
            <li><img src="./img/imagen2.jpg"></li>
            <li><img src="./img/imagen3.jpg"></li>
            <li><img src="./img/imagen4.jpg"></li>
        </ul>
    </div>
</body>
</html>