<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Log in</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>
<!-- ======= INPUTS FORM ======= -->
<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <h1>Log in</h1>
	          </div>

				<form method="get" action="index.html">
				
				  <!-- Div of the input 'inputName' of the character's name  -->
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Username</label>
					    <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
					</div>
					
				  </div>
				  
				  
				  <!-- Div of the input 'inputNationality' of the character's nationality  -->
				  <div>
				    
				    <div class=" mb-3">
					    <label for="password" class="form-label">Password</label>
					    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
					</div>
					
				  </div>
				  			  
				  <!-- Div of the submit button and redirect to list button  -->
				  	
				  	<button class="btn  btn-success" id="submitButton" type="submit" name="submit"> Log in </button>			  
				  
			    </form>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>