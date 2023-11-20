<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Info Cinema</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%		
		Cinema c = null; 
		try{
			if(DbRepository.find(Cinema.class, request.getParameter("cinema")) != null){
				c = DbRepository.find(Cinema.class, request.getParameter("cinema"));
			}else{
				session.setAttribute("error", "Error there is no cinema with that name");
			}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
			return;
		}
%>
	<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <h1>Info Cinema</h1>
			          </div>
			          <form>
			          <%if(c != null){ %>
			            <div class=" mb-3">
			    			<label for="exampleInputEmail1" class="form-label">Cinema</label>
			    			<input type="text" class="form-control" id="cinema" name="cinema" value='<%=c.getCinema()%>'readonly required>
			            </div>
			
			            <div class=" mb-3">
			                <label for="exampleInputEmail1" class="form-label">Cinema city</label>
			    			<input type="text" class="form-control" id="cinemaCity" name="cinemaCity" value="<%=c.getCityCinema()%>" readonly required>
			            </div>
			
			            <div class=" mb-3">
							<label for="exampleInputEmail1" class="form-label">Cinema address</label>
			    			<input type="text" step="1" class="form-control" id="cinemaAddress" name="cinemaAddress" value="<%=c.getAddressCinema()%>" readonly required>
			            </div>
			            

			            <!-- Submit button -->
			              	<button class="btn btn-warning " id="submitButton" value="edit" type="submit" name="edit">Edit</button>
			              	<button class="btn btn-danger " id="submitButton" value="delete" type="submit" name="delete">Delete</button>
			          </form>
			          <%}%>
			          <%
			      		if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea><br>
			            	<a href="./listCinemas.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
			       		<%}session.removeAttribute("error");%>
			          <!-- End of contact form -->
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
		<%
		
			if(request.getParameter("edit") != null){

				response.sendRedirect("editCinema.jsp?cinema="+c.getCinema());
			}else if(request.getParameter("delete") != null){
				response.sendRedirect("deleteCinema.jsp?cinema="+c.getCinema());
			}
		%>
</body>
</html>