<%@page import="com.jacaranda.exception.CinemaException"%>
<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Cinema</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>
	<%
	try{
		if(request.getParameter("cinema") != null && DbRepository.find(Cinema.class, request.getParameter("cinema")) != null){
			session.setAttribute("error", "Error there is already a cinema with the name entered");
		}else{	
			try{
				if(request.getParameter("submit") != null){
					Cinema cinema = new Cinema(request.getParameter("cinema")
							,request.getParameter("cinemaCity")
							,request.getParameter("cinemaAddress"));
					DbRepository.addEntity(cinema);
			}
			}catch(CinemaException e){
				session.setAttribute("error", e.getMessage());
			}
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
	            <h1>Add Cinema</h1>
	          </div>
	
	          <form method="get">
		           <div class=" mb-3">
		   			<label for="exampleInputEmail1" class="form-label">Cinema</label>
		   			<input type="text" class="form-control" id="cinema" name="cinema" placeholder="Enter cinema name" required>
		           </div>
		
		           <div class=" mb-3">
		               <label for="exampleInputEmail1" class="form-label">Cinema city</label>
		   			<input type="text" class="form-control" id="cinemaCity" name="cinemaCity" placeholder="Enter cinema city" required>
		           </div>
		
		           <div class=" mb-3">
					<label for="exampleInputEmail1" class="form-label">Cinema address</label>
		   			<input type="text" step="1" class="form-control" id="cinemaAddress" name="cinemaAddress" placeholder="Enter cinema address" required>
		           </div>
	            <%
	            if(session.getAttribute("error") != null){%>
	            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea>
	            <%
	            }else if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
	            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Cinema created successfully!</textarea>
	            <%} 
	            %>
	            <!-- Submit button -->
	            <div class="d-grid">
	              	<button class="btn btn-success " id="submitButton" type="submit" name="submit">Save</button>
	              	<%if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
				     	<a href="infoCinema.jsp?cinema=<%=request.getParameter("cinema")%>"><button class="btn btn-primary" id="submitButton" type="button">Show cinema</button></a>
	              	<%}session.removeAttribute("error");%>
	            </div>
	          </form>
	          <!-- End of contact form -->
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>