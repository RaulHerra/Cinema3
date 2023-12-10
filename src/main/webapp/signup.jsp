<%@page import="com.jacaranda.validator.UserValidator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.User"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign up</title>

<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="./style/style.css">
</head>
<body>
<%
	String error = null;
	List<User> users = null;
	User log = null;
	String userReq = request.getParameter("username");
	
	if(userReq!=null){	
		//If the user already exists, we wont create another one
		if(DbRepository.find(User.class, userReq)==null){
			try{
				String emailReq = request.getParameter("email");
				String passReq = request.getParameter("password");
				String nameReq = request.getParameter("name");
				String surnameReq = request.getParameter("surname");
				
				//If the data is wrong, we don't create the user
				if(UserValidator.isValidEmail(emailReq) && 
				UserValidator.isValidName(userReq) &&
				UserValidator.isValidName(nameReq) &&
				UserValidator.isValidName(surnameReq) &&
				UserValidator.isValidPassword(passReq)){
					
					User newUser = new User(userReq, emailReq, passReq, nameReq, surnameReq, "USER");
					
					DbRepository.addEntity(newUser);
					
					response.sendRedirect("./login.jsp?newUserCreated=");
				}else{
					error = "Some data is wrong, please try again";
				}
				return;
				
			}catch(Exception e){
				error = "Something went wrong, try again";
			}
		}else{
			error = "Username "+ userReq +" already exists";
		}
	}
	
	
%>

<!-- ======= NAVBAR ======= -->
<%@include file="../nav.jsp"%>
<!-- ======= INPUTS FORM ======= -->
<div class="container px-5 my-5">
	  <div class="row justify-content-center">
	    <div class="col-lg-8">
	      <div class="card border-0 rounded-3 shadow-lg">
	        <div class="card-body p-4">
	          <div class="text-center">
	            <h1>Sign up</h1>
	          </div>
				<%if(error != null){%>
	            	<div class="textAreaInfoError" ><%=error%></div>
	            <%}%>
				<form method="get">
				  
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Username</label>
					    <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
					    <small></small>
					</div>
				  </div>
				  
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Email</label>
					    <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
					    <small></small>
					</div>
				  </div>
				    
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Name</label>
					    <input type="text" class="form-control" id="name" name="name" placeholder="Your name" required>
					    <small></small>
					</div>
				  </div>
				  
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Surnames</label>
					    <input type="text" class="form-control" id="surname" name="surname" placeholder="Your surnames" required>
					    <small></small>
					</div>
				  </div>
				    
				  <div>
				    <div class=" mb-3">
					    <label for="password" class="form-label">Password</label>
					    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
					    <small></small>
					</div>
				  </div>
				  
				  <div>
				    <div class=" mb-3">
					    <label for="password" class="form-label">Retype Password</label>
					    <input type="password" class="form-control" id="repassword" name="repassword" placeholder="Password again" required>
					    <small></small>
					</div>
				  </div>
				  	
				  	<button class="btn  btn-success" id="formButton" type="submit" name="submit"> Create account </button>	  
				  
			    </form>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
	<script type="text/javascript" src="./javascript/signup.js"></script>
</body>
</html>