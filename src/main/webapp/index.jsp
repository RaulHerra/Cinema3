<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-primary">
  <a class="navbar-brand text-white" href="index.jsp">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link text-white" href="./film/addFilm.jsp">Add film</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./film/listFilms.jsp">List films</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./character/addCharacter.jsp">Add character</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./character/listCharacters.jsp">List characters</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./task/addTask.jsp">Add task</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./task/listTasks.jsp">List tasks</a>
      </li>
    </ul>
  </div>
</nav>


</body>
</html>