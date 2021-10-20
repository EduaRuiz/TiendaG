<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*" %>
<!doctype html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login TiendaG</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    
    <%String mensaje = (String)request.getParameter("mensaje");%>

  </head>
  <body class="text-center">
    <section class="vh-100" style="background-color: #212529;">
      <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col col-xl-8">
            <div class="card" style="border-radius: 1rem;">
              <div class="row g-0">
                <div class="col-md-6 col-lg-5 d-none d-md-block">
                  <img src="./Imagenes/login01.jpg" alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;"/>
                </div>
                <div class="col-md-6 col-lg-7 d-flex align-items-center">
                  <div class="card-body p-4 p-lg-5 text-black">
                    <form action="./Usuarios" method="post">
                      <img class="mb-4" src="Imagenes/account_circle_black_48dp.svg" alt="Login" width="72px" height="72px">
                      <h1 class="h3 mb-3 font-weight-normal text-center">TiendaG</h1>
                      <input type="text" class="form-control mb-2" aria-describedby="emailHelp" name="usuario" value="" placeholder="Usuario" required autofocus>
                      <input type="password" class="form-control mb-2" aria-describedby="emailHelp" name="password" value="" placeholder="Contrase&ntilde;a" required>
                      <div class="mb-3 checkbox">
                        <input type="checkbox" class="form-check-input form-check-input-checked-dark">
                        <label class="form-check-label">Recordarme</label>
                      </div>
                      <div class="mx-auto container ">      
                        <button type="submit" class="btn btn-dark" name="opcion" value="ingresar">Ingresar</button>
                        <button type="reset" class="btn btn-secondary">Limpiar</button>
                      </div>                     	
                      <div class="mt-sm-1 mt-3">
                        <a href="#">Olvi&oacute; su contrase&ntilde;a?</a>
                      </div>                      
                    </form>  
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

  <!--MENSAJES-->
  <!--Agregado-->
  <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="incorrecto" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="toast-header text-white bg-danger">
        <strong class="me-auto">Incorrecto</strong>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
      <div class="toast-body text-start">Usuario y/o contrase&ntilde;a incorrectos</div>
    </div>
  </div>

  <!--Bootstrap5 JS-->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script> 
	
  <script type="text/javascript">
    let mensaje = '<%=mensaje%>';
    if(mensaje == "Wrong"){
      new bootstrap.Toast(document.getElementById('incorrecto')).show();
    }else{
      console.log(mensaje);
    }
  </script>
  </body>
</html>