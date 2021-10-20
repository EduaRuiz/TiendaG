<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*, java.text.NumberFormat"%>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="ISO-UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Productos</title>

		<!--BootStrap CSS-->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
		<!--DataTable-BootStrap CSS-->
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css">
		<!--Bootstrap-select CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta2/dist/css/bootstrap-select.min.css">
		
		<style>
			.page-item.active .page-link {
				background-color: #212529 !important;
				border: 1px solid black;
				color: white !important;
			}
			.page-link {
				color: black !important;
			}
			.bootstrap-select {
				min-width: 73% !important;
				}
		</style>

		<%ArrayList<Producto> productos = (ArrayList<Producto>) request.getAttribute("LISTA_PRODUCTOS");
			ArrayList<Proveedor> proveedores = (ArrayList<Proveedor>) request.getAttribute("LISTA_PROVEEDORES");
			String mensaje = (String)request.getAttribute("MENSAJE");%>

	</head>
	<body>
		<jsp:include page="/Menu/menu.jsp"></jsp:include>

		<div class="container">
			<br>
			<h1 class="text-center">PRODUCTOS</h1>
			<button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#agregar" onclick="addFunction()">Agregar</button>
			<button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#importar" onclick="addFunction()">Importar desde Csv</button>
			<br>
			<br>
			<div class="row">
				<div class="col-lg-12">
					<div class="table_responsive">
						<table id="table-datatable"
							class="table table-striped table-bordered table-hover text-center align-middle table-sm" style="width:100%">
							<thead class="table-dark">
								<tr>
									<th scope="col">C&oacute;digo</th>
									<th scope="col">Nombre</th>
									<th scope="col">Nit Proveedor</th>
									<th scope="col">Iva Compra</th>
									<th scope="col">Precio Compra</th>
									<th scope="col">Precio Venta</th>
									<th scope="col" style="max-width: 87px;">Opciones</th>
								</tr>
							</thead>
							<tbody id="myTable">
								<%if(productos != null){
										for(Producto i:productos){%>
								<tr>
									<td><%=i.getCodigo_producto()%></td>
									<td class="text-start"><%=i.getNombre_producto()%></td>
									<td><%=i.getNit_proveedor()%></td>
									<td class="text-end"><%=i.getIva_compra()+"%"%></td>
									<td class="text-end"><%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getPrecio_compra())%></td>
									<td class="text-end"><%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getPrecio_venta())%></td>
									<td>
										<div class="btn-group" role="group" aria-label="Basic example">
											<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal"
												data-bs-target="#editar" onclick="editFunction(
												'<%=i.getCodigo_producto()%>',
												'<%=i.getNombre_producto()%>',
												'<%=i.getNit_proveedor()%>',
												'<%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getPrecio_compra())%>',
												'<%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getPrecio_venta())%>',
												'<%=i.getIva_compra()+"%"%>')">Editar</button>
											<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
												data-bs-target="#eliminar" onclick="deleteFunction(
												'<%=i.getCodigo_producto()%>',
												'<%=i.getNombre_producto()%>',
												'<%=i.getNit_proveedor()%>',
												'<%=i.getPrecio_compra()%>',
												'<%=i.getPrecio_venta()%>',
												'<%=i.getIva_compra()%>')">Eliminar</button>
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
					<form autocomplete="off" method="get" action="./Productos">
						<div class="modal-header p-3 mb-2 bg-dark text-white">
							<h5 class="modal-title text-center" id="agregar">Agregar Producto</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="codigo_producto" min="0" max="9999999999" required autofocus>
								<label for="floatingInput">C&oacute;digo</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="nombre_producto" required>
								<label for="floatingInput">Nombre</label>
							</div>
							<div class="input-group mb-3">
								<span class="input-group-text" for="inputGroupSelect01">Nit Proveedor</span>
								<select class="selectpicker" data-live-search="true" title="Escoger nit Proveedor" name="nit_proveedor" required id="inputGroupSelect01">
									<%if(proveedores != null){
											for(Proveedor i:proveedores){%>
									<option value="<%=i.getNit_proveedor()%>" data-tokens="<%=i.getNit_proveedor()%>">Nit: <%=i.getNit_proveedor()%>, Nombre: <%=i.getNombre_proveedor()%></option>
									<%}}%>
								</select>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="precio_compra" required>
								<label for="floatingInput">Precio Compra</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="precio_venta" required>
								<label for="floatingInput">Precio Venta</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="iva_compra" required>
								<label for="floatingInput">IVA Compra</label>
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
					<form method="get" action="./Productos">
						<div class="modal-header p-3 mb-2 bg-secondary text-white">
							<h5 class="modal-title" id="editar">Editar Producto</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="codigo_producto" min="0" max="9999999999" required readonly>
								<label for="floatingInput">C&oacute;digo</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput" placeholder=" " name="nombre_producto" maxlength="255" required>
								<label for="floatingInput">Nombre</label>
							</div>
							<div class="input-group mb-3">
								<span class="input-group-text" for="inputGroupSelect01">Nit Proveedor</span>
								<select class="selectpicker" data-live-search="true" title="Escoger nit Proveedor" name="nit_proveedor" required id="inputGroupSelect01">
									<%if(proveedores != null){
											for(Proveedor i:proveedores){%>
									<option value="<%=i.getNit_proveedor()%>" data-tokens="<%=i.getNit_proveedor()%>">Nit: <%=i.getNit_proveedor()%>, Nombre: <%=i.getNombre_proveedor()%></option>
									<%}}%>
								</select>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="precio_compra" min="0" max="9999999999" required>
								<label for="floatingInput">Precio Compra</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="precio_venta" min="0" max="9999999999" required>
								<label for="floatingInput">Precio Venta</label>
							</div>
							<div class="form-floating mb-3">
								<input type="number" class="form-control" id="floatingInput" placeholder=" " name="iva_compra" min="0" max="9999999999" required>
								<label for="floatingInput">IVA Compra</label>
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
					<form method="get" action="./Productos">
						<div class="modal-header p-3 mb-2 bg-danger text-white">
							<h5 class="modal-title" id="eliminar">Eliminar Producto</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="codigo_producto" size="15" maxlength="9" required autofocus readonly>
							<div class="card">
								<div class="card-body alert-danger">
									¿Está eseguro de eliminar a el siguiente producto?
									<br>
									<br>
									C&oacute;digo: <span id="codigo_producto"></span>
									<br>
									Nombre: <span id="nombre_producto"></span>
									<br>
									Nit Proveedor: <span id="nit_proveedor"></span>
									<br>
									Precio de Compra: <span id="precio_compra"></span>
									<br>
									Precio de Venta: <span id="precio_venta"></span>
									<br>
									Porcentaje Iva compra: <span id="iva_compra"></span>
								</div>
							</div>
						</div>
						<div class="modal-footer my-select">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
							<button type="submit" class="btn btn-dark" name="opcion" value="eliminar">Aceptar</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- IMPORTAR CSV FILE -->
		<div class="modal fade" id="importar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<form method="POST" action="./Productos" enctype="multipart/form-data">
						<div class="modal-header p-3 mb-2 bg-danger text-white">
							<h5 class="modal-title" id="importar">Importar productos desde archivo Csv</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="file" class="form-control" id="customFile" name="CSV-File" accept=".csv"/>
						</div>
						<div class="modal-footer my-select">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
							<button type="submit" class="btn btn-dark" name="opcion" value="importar">Aceptar</button>
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
				<div class="toast-body ">Producto registrado!</div>
			</div>
		</div>
		<!--Actualizado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="actualizado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Producto actualizado!</div>
			</div>
		</div>
		<!--Eliminado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="eliminado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Producto eliminado!</div>
			</div>
		</div>
		<!--Importado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="importado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Archivo Importado con &Eacute;xito!</div>
			</div>
		</div>
		<!--NoNumero-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noNumero" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
						<strong class="me-auto">Error</strong>
						<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">El c&oacute;digo debe ser un número!</div>
			</div>
		</div>
		<!--Existente-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="existente" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">El c&eacute;odigo del producto a registrar ya existe!</div>
			</div>
		</div>
		<!--NoCambios-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="sinCambios" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Datos de producto a actualizar sin cambios!</div>
			</div>
		</div>
		<!--NoExiste-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noExiste" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-danger">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Producto a eliminar no existe o ya fu&eacute; eliminado!</div>
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
		<!--Bootstrap-select JS-->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta2/dist/js/bootstrap-select.min.js"></script>
		<!--Personal JS-->
		<script type="text/javascript" src="GenericFiles/dt.main.js"></script>

		<script type="text/javascript">
			var agregar = true;
			function addFunction(a,b,c,d,e,f) {
				if(agregar){
					document.getElementsByName("codigo_producto")[0].value = "";
					document.getElementsByName("nombre_producto")[0].value = "";
					document.getElementsByName("nit_proveedor")[0].value = "";
					document.getElementsByName("precio_compra")[0].value = "";
					document.getElementsByName("precio_venta")[0].value = "";
					document.getElementsByName("iva_compra")[0].value = "";
				}
			}

			function editFunction(a,b,c,d,e,f) {
				document.getElementsByName("codigo_producto")[1].value = a;
				document.getElementsByName("nombre_producto")[1].value = b;
				document.getElementsByName("nit_proveedor")[1].value = c;
				document.getElementsByName("precio_compra")[1].value = d;
				document.getElementsByName("precio_venta")[1].value = e;
				document.getElementsByName("iva_compra")[1].value = f;
			}

			function deleteFunction(a,b,c,d,e,f) {
				document.getElementsByName("codigo_producto")[2].value = a;
				document.getElementById("codigo_producto").innerHTML = a;
				document.getElementById("nombre_producto").innerHTML = b;
				document.getElementById("nit_proveedor").innerHTML = c;
				document.getElementById("precio_compra").innerHTML = d;
				document.getElementById("precio_venta").innerHTML = e;
				document.getElementById("iva_compra").innerHTML = f;
			}

			let mensaje = '<%=mensaje%>';
			if(mensaje == "Added"){
				new bootstrap.Toast(document.getElementById('agregado')).show();
			}else if(mensaje == "Updated"){
				new bootstrap.Toast(document.getElementById('actualizado')).show();
			}else if(mensaje == "Deleted"){
				new bootstrap.Toast(document.getElementById('eliminado')).show();
			}else if(mensaje == "Imported"){
				new bootstrap.Toast(document.getElementById('importado')).show();
			}else if(mensaje == "Null"){
				new bootstrap.Toast(document.getElementById('noAgregado')).show();
			}else if(mensaje == "Existing"){
				new bootstrap.Toast(document.getElementById('existente')).show();
				<%Boolean existe = false;
				if((String)request.getParameter("codigo_producto") != null &&
					(String)request.getParameter("nombre_producto") != null &&
					(String)request.getParameter("nit_proveedor") != null &&
					(String)request.getParameter("precio_compra") != null &&
					(String)request.getParameter("precio_venta") != null &&
					(String)request.getParameter("iva_compra") != null){
					existe = true;
				}%>
				
				if(<%=existe%>){
					document.getElementsByName("codigo_producto")[0].value = <%=(String)request.getParameter("codigo_producto")%>+0;
					document.getElementsByName("nombre_producto")[0].value = '<%=(String)request.getParameter("nombre_producto")%>';
					document.getElementsByName("nit_proveedor")[0].value = <%=(String)request.getParameter("nit_proveedor")%>;
					document.getElementsByName("precio_compra")[0].value = <%=(String)request.getParameter("precio_compra")%>;
					document.getElementsByName("precio_venta")[0].value = <%=(String)request.getParameter("precio_venta")%>;
					document.getElementsByName("iva_compra")[0].value = <%=(String)request.getParameter("iva_compra")%>;
					agregar = false;
				}
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