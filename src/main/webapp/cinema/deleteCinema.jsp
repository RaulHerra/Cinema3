<%@page import="com.jacaranda.model.Cinema"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Cinema</title>
<!-- ======= LINKS BOOTSTRAP ======= -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- ======= LINK CSS ======= -->
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="../nav.jsp"%>	
	<%	
		Cinema cinema = null; 
		try{
			if(DbRepository.find(Cinema.class, request.getParameter("cinema")) != null){
				cinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
			}else{
				session.setAttribute("error", "Error there is no cinema with the name entered");
			}
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Imposible acceder a la base de datos");
			return;
		}%>
			<div class="container px-5 my-5">
			  <div class="row justify-content-center">
			    <div class="col-lg-8">
			      <div class="card border-0 rounded-3 shadow-lg">
			        <div class="card-body p-4">
			          <div class="text-center">
			            <h1>Delete Cinema</h1>
			          </div>
					
			          <form>
			          <%if(cinema != null){%>
				           <div class=" mb-3">
				   				<label for="exampleInputEmail1" class="form-label">Cinema</label>
				   				<input type="text" class="form-control" id="cinema" name="cinema" value="<%=cinema.getCinema()%>" required readonly>
				           </div>
				
				           <div class=" mb-3">
				           		<label for="exampleInputEmail1" class="form-label">Cinema city</label>
				   				<input type="text" class="form-control" id="cinemaCity" name="cinemaCity" value="<%=cinema.getCityCinema()%>" required readonly>
				           </div>
				
				           <div class=" mb-3">
								<label for="exampleInputEmail1" class="form-label">Cinema address</label>
				   				<input type="text" step="1" class="form-control" id="cinemaAddress" name="cinemaAddress" value="<%=cinema.getAddressCinema()%>" required readonly>
				           </div>
			            <%}%>
			            <%
			           	/*Cuando el valor de la sessión no se nulo es que se ha producido un error entonces muestro
			           	el textarea que tengo abajo con el valor de la sesión que será el mensaje de error correspondiente*/
			            if(session.getAttribute("error") != null){%>
			            	<textarea class="textAreaInfoError ml-25" readonly><%=session.getAttribute("error")%></textarea> <br>
			            <%/*Y aqui si se ha enviado el submit y en valor de la session es nulo significa que se ha borrado correctamente, entoces muestro
			            el mensaje de éxito*/
			            }else if(request.getParameter("submit") != null && session.getAttribute("error") == null){%>
			            	<textarea class="textAreaInfoSuccesfull ml-25" readonly>Cinema deleted successfully!</textarea> <br>
			            <%}
			            %>
			            	
			            <!-- Submit button -->
							<%
							if(request.getParameter("delete") == null && request.getParameter("submit") == null && session.getAttribute("error") == null){ /*Esto lo hago para que cuando pulse confirm se oculte el confirm ya que no será nulo*/%>
				            	<button class="btn btn-danger" id="submitButton" type="submit" name="delete">Are you sure you want to delete it?</button>
							<%}else if(request.getParameter("delete") != null){%>
								<button class="btn btn-danger" id="submitButton" type="submit" name="submit">Confirm</button>
				            	<a href="./infoCinema.jsp?cinema=<%=request.getParameter("cinema")%>"><button class="btn btn-primary  " id="submitButton" type="button" name="undo">Undo</button></a>
							<%}else if(session.getAttribute("error") != null){%>
								<a href="./listCinemas.jsp"><button class="btn btn-primary" id="submitButton" type="button">Rety</button></a>
							<%}%>
							
							<%if(request.getParameter("submit") != null){
								DbRepository.deleteEntity(cinema);%>

								<a href="./listCinemas.jsp"><button class="btn btn-primary " id="submitButton" type="button">Return list</button></a>
							<%}session.removeAttribute("error");%>
			          </form>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
</body>
</html>