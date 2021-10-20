<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*"%>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="ISO-UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Clientes</title>

		<!--BootStrap CSS-->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
		<!--DataTable-BootStrap CSS-->
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css">

		<style>
			.page-item.active .page-link {
				background-color: #212529 !important;
				border: 1px solid black;
				color: white !important;
			}
			.page-link {
				color: black !important;
			}
		</style>
		<%ArrayList<Cliente> clientes = (ArrayList<Cliente>) request.getAttribute("LISTA_CLIENTES");
			String mensaje = (String)request.getAttribute("MENSAJE");%>
	</head>
	<body>
		<jsp:include page="../Menu/menu.jsp"></jsp:include>

		<div class="container">
			<br>
			<h1 class="text-center">CLIENTES</h1>
			<button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#agregar" onclick="addFunction()">Agregar</button>
			<br>
			<br>
			<div class="row">
				<div class="col-lg-12">
					<div class="table_responsive">
						<table id="table-datatable"
							class="table table-striped table-bordered table-hover text-center align-middle table-sm" style="width:100%">
							<thead class="table-dark">
								<tr>
									<th scope="col">Cedula</th>
									<th scope="col">Nombre</th>
									<th scope="col">Email</th>
									<th scope="col">Telefono</th>
									<th scope="col">Direccion</th>
									<th scope="col" style="max-width: 87px;">Opciones</th>
								</tr>
							</thead>
							<tbody id="myTable">
								<%if(clientes != null){
										for(Cliente i:clientes){%>
								<tr>
									<td><%=i.getCedula_cliente()%></td>
									<td><%=i.getNombre_cliente()%></td>
									<td><%=i.getEmail_cliente()%></td>
									<td><%=i.getTelefono_cliente()%></td>
									<td><%=i.getDireccion_cliente()%></td>
									<td>
										<div class="btn-group" role="group" aria-label="Basic example">
											<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal"
												data-bs-target="#editar" onclick="editFunction(
												'<%=i.getCedula_cliente()%>',
												'<%=i.getNombre_cliente()%>',
												'<%=i.getEmail_cliente()%>',
												'<%=i.getTelefono_cliente()%>',
												'<%=i.getDireccion_cliente()%>')">Editar</button>
											<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
												data-bs-target="#eliminar" onclick="deleteFunction(
													'<%=i.getCedula_cliente()%>',
													'<%=i.getNombre_cliente()%>',
													'<%=i.getEmail_cliente()%>',
													'<%=i.getTelefono_cliente()%>',
													'<%=i.getDireccion_cliente()%>')">Eliminar</button>
										</div>
									</td>
								</tr>
								<%}}%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<br>

		<!-- AGREGAR -->
		<div class="modal fade" id="agregar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content ">
					<form autocomplete="off" method="get" action="./Clientes">
						<div class="modal-header p-3 mb-2 bg-dark text-white">
							<h5 class="modal-title" id="agregar">Agregar Cliente</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="cedula_cliente" min="0" max="9999999999" required autofocus>
								<label for="floatingInput">C&eacute;dula</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="nombre_cliente" required>
								<label for="floatingInput">Nombre</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="email_cliente" required>
								<label for="floatingInput">Email</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="telefono_cliente" required>
								<label for="floatingInput">Tel&eacute;fono</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="direccion_cliente" required>
								<label for="floatingInput">Direcci&oacute;n</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
							<button type="submit" class="btn btn-dark" name="opcion" value="agregar">Guardar</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- EDITAR -->
		<div class="modal fade" id="editar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<form method="get" action="./Clientes">
						<div class="modal-header">
							<h5 class="modal-title" id="editar">Editar Cliente</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="cedula_cliente" min="0" max="999999999" required readonly>
								<label for="floatingInput">C&eacute;dula</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="nombre_cliente" required autofocus>
								<label for="floatingInput">Nombre</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="email_cliente" required>
								<label for="floatingInput">Email</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="telefono_cliente" min="0" max="999999999" required>
								<label for="floatingInput">Tel&eacute;fono</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="direccion_cliente" required>
								<label for="floatingInput">Direcci&oacute;n</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
							<button type="submit" class="btn btn-primary" name="opcion" value="actualizar">Guardar cambios</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- ELIMINAR -->
		<div class="modal fade" id="eliminar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<form method="get" action="./Clientes">
						<div class="modal-header p-3 mb-2 bg-danger text-white">
							<h5 class="modal-title" id="eliminar">Eliminar Cliente</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="cedula_cliente" readonly>
							<div class="card">
								<div class="card-body alert-danger">
									¿Está eseguro de eliminar a el siguiente cliente?
									<br>
									<br>
									C&eacute;dula: <span id="cedula_cliente"></span>
									<br>
									Nombre: <span id="nombre_cliente"></span>
									<br>
									Email: <span id="email_cliente"></span>
									<br>
									Tel&eacute;fono: <span id="telefono_cliente"></span>
									<br>
									Direcci&oacute;n: <span id="direccion_cliente"></span>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
							<button type="submit" class="btn btn-dark" name="opcion" value="eliminar">Aceptar</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!--MENSAJES-->
		<!--Agregado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="agregado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Cliente agregado!</div>
			</div>
		</div>
		<!--Actualizado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="actualizado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Cliente actualizado!</div>
			</div>
		</div>
		<!--Eliminado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="eliminado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Cliente eliminado!</div>
			</div>
		</div>    
		<!--NoNumero-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noNumero" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">El c&oacute;digo de la venta debe ser un número!</div>
			</div>
		</div>
		<!--Existente-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="existente" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">La c&eacute;edula del cliente a registrar ya existe!</div>
			</div>
		</div>
		<!--NoCambios-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="sinCambios" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Datos de cliente a actualizar sin cambios!</div>
			</div>
		</div>
		<!--NoExiste-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noExiste" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-danger">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Cliente a eliminar no existe o ya fu&eacute; eliminado!</div>
			</div>
		</div>

		<!--jQuery JS-->
		<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
		<!--Bootstrap5 JS-->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script> 
		<!--DataTable JS-->
		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
		<!--DataTable-Bootstrap5 JS-->
		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>
		<!--Personal JS-->
		<script type="text/javascript" src="GenericFiles/dt.main.js"></script>
		
		<script type="text/javascript">
			var agregar = true;
			function addFunction(a,b,c,d,e) {
				if(agregar){
					document.getElementsByName("cedula_cliente")[0].value = "";
					document.getElementsByName("nombre_cliente")[0].value = "";
					document.getElementsByName("email_cliente")[0].value = "";
					document.getElementsByName("telefono_cliente")[0].value = "";
					document.getElementsByName("direccion_cliente")[0].value = "";
				}
			}

			function editFunction(a,b,c,d,e) {
				document.getElementsByName("cedula_cliente")[1].value = a;
				document.getElementsByName("nombre_cliente")[1].value = b;
				document.getElementsByName("email_cliente")[1].value = c;
				document.getElementsByName("telefono_cliente")[1].value = d;
				document.getElementsByName("direccion_cliente")[1].value = e;
			}

			function deleteFunction(a,b,c,d,e) {
				document.getElementsByName("cedula_cliente")[2].value = a;
				document.getElementById("cedula_cliente").innerHTML = a;
				document.getElementById("nombre_cliente").innerHTML = b;
				document.getElementById("email_cliente").innerHTML = c;
				document.getElementById("telefono_cliente").innerHTML = d;
				document.getElementById("direccion_cliente").innerHTML = e;
			}
			
			let mensaje = '<%=mensaje%>';
			if(mensaje == "Added"){
				new bootstrap.Toast(document.getElementById('agregado')).show();
			}else if(mensaje == "Updated"){
				new bootstrap.Toast(document.getElementById('actualizado')).show();
			}else if(mensaje == "Deleted"){
				new bootstrap.Toast(document.getElementById('eliminado')).show();
			}else if(mensaje == "Null"){
				new bootstrap.Toast(document.getElementById('noAgregado')).show();
			}else if(mensaje == "Existing"){
				new bootstrap.Toast(document.getElementById('existente')).show();
				document.getElementsByName("cedula_cliente")[0].value = <%=(String)request.getParameter("cedula_cliente")%>;
				document.getElementsByName("nombre_cliente")[0].value = <%=(String)request.getParameter("nombre_cliente")%>;
				document.getElementsByName("email_cliente")[0].value = <%=(String)request.getParameter("email_cliente")%>;
				document.getElementsByName("telefono_cliente")[0].value = <%=(String)request.getParameter("telefono_cliente")%>;
				document.getElementsByName("direccion_cliente")[0].value = <%=(String)request.getParameter("direccion_cliente")%>;
				agregar = false;
			}else if(mensaje == "NoChanges"){
				new bootstrap.Toast(document.getElementById('sinCambios')).show();
			}else if(mensaje == "NoExist"){
				new bootstrap.Toast(document.getElementById('noExiste')).show();
			}else{
				console.log(mensaje);
			}
		</script>
		<jsp:include page="/Menu/pie.jsp"></jsp:include>
	</body>
</html>