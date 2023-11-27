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
	<%@include file="../nav.jsp"%>
	<h1 class="welcome">WELCOME</h1>
	<div class="textWelcome text-center">This is the cinema of the group of Gonzalo, Jesús, Francisco Javier and Raúl, have a good time!</div>
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