<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tiendaG.model.*, com.tiendaG.servlets.*, java.text.NumberFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes</title>
    
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
	
	<%ArrayList<VentasPorCliente> ventasPorCliente = (ArrayList<VentasPorCliente>) request.getAttribute("LISTA_VENTAS_POR_CLIENTE");
		ArrayList<Cliente> clientes = (ArrayList<Cliente>) request.getAttribute("LISTA_CLIENTES");
		ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("LISTA_USUARIOS");
		Double totalTotal = 0.0;
		String opcion = (String)request.getParameter("opcion");%>
</head>
<body>
	<jsp:include page="/Menu/menu.jsp"></jsp:include>
	<br>
	<br>
	<div class="container">
		<br>
		<h1 class="text-center" id="titulo"></h1>
		<br>
		<div class="row">
			<div class="col-lg-12">
				<div class="table_responsive">
					<table id="table-datatable"	class="table table-striped table-bordered table-hover text-center align-middle table-sm" style="width:100%">
						
					</table>	
				</div>
			</div>
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
	<script type="text/javascript" src="Reportes/js/reportes.js"></script>
	
	
	<script type="text/javascript">
	
		var formatter = new Intl.NumberFormat('en-US', {
			style: 'currency',
			currency: 'USD',
		});

		///LISTA DE USUARIOS
		var listaUsuarios = new Array();
		$(document).ready(function() {
			<%for(Usuario usuario:usuarios){
				usuario.getCedula_usuario();%>
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
			<%for(Cliente cliente:clientes){
				cliente.getCedula_cliente();%>
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

		///LISTA DE VENTAS POR CLIENTE
		var listaVentasPorClientes = new Array();
		var totalTotal;
		$(document).ready(function() {
			<%for(VentasPorCliente vxc:ventasPorCliente){
				totalTotal += vxc.getTotalVentas();%>
			var venta = {
					cedula: <%=vxc.getCedula()%>,
					nombre: "<%=vxc.getNombre()%>",
					total: <%=vxc.getTotalVentas()%>
					}
			listaVentasPorClientes.push(venta);
			<%}%>
			totalTotal = '<%="$ "+NumberFormat.getInstance(new Locale("es","CO")).format(totalTotal)%>';
		});
		
		$(document).ready(function() {
			let opcion = '<%=opcion%>';
			if(opcion == "ventasPorCliente"){
				$('#titulo').html("VENTAS POR CLIENTE");
				ventasPorCliente(listaVentasPorClientes, totalTotal);
			}else if(opcion == "clientes"){
				$('#titulo').html("LISTA DE CLIENTES");
				clientes(listaClientes);
			}else if(opcion == "usuarios"){
				$('#titulo').html("LISTA DE USUARIOS");
				usuarios(listaUsuarios);
			}else{
				consolo.log(opcion);
			};		
		});
		</script>
		
	<script type="text/javascript" src="GenericFiles/dt.main.js"></script>		
	
	<jsp:include page="/Menu/pie.jsp"></jsp:include>
</body>
</html>