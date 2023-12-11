<html>
<head>
</head>
	<body>
		<nav class="navbar navbar-expand-lg sticky-top bg-light">
		
		
		 <div class="container-fluid">
		  <a class="navbar-brand  " href="/CinemaTeam/index.jsp">Home</a>
		   <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      		<span class="navbar-toggler-icon"></span>
		  </button>
		
		  <div class="collapse navbar-collapse" id="navbarNav">
		 
		    <ul class="navbar-nav">
		    
	         <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            	Films
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          
				     <li>
		       			 <a class="dropdown-item " href="/CinemaTeam/film/listFilms.jsp">List films</a>
				     </li>
				     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
			            <li>
			       			 <a class="dropdown-item " href="/CinemaTeam/film/addFilm.jsp">Add film</a>
					    </li>
					    
			            <li>
			        		<a class="dropdown-item " href="/CinemaTeam/character/addCharacterFilm.jsp">Add character to Film</a>
					    </li>
					  <% } %>				    
		          </ul>
	      	 </li>				      
		      
	         <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            	Character
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				     <li>
		        		<a class="dropdown-item " href="/CinemaTeam/character/listCharacters.jsp">List characters</a>
				     </li>
				     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
			            <li>
			       			 <a class="dropdown-item " href="/CinemaTeam/character/addCharacter.jsp">Add character</a>
					    </li>
			            <li>
			        		<a class="dropdown-item " href="/CinemaTeam/character/addCharacterFilm.jsp">Add character to Film</a>
					    </li>
				    <% } %>
				  </ul>
	      	 </li>				      
		      
	         <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            Task
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          
				     <li>
		       		 <a class="dropdown-item " href="/CinemaTeam/task/listTasks.jsp">List tasks</a>
				     </li>
				     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
		            <li>
		        		<a class="dropdown-item " href="/CinemaTeam/task/addTask.jsp">Add task</a>
				    </li>
				    <% } %>
		          </ul>
	      	 </li>		      
		      
	          <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            Cinema
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          
				     <li>
				     	<a class="dropdown-item " href="/CinemaTeam/cinema/listCinemas.jsp">List cinemas</a>
				     </li>
				     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
		            <li>
				    	<a class="dropdown-item " href="/CinemaTeam/cinema/addCinema.jsp">Add cinema</a>
				    </li>
				    <% } %>
		          </ul>
	      	 </li>
		      
         	 <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            Projection
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          
				     <li>
				     	<a class="dropdown-item " href="/CinemaTeam/projection/listProjections.jsp">List projections</a>
				     </li>
				     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
		            <li>
				    	<a class="dropdown-item " href="/CinemaTeam/projection/addProjection.jsp">Add projection</a>
				    </li>
				    <% } %>
				     <li>
				     	<a class="dropdown-item " href="/CinemaTeam/projection/listActualProjections.jsp">List actual projections</a>
				     </li>
		          </ul>
	      	 </li>
	      	 
	          <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            Room
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          
				     <li>
				     	<a class="dropdown-item " href="/CinemaTeam/room/listRooms.jsp">List room</a>
				     </li>
				     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
		            <li>
				    	<a class="dropdown-item " href="/CinemaTeam/room/addRoom.jsp">Add room</a>
				    </li>
				    <% } %>
		          </ul>
	      	 </li>
	      	 
		     <% if(session.getAttribute("username")!=null && session.getAttribute("userRole").equals("ADMIN")){ %>
	      	 <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            	Users
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		          
				     <li>
		       			 <a class="dropdown-item " href="/CinemaTeam/user/listUsers.jsp">List Users</a>
				     </li>
		          </ul>
	      	 </li>			
			 <% } %>				    
	      	 	  
		    </ul>
		  </div>
		   <% if(session.getAttribute("username")!=null){ %>
		          <a href="/CinemaTeam/myPurchases.jsp" class="my">My Purchases</a>
			 <% } %>		
		  
		  	<% if(session.getAttribute("username")==null){ %>
			     <form class="d-flex" action="/CinemaTeam/login.jsp">
				    <button class="btn btn-outline-success me-2" type="submit">Log in</button>				  
				  </form>
		  	<% }else{ %>
		  		<a href="/CinemaTeam/myAccount.jsp" class="my">My account</a>
			  	<form class="d-flex" action="/CinemaTeam/index.jsp">
				    <button class="btn btn-outline-success me-2" name="logout" type="submit">Log out</button>				  
				</form>
		  	<% } %>
		  </div>
		</nav>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	</body>
</html>