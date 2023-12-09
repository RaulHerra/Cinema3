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
<title>Log in</title>

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
	String passReq = request.getParameter("password");
	
	if(userReq!=null){
		try{
			users = DbRepository.findAll(User.class);
			log = DbRepository.find(User.class, userReq);
			
			if(log!=null){
				if(log.getPassword().equals(DigestUtils.md5Hex(passReq))){
					
					//if another session is opne, this will close it
					session.removeAttribute("username");
					session.removeAttribute("userRole");
					
					//Create session
					session.setAttribute("username", userReq);
					session.setAttribute("userRole", log.getRole());
					response.sendRedirect("./index.jsp");
					return;
				}else{
					error = "Incorrect password";
				}
			}else{
				error = "no user found";
			}
		}catch(Exception e){
			error = e.getMessage();
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
	            <h1>Log in</h1>
	          </div>
				<%if(error != null){%>
	            	<div class="textAreaInfoError" ><%=error%></div>
	            <%}%>
				<%if(request.getParameter("newUserCreated") != null){%>
	            	<div class="textAreaInfoSuccesfull" >User created, log in here!</div>
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
					    <label for="password" class="form-label">Password</label>
					    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
					    <small></small>
					</div>
				  </div>	
				  	<button class="btn  btn-success" id="formButton" type="submit" name="submit"> Log in </button>			  
				  
			    </form>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
	<script type="text/javascript" src="./javascript/login.js"></script>
</body>
</html>