<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- ======= LINKS BOOTSTRAP ======= -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="./style/style.css">
<title>Edit my account</title>
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%	
	
	//We recover the user to check if it exists
	User user = null;
	boolean modified = false;
	try{
		String userSession = session.getAttribute("username").toString();
		user = DbRepository.find(User.class, userSession);
		
		if(user==null){
			response.sendRedirect("./error.jsp?msg=user%20"+userSession+"%20not%20found");
			return;
		}else{
			//if the admin is trying to modify an user
			if(request.getParameter("submit")!=null){
				//We set the new role (if it didn't change, nothing happens)
				user.setEmail(request.getParameter("email"));
				
				//If the password input is empty, we don't modificate the password
				if(!request.getParameter("password").trim().equals("")){
					user.setPassword(request.getParameter("password"));
				}
				
				DbRepository.editEntity(user);
				
				modified = true;
			}
		}
		
	}catch(Exception e){
		response.sendRedirect("./error.jsp?msg=Not%20user%20found");
		return;
	}
	%>
	<div class="container px-5 my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card border-0 rounded-3 shadow-lg">
					<div class="card-body p-4">
					<% if(!modified){ %>
						<form>
						<div class="text-center">
							<h1>Edit User</h1>
						</div>
						<div>
						    <div class=" mb-3">
							    <label for="username" class="form-label">Username</label>
							    <input type="text" class="form-control" id="User" name="User" value="<%= user.getUsername() %>" placeholder="Username" required readonly>
							    <small></small>
							</div>
						  </div>
						  
						 <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Email</label>
					    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" placeholder="Email" required>
					    <small></small>
					</div>
				  </div>
				    
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Name</label>
					    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" placeholder="Your name" required readonly>
					    <small></small>
					</div>
				  </div>
				  
				  <div>
				    <div class=" mb-3">
					    <label for="username" class="form-label">Surnames</label>
					    <input type="text" class="form-control" id="surname" name="surname" value="<%= user.getSurname() %>" placeholder="Your surnames" required readonly>
					    <small></small>
					</div>
				  </div>
				    
				  <div>
				    <div class=" mb-3">
					    <label for="password" class="form-label">New Password</label>
					    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
					    <small></small>
					    <small class="advice">Empty to not change</small>
					</div>
				  </div>
				  
				  <div>
				    <div class=" mb-3">
					    <label for="repassword" class="form-label">Old Password</label>
					    <input type="password" class="form-control" id="repassword" name="repassword" placeholder="Password">
					    <small></small>
					    <small class="advice">Empty to not change</small>
					</div>
				  </div>
				  
					<button class="btn  btn-success" id="formButton" type="submit" name="submit"> Modify account </button>
						</form>
						<% }else{ %>
						<div class="textAreaInfoSuccesfull " >User <%= user.getUsername()%> edited successfully!</div>
					<% } %>
					<a href="./index.jsp"><button class="btn btn-info" id="submitButton" type="button">Return index</button></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="./javascript/myAccount.js"></script>
</body>
</html>