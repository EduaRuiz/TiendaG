<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*" %>
<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Proveedores</title>

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

	<%String nit ="no";
		ArrayList<Proveedor> proveedores = (ArrayList<Proveedor>) request.getAttribute("LISTA_PROVEEDORES");
		String mensaje = (String)request.getAttribute("MENSAJE");%>

	</head>
	<body>
		<jsp:include page="/Menu/menu.jsp"></jsp:include>

		<div class="container">
			<br>
			<h1 class="text-center">PROVEEDORES</h1>
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
									<th scope="col">Nit</th>
									<th scope="col">Nombre</th>
									<th scope="col">Teléfono</th>
									<th scope="col">Ciudad</th>
									<th scope="col">Dirección</th>
									<th scope="col" style="max-width: 87px;">Opciones</th>
								</tr>
							</thead>
							<tbody id="">
								<%if(proveedores != null){
										for(Proveedor i:proveedores){%>
								<tr>
									<td><%=i.getNit_proveedor()%></td>
									<td><%=i.getNombre_proveedor()%></td>
									<td><%=i.getTelefono_proveedor()%></td>
									<td><%=i.getCiudad_proveedor()%></td>
									<td><%=i.getDireccion_proveedor()%></td>
									<td>
										<div class="btn-group" role="group" aria-label="Basic example">
											<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal"
												data-bs-target="#editar" onclick="editFunction(
												'<%=i.getNit_proveedor()%>',
												'<%=i.getNombre_proveedor()%>',
												'<%=i.getTelefono_proveedor()%>',
												'<%=i.getCiudad_proveedor()%>',
												'<%=i.getDireccion_proveedor()%>')">Editar</button>
											<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
												data-bs-target="#eliminar" onclick="deleteFunction(
												'<%=i.getNit_proveedor()%>',
												'<%=i.getNombre_proveedor()%>',
												'<%=i.getTelefono_proveedor()%>',
												'<%=i.getCiudad_proveedor()%>',
												'<%=i.getDireccion_proveedor()%>')">Eliminar</button>
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

		<!-- AGREGAR -->
		<div class="modal fade" id="agregar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<form autocomplete="off" method="get" action="./Proveedores">
						<div class="modal-header p-3 mb-2 bg-dark text-white">
							<h5 class="modal-title text-center" id="agregar">Agregar Proveedor</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="nit_proveedor" min="0" max="9999999999" required autofocus>
								<label for="floatingInput">NIT</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="nombre_proveedor" required>
								<label for="floatingInput">Nombre</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="telefono_proveedor" required>
								<label for="floatingInput">Tel&eacute;fono</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="ciudad_proveedor" required>
								<label for="floatingInput">Ciudad</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="direccion_proveedor" required>
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
					<form method="get" action="./Proveedores">
						<div class="modal-header p-3 mb-2 bg-secondary text-white">
							<h5 class="modal-title" id="editar">Editar Proveedor</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="nit_proveedor" min="0" max="9999999999" required readonly>
								<label for="floatingInput">NIT</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="nombre_proveedor" required autofocus>
								<label for="floatingInput">Nombre</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="telefono_proveedor" min="0" max="999999999" required>
								<label for="floatingInput">Tel&eacute;fono</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="ciudad_proveedor" required>
								<label for="floatingInput">Ciudad</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="direccion_proveedor" required>
								<label for="floatingInput">Direcci&oacute;n</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
							<button type="submit" class="btn btn-dark" name="opcion" value="actualizar">Guardar cambios</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- ELIMINAR -->
		<div class="modal fade" id="eliminar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<form method="get" action="./Proveedores">
						<div class="modal-header p-3 mb-2 bg-danger text-white">
							<h5 class="modal-title" id="eliminar">Eliminar Proveedor</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="nit_proveedor" size="15" maxlength="9" required autofocus readonly>
							<div class="card">
								<div class="card-body alert-danger">
									¿Está eseguro de eliminar a el siguiente proveedor?
									<br>
									<br>
									Nit: <span id="nit_proveedor"></span>
									<br>
									Nombre: <span id="nombre_proveedor"></span>
									<br>
									Tel&eacute;fono: <span id="telefono_proveedor"></span>
									<br>
									Ciudad: <span id="ciudad_proveedor"></span>
									<br>
									Direcci&oacute;n: <span id="direccion_proveedor"></span>
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
				<div class="toast-body ">Proveedor registrado!</div>
			</div>
		</div>
		<!--Actualizado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="actualizado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Proveedor actualizado!</div>
			</div>
		</div>
		<!--Eliminado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="eliminado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Proveedor eliminado!</div>
			</div>
		</div>    
		<!--NoNumero-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noNumero" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
						<strong class="me-auto">Error</strong>
						<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">El NIT debe ser un número!</div>
			</div>
		</div>
		<!--Existente-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="existente" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">El NIT del proveedor a registrar ya existe!</div>
			</div>
		</div>
		<!--NoCambios-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="sinCambios" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Datos de proveedor a actualizar sin cambios!</div>
			</div>
		</div>
		<!--NoExiste-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noExiste" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-danger">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Proveedor a eliminar no existe o ya fu&eacute; eliminado!</div>
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
			function addFunction(a,b,c,d,e) {
				document.getElementsByName("nit_proveedor")[0].value = "";
				document.getElementsByName("nombre_proveedor")[0].value = "";
				document.getElementsByName("telefono_proveedor")[0].value = "";
				document.getElementsByName("ciudad_proveedor")[0].value = "";
				document.getElementsByName("direccion_proveedor")[0].value = "";
			}

			function editFunction(a,b,c,d,e) {
				document.getElementsByName("nit_proveedor")[1].value = a;
				document.getElementsByName("nombre_proveedor")[1].value = b;
				document.getElementsByName("telefono_proveedor")[1].value = c;
				document.getElementsByName("ciudad_proveedor")[1].value = d;
				document.getElementsByName("direccion_proveedor")[1].value = e;
			}

			function deleteFunction(a,b,c,d,e) {
				document.getElementsByName("nit_proveedor")[2].value = a;
				document.getElementById("nit_proveedor").innerHTML = a;
				document.getElementById("nombre_proveedor").innerHTML = b;
				document.getElementById("telefono_proveedor").innerHTML = c;
				document.getElementById("ciudad_proveedor").innerHTML = d;
				document.getElementById("direccion_proveedor").innerHTML = e;
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
				document.getElementsByName("nit_proveedor")[0].value = <%=(String)request.getParameter("nit_proveedor")%>;
				document.getElementsByName("nombre_proveedor")[0].value = '<%=(String)request.getParameter("nombre_proveedor")%>';
				document.getElementsByName("telefono_proveedor")[0].value = '<%=(String)request.getParameter("telefono_proveedor")%>';
				document.getElementsByName("ciudad_proveedor")[0].value = '<%=(String)request.getParameter("ciudad_proveedor")%>';
				document.getElementsByName("direccion_proveedor")[0].value = '<%=(String)request.getParameter("direccion_proveedor")%>';
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