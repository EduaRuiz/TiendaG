<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*, java.text.NumberFormat"%>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="ISO-UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Ventas</title>

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
		
		<%ArrayList<Venta> ventas = (ArrayList<Venta>) request.getAttribute("LISTA_VENTAS");
			ArrayList<DetalleVenta> detalleVentas = (ArrayList<DetalleVenta>) request.getAttribute("LISTA_DETALLEVENTAS");
			String mensaje = (String)request.getAttribute("MENSAJE");%>

	</head>
	<body>
		<jsp:include page="/Menu/menu.jsp"></jsp:include>
		<div class="container">
			<br>
			<h1 class="text-center">VENTAS</h1>
			<button type="button" class="btn btn-dark" onclick="location.href='?opcion=registrar'">Registrar Venta</button>
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
									<th scope="col">C&eacute;dula Cliente</th>
									<th scope="col">C&eacute;dula Usuario</th>
									<th scope="col">Valor Venta</th>
									<th scope="col">IVA</th>
									<th scope="col">Total Venta</th>
									<th scope="col" style="max-width: 87px;">Opciones</th>
								</tr>
							</thead>
							<tbody id="myTable">
								<%if(ventas != null){
										for(Venta i:ventas){%>
								<tr>
									<td><%=i.getCodigo_venta()%></td>
									<td><%=i.getCedula_cliente()%></td>
									<td><%=i.getCedula_usuario()%></td>
									<td class="text-end"><%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getValor_venta())%></td>								
									<td class="text-end"><%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getIva_venta())%></td>
									<td class="text-end"><%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(i.getTotal_venta())%></td>
									<td>
										<div class="btn-group" role="group" aria-label="Basic example">
											<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detalles"
											onclick="detailsFunction(
												'<%=i.getCodigo_venta()%>',
												'<%=i.getValor_venta()%>',
												'<%=i.getIva_venta()%>',
												'<%=i.getTotal_venta()%>')">Detalles</button>
											<button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#editar" onclick="location.href='?opcion=editar&codigo_venta=<%=i.getCodigo_venta()%>'">Editar</button>
											<button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#eliminar"
											onclick="deleteFunction(
												'<%=i.getCodigo_venta()%>',
												'<%=i.getCedula_cliente()%>',
												'<%=i.getCedula_usuario()%>',
												'<%=i.getValor_venta()%>',
												'<%=i.getIva_venta()%>',
												'<%=i.getTotal_venta()%>')">Eliminar</button>
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

		<!-- ELIMINAR -->
		<div class="modal fade" id="eliminar" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<form method="get" action="./Ventas">
						<div class="modal-header p-3 mb-2 bg-danger text-white">
							<h5 class="modal-title" id="eliminar">Eliminar Producto</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="codigo_venta" size="15" maxlength="9" required autofocus readonly>
							<div class="card">
								<div class="card-body alert-danger">
									¿Está eseguro de eliminar a el siguiente producto?
									<br>
									<br>
									C&oacute;digo: <span id="codigo_venta"></span>
									<br>
									C&eacute;dula Cliente: <span id="cedula_cliente"></span>
									<br>
									C&eacute;dula Usuario: <span id="cedula_usuario"></span>
									<br>
									Valor Venta: <span id="valor_venta"></span>
									<br>
									IVA Venta: <span id="iva_venta"></span>
									<br>
									Total Venta: <span id="total_venta"></span>
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

		<!-- DETALLES -->
		<div class="modal fade" id="detalles" tabindex="-1" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-xl">
				<div class="modal-content ">
					<div class="modal-header p-3 mb-2 bg-dark text-white">
						<h5 class="modal-title" id="eliminar">Venta, C&oacute;digo: <span id="tituloDetalle" class=""></span></h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="col-lg-12">
							<div class="table_responsive">
								<table id="table-datatable2" class="table table-striped table-bordered table-hover text-center align-middle table-sm" style="width:100%">
									<thead class="table-dark">
										<tr>
											<th scope="col">C&oacute;digo</th>
											<th scope="col">C&oacute;digo Producto</th>
											<th scope="col">Cantidad Producto</th>
											<th scope="col">Valor Venta</th>
											<th scope="col">Iva Venta</th>
											<th scope="col">Total Venta</th>
										</tr>
									</thead>
									<tbody id="myTable" class="detallesTabla">
									</tbody>
									<tfoot class="table-dark">
										<tr>
											<td>Total</td>
											<td></td>
											<td id="totalCantidad"></td>
											<td id="totalValorVenta" class="text-end"></td>
											<td id="totalIvaVenta" class="text-end"></td>
											<td id="totalTotalVenta" class="text-end"></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>	
					</div>
					<div class="modal-footer  pt-0 pb-0 justify-content-center">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
					</div>
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
				<div class="toast-body ">Venta registrada!</div>
			</div>
		</div>
		<!--Actualizado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="actualizado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Venta actualizada!</div>
			</div>
		</div>
		<!--Eliminado-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="eliminado" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-primary">
					<strong class="me-auto">Correcto</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body ">Venta eliminada!</div>
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
				<div class="toast-body text-start">El c&oacute;digo de venta a registrar ya existe!</div>
			</div>
		</div>
		<!--NoCambios-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="sinCambios" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-warning">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Datos de venta a actualizar sin cambios!</div>
			</div>
		</div>
		<!--NoExiste-->
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
			<div id="noExiste" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header text-white bg-danger">
					<strong class="me-auto">Error</strong>
					<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body text-start">Venta a eliminar no existe o ya fu&eacute; eliminada!</div>
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
			var formatter = new Intl.NumberFormat('en-US', {
				style: 'currency',
				currency: 'USD',
			});

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

			function detailsFunction(codigo, valor, iva, total){
				let venta = new Array();
				let cantidad = 0;
				listaDetalleVentas.forEach(function (detalle) {
					if(codigo == detalle.codigoVenta){
						venta.push(detalle);
						cantidad+=detalle.cantidadProducto;
					}
				});
				$('.detallesTabla').empty();
				var tabla = $(".detallesTabla");
				venta.forEach(function (fila){				
					$(tabla).append(
						'<tr id="detalles">'+
							'<td>'+fila.codigo+'</td>'+
							'<td>'+fila.codigoProducto+'</td>'+
							'<td>'+fila.cantidadProducto+'</td>'+
							'<td class="text-end">'+formatter.format(fila.valorVenta)+'</td>'+
							'<td class="text-end">'+formatter.format(fila.valorIva)+'</td>'+
							'<td class="text-end">'+formatter.format(fila.valorTotal)+'</td>'+
						'</tr>'
					);
				});
				$('#totalCantidad').html(cantidad);
				$('#totalValorVenta').html(formatter.format(valor));
				$('#totalIvaVenta').html(formatter.format(iva));
				$('#totalTotalVenta').html(formatter.format(total));
				$('#tituloDetalle').html(codigo);
			};

			function deleteFunction(a,b,c,d,e,f) {
				document.getElementsByName("codigo_venta")[0].value = a;
				document.getElementById("codigo_venta").innerHTML = a;
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
			}else if(mensaje == "Null"){
				new bootstrap.Toast(document.getElementById('noAgregado')).show();
			}else if(mensaje == "Existing"){
				new bootstrap.Toast(document.getElementById('existente')).show();
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