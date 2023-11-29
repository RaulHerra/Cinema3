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
		String user = session.getAttribute("user").toString();
		if(!session.getAttribute("role").equals("ADMIN")){
			response.sendRedirect("../signup.jsp");
			return;
		}
	}catch(Exception e){
		response.sendRedirect("../login.jsp");
		return;
	}
	String error = null;
	try{
		/*Este if comprueba que el parametro no es nulo y si no lo es busco un cine con el parametro
		en el caso de que devuelva un cine debe dar un error de que ya haya un cine con ese nombre*/
		if(request.getParameter("cinema") != null && DbRepository.find(Cinema.class, request.getParameter("cinema")) != null){
			error = "Error there is already a cinema with the name entered";
		}else{//Si no hay ningun error	
			try{
				if(request.getParameter("submit") != null){ //Cuando guarde el cine
					Cinema cinema = new Cinema(request.getParameter("cinema")
							,request.getParameter("cinemaCity")
							,request.getParameter("cinemaAddress"));//Creo un cine con los datos que ha introducido
					DbRepository.addEntity(cinema);//Y lo añado
			}
			}catch(CinemaException e){
				error = e.getMessage(); //En el caso de que haya un error añadiendo lo guardo en error
			}
		}
	}catch(Exception e){ //En el caso de que haya un fallo con la base de datos lo mandamos a la pagina de error con el error correspondiente
		response.sendRedirect("../error.jsp?msg=Failed to connect to database");
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
		   			<label for="cinema" class="form-label">Cinema</label>
		   			<input type="text" class="form-control" id="cinema" name="cinema" placeholder="Enter cinema name" required>
		           </div>
		
		           <div class=" mb-3">
		            <label for="cinemaCity" class="form-label">Cinema city</label>
		   			<input type="text" class="form-control" id="cinemaCity" name="cinemaCity" placeholder="Enter cinema city" required>
		           </div>
		
		           <div class=" mb-3">
					<label for="cinemaAddress" class="form-label">Cinema address</label>
		   			<input type="text" step="1" class="form-control" id="cinemaAddress" name="cinemaAddress" placeholder="Enter cinema address" required>
		           </div>
		            <%
		            //Cuando el error no sea nulo lo muestro
		            if(error != null){%>
		            	<div class="textAreaInfoError"><%=error%></div>
		            <%
		            //Cuando lo envie y no haya error muestro el mensaje de éxito
		            }else if(request.getParameter("submit") != null && error == null){%>
		            	<div class="textAreaInfoSuccesfull " >Cinema created successfully!</div>
		            <%} 
		            %>
	            <!-- Submit button -->
	  
	              	<button class="btn btn-success " id="submitButton" type="submit" name="submit">Save</button>
	              	<%if(request.getParameter("submit") != null && error == null){
	              	//Cuando lo envie y no haya error muestro el botón para que vea el cine que acaba de crear%>
				     	<a href="infoCinema.jsp?cinema=<%=request.getParameter("cinema")%>"><button class="btn btn-primary" id="submitButton" type="button">Show cinema</button></a>
	              	<%}%>

	          </form>
	          <!-- End of contact form -->
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>