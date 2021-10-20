
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú principal</title>
    <link rel="shortcut icon" href="../Imagenes/icono.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="../estilo.css">

    <script src=""></script>
</head>
<body>
    <jsp:include page="../Menu/menu.jsp"></jsp:include>
    
    <h1>Bienvenido a la tienda "XXXXXX"</h1>
	  <div>
			<table class="tm">
				<tr>
					<td><a href="../Usuarios/usuarios.jsp"><button class="btn btn-primary">Usuarios</button></a></td> <!-- cambiar link de referencia para ir a servlet -->
					<td><a href="../Clientes/ClienteServlet?Listar=Listar"><button class="btn btn-primary">Clientes</button></a></td>
				</tr>
				<tr>
					<td><a href="../Proveedores/ProveedorServlet?Listar=Listar"><button class="btn btn-primary">Proveedores</button></a></td>
					<td><a href="#"><button class="btn btn-primary">Productos</button></a></td>					
				</tr>
				<tr>					
					<td><a href="#"><button class="btn btn-primary">Ventas</button></a></td>
					<td><a href="#"><button class="btn btn-primary">Reportes</button></a></td>
					<td></td>
				</tr>
			</table>
	  </div>
	  
	  
  	<div class="block">
		<div class="boxLine">
			<a href="Usuarios/Usuarios.html"><div class="btnUsuarios"></div></a>			
		</div>
		<div class="boxLine">
			<a href="Clientes/Clientes.html"><div class="btnClientes"></div></a>
		</div>
	</div>

	<div class="block">
		<div class="boxLine">
			<a href="Proveedores/Proveedores.html"><div class="btnProveedores"></div></a>			
		</div>
		<div class="boxLine">
			<a href="Productos/Productos.html"><div class="btnProductos"></div></a>
		</div>
	</div>

	<div class="block">
		<div class="boxLine">
			<a href="Ventas/Ventas.html"><div class="btnVentas"></div></a>			
		</div>
		<div class="boxLine">
			<a href="Reportes/Reportes.html"><div class="btnReportes"></div></a>
		</div>
	</div>
	  

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    
</body>
</html>