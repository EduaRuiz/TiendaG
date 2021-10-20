<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*"%>
<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="ISO-UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Editar Venta</title>

	<!--BootStrap CSS-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<!--Bootstrap-select CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta2/dist/css/bootstrap-select.min.css">
	
	<%ArrayList<Producto> productos = (ArrayList<Producto>) request.getAttribute("LISTA_PRODUCTOS");
		ArrayList<Cliente> clientes = (ArrayList<Cliente>) request.getAttribute("LISTA_CLIENTES");
		ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("LISTA_USUARIOS");
		ArrayList<DetalleVenta> detalleVentas = (ArrayList<DetalleVenta>) request.getAttribute("LISTA_DETALLEVENTAS");
		Venta venta = (Venta) request.getAttribute("VENTA");
		Cliente client = (Cliente) request.getAttribute("CLIENTES");
		Usuario user = (Usuario) request.getAttribute("USUARIO");%>

</head>

<body>
	<jsp:include page="/Menu/menu.jsp"></jsp:include>

	<div class="container">
		<br>
		<h1 class="text-center">EDITAR VENTA</h1>
	</div>

	<div class="container card mb-1">
		<br>
		<h4 class="text-muted">Seleccionar cliente</h4>
		<div class="card-body">
			<br>
			<div class="row">
				<input class="text-start col-1" type="text" value="Cliente" readonly>
				<select class="selectpicker text-end col" data-live-search="true" title="C&eacute;dula Cliente"
					id="cedula_cliente" name="cedula_cliente" required>
					<%if(clientes != null){
							for(Cliente i:clientes){%>
					<option value="<%=i.getCedula_cliente()%>" data-tokens="<%=i.getCedula_cliente()%>">
						<%=i.getCedula_cliente()%></option>
					<%}}%>
				</select>
				<input class="text-center col" type="text" id="nombre_cliente" readonly>
				<div class="col-1"></div>
				<input class="text-start col-1" type="text" value="Usuario" readonly>
				<select class="selectpicker text-end col" data-live-search="true" title="C&eacute;dula Usuario"
					id="cedula_usuario" name="cedula_usuario" required>
					<%if(usuarios != null){
							for(Usuario i:usuarios){%>
					<option value="<%=i.getCedula_usuario()%>" data-tokens="<%=i.getCedula_usuario() %>">
						<%=i.getCedula_usuario()%></option>
					<%}}%>
				</select>
				<input class="text-center col" type="text" id="nombre_usuario" readonly>
				<div class="col-1"></div>
				<input class="text-start col-2" type="text" value="C&oacute;digo Venta" readonly>
				<input class="text-center col-1" type="number" id="codigo_venta" readonly>
			</div>
			<br>
		</div>
	</div>

	<div class="container card mb-1">
		<br>
		<h4 class="text-muted">Seleccionar producto</h4>
		<br>
		<div class="row text-center">
			<div class="col">C&oacute;digo</div>
			<div class="col">Nombre</div>
			<div class="col-1">Cantidad</div>
			<div class="col">Valor Total</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<select class="selectpicker text-end col" data-live-search="true" title="C&oacute;digo producto"
				id="codigo_producto" name="codigo_producto" required>
				<%if(productos != null){
						for(Producto i:productos){%>
				<option value="<%=i.getCodigo_producto()%>" data-tokens="<%=i.getNombre_producto()%>"><%=i.getCodigo_producto()%></option>
				<%}}%>
			</select>
			<input class="text-center col" type="text" id="nombre_producto" readonly>
			<input class="text-center col" type="number" name="cantidad_producto" style="max-width: 80px;" id="cantidad_producto" min="1" max="100" required>
			<input class="text-center col" type="text" id="valor_producto" readonly>
			<div class="btn-group col-2" role="group" aria-label="Basic example">
				<button class="btn btn-dark btn-sm" id="agregarBtn">Agregar</button>
				<button class="btn btn-warning btn-sm" id="limpiarBtn" onclick="limpiarConsulta()">Limpiar</button>
			</div>
		</div>
		<br>
		<br>
	</div>	

	<form autocomplete="off" method="get" action="./Ventas">
		<div class="container card">
			<br>
			<h2 class="text-center">CARRO</h2>
			<br>
			<div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col-1"></div>
					<div class="col-2 text-center">C&oacute;digo</div>
					<div class="col text-center">Nombre</div>
					<div class="col-1 text-center">Cantidad</div>
					<div class="col text-center">Valor Total</div>
					<div class="col-1"></div>
				</div>
			</div>
			<div>
				<input type="hidden" name="cedula_cliente" id="cedulaCliente" required>
				<input type="hidden" name="cedula_usuario" id="cedulaUsuario" required>
				<input type="hidden" name="codigo_venta" id="codigoVenta" value="<%=venta.getCodigo_venta()%>" required>
			</div>
			<div class="carritoProductos">
			</div>
			<br>
			<div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col"></div>
					<div class="col"></div>
					<div class="col"></div>
					<div class="col-2">Total venta</div>
					<input class="col-2 text-end" type="text" id="valor_venta" readonly>
					<input type="hidden" name="valor_venta" id="valorVenta">
					<div class="col-1"></div>
					<div></div>
				</div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col"></div>
					<div class="col"></div>
					<div class="col"></div>
					<div class="col-2">Total IVA</div>
					<input class="col-2 text-end" type="text" id="iva_venta" readonly>
					<input type="hidden" name="iva_venta" id="ivaVenta">
					<div class="col-1"></div>
					<div></div>
				</div>
				<div class="row"></div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col"></div>
					<div class="col"></div>
					<button class="btn btn-dark btn-sm col-1" type="submit" name="opcion" value="actualizar">Confirmar</button>
					<div class="col-2">Total con IVA</div>
					<input class="col-2 text-end" type="text" id="total_venta" readonly>
					<input type="hidden" name="total_venta"  id="totalVenta">
					<div class="col-1"></div>
					<div></div>
				</div>
			</div>
			<br>	
		</div>
</form>

<!--MENSAJES-->
<!--Seleccionar Cliente-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="clienteToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-warning">
			<strong class="me-auto">Cliente</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Debe seleccionar un cliente antes</div>				
	</div>
</div>
<!--Seleccionar Usuario-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="usuarioToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-warning">
			<strong class="me-auto">Usuario</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Debe seleccionar un Usuario antes</div>				
	</div>
</div>
<!--Elegir código de Venta-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="codigoVentaToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-warning">
			<strong class="me-auto">C&oacute;digo Venta</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Debe digitar un C&oacute;digo de venta antes</div>				
	</div>
</div>
<!--Elegir código de venta no existente-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="codigoVentaExistenteToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-danger">
			<strong class="me-auto">C&oacute;digo Venta</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">El c&oacute;digo ya existe, digita otro</div>				
	</div>
</div>
<!--seleccionar Producto-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="codigoProductoToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-warning">
			<strong class="me-auto">Producto</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Elige el c&oacute;digo del producto a agregar antes</div>				
	</div>
</div>
<!--seleccionar cantidad Producto-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="cantidadProductoToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-warning">
			<strong class="me-auto">Producto</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Elige la cantidad del producto a agregar antes</div>				
	</div>
</div>
<!--Producto Agregago-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="productoAgregadoToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-success">
			<strong class="me-auto">Producto</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Producto agregado!</div>				
	</div>
</div>
<!--Cantidad de producto actualizada-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="productoActualizadoToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-success">
			<strong class="me-auto">Producto</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Cantidad de producto existente agregada!</div>				
	</div>
</div>
<!--producto Eleminado-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="productoEliminadoToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-success">
			<strong class="me-auto">Producto</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Producto eliminado!</div>				
	</div>
</div>
<!--Limite de carro-->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="limiteToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
		<div class="toast-header text-white bg-danger">
			<strong class="me-auto">Carro</strong>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Limite de productos en el carro alcanzado!</div>				
	</div>
</div>

<!--jQuery JS-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<!--Bootstrap5 JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<!--Bootstrap-select JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta2/dist/js/bootstrap-select.min.js"></script>
<!--Personal JS-->
<script type="text/javascript" src="Ventas/js/ventas.js"></script>

<script type="text/javascript">
	///LISTA DE PRODUCTOS
	var listaProductos = new Array();
	$(document).ready(function() {
		<%for(Producto producto:productos){%>
		var product = {
				codigo: <%=producto.getCodigo_producto()%>,
				nombre: "<%=producto.getNombre_producto()%>",
				proveedor: <%=producto.getNit_proveedor()%>,
				precioCompra: <%=producto.getPrecio_compra()%>,
				precioVenta: <%=producto.getPrecio_venta() %>,
				ivaCompra: <%=producto.getIva_compra() %>
				}
		listaProductos.push(product);
		<%}%>	
	});

	///LISTA DE USUARIOS
	var listaUsuarios = new Array();
	$(document).ready(function() {
		<%for(Usuario usuario:usuarios){%>
		var user = {
				cedula: <%=usuario.getCedula_usuario()%>,
				nombre: "<%=usuario.getNombre_usuario()%>",
				email: "<%=usuario.getEmail_usuario()%>",
				usuario: "<%=usuario.getUsuario()%>",
				password: "<%=usuario.getPassword()%>"
				}
		listaUsuarios.push(user);
		<%}%>	
	});

	///LISTA DE CLIENTES
	var listaClientes = new Array();
	$(document).ready(function() {
		<%for(Cliente cliente:clientes){%>
		var client = {
				cedula: <%=cliente.getCedula_cliente()%>,
				nombre: "<%=cliente.getNombre_cliente()%>",
				email: "<%=cliente.getEmail_cliente()%>",
				telefono: "<%=cliente.getTelefono_cliente()%>",
				direccion: "<%=cliente.getDireccion_cliente()%>"
				}
		listaClientes.push(client);
		<%}%>	
	});

	///LISTA DE VENTAS
	var listaVentas = new Array();

	///LISTA DE DETALLES DE VENTAS
	var listaDetalleVentas = new Array();
	$(document).ready(function() {
		<%for(DetalleVenta detalle:detalleVentas){%>
		var detalle = {
				codigo: <%=detalle.getCodigo_detalle_venta()%>,
				cantidadProducto: <%=detalle.getCantidad_producto()%>,
				codigoProducto: <%=detalle.getCodigo_producto()%>,
				codigoVenta: <%=detalle.getCodigo_venta()%>,
				valorTotal: <%=detalle.getValor_total()%>,
				valorIva: <%=detalle.getValor_iva()%>,
				valorVenta: <%=detalle.getValor_venta()%>
				}
				listaDetalleVentas.push(detalle);
		<%}%>	
	});
	
	$(document).ready(function() {
	listas(listaProductos,listaUsuarios,listaClientes,listaVentas,listaDetalleVentas);
	
	if(listaDetalleVentas != null){
		$('#codigo_venta').val(<%=venta.getCodigo_venta()%>);
		$('#codigoVenta').val(<%=venta.getCodigo_venta()%>);
		$('#cedula_cliente').val(<%=venta.getCedula_cliente()%>);
		$('#cedulaCliente').val(<%=venta.getCedula_cliente()%>);
		nombreCliente(<%=venta.getCedula_cliente()%>);
		$('#cedula_usuario').val(<%=venta.getCedula_usuario()%>);
		$('#cedulaUsuario').val(<%=venta.getCedula_usuario()%>);
		nombreUsuario(<%=venta.getCedula_usuario()%>);
		$('.selectpicker').selectpicker('refresh');
		llenarCarro();
	};
});
</script>
<jsp:include page="../Menu/pie.jsp"></jsp:include>
</body>
</html>