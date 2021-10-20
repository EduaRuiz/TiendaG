package com.tiendaG.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tiendaG.model.Venta;
import com.tiendaG.model.Cliente;
import com.tiendaG.model.DetalleVenta;
import com.tiendaG.model.Producto;
import com.tiendaG.model.Usuario;

@WebServlet("/Ventas")
public class VentaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String mensaje = "";

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");		
		if(opcion == null) {
			opcion = "listar";			
		}
		switch(opcion) {
			case "listar":
				listar(request, response);
				break;
			case "registrar":
				registrar(request, response);
				break;
			case "confirmar":
				confirmar(request, response);
				break;
			case "editar":
				editar(request, response);
				break;
			case "actualizar":
				actualizar(request, response);
				break;
			case "eliminar":
				eliminar(request, response);
				break;
		}			
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {		
		try {			
			ArrayList<Venta> listaVentas = VentaJson.getJSON();
			ArrayList<Producto> listaProductos = ProductoJson.getJSON();
			ArrayList<Cliente> listaClientes = ClienteJson.getJSON();
			ArrayList<Usuario> listaUsuarios = UsuarioJson.getJSON();
			ArrayList<DetalleVenta> listaDetalleVentas = DetalleVentaJson.getJSON();
			request.setAttribute("LISTA_VENTAS", listaVentas);
			request.setAttribute("LISTA_PRODUCTOS", listaProductos);
			request.setAttribute("LISTA_CLIENTES", listaClientes);
			request.setAttribute("LISTA_USUARIOS", listaUsuarios);
			request.setAttribute("LISTA_DETALLEVENTAS", listaDetalleVentas);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Ventas/ventas.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}		
	}

	private void registrar(HttpServletRequest request, HttpServletResponse response) {
		try {
			ArrayList<Producto> listaProductos = ProductoJson.getJSON();
			ArrayList<Cliente> listaClientes = ClienteJson.getJSON();
			ArrayList<Usuario> listaUsuarios = UsuarioJson.getJSON();
			ArrayList<Venta> listaVentas = VentaJson.getJSON();
			request.setAttribute("LISTA_PRODUCTOS", listaProductos);
			request.setAttribute("LISTA_CLIENTES", listaClientes);
			request.setAttribute("LISTA_USUARIOS", listaUsuarios);
			request.setAttribute("LISTA_VENTAS", listaVentas);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Ventas/ventasAgregar.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private void confirmar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("codigo_venta")) &&
				esLong(request.getParameter("cedula_cliente")) &&
				esLong(request.getParameter("cedula_usuario")) &&
				esDouble(request.getParameter("total_venta")) &&
				esDouble(request.getParameter("iva_venta")) &&
				esDouble(request.getParameter("total_venta")) &&
				request.getParameterValues("carrito") != null){
			Venta venta = new Venta();
			venta.setCodigo_venta(Long.parseLong(request.getParameter("codigo_venta")));
			venta.setCedula_cliente(Long.parseLong(request.getParameter("cedula_cliente")));
			venta.setCedula_usuario(Long.parseLong(request.getParameter("cedula_usuario")));
			venta.setValor_venta(Double.parseDouble(request.getParameter("valor_venta")));
			venta.setIva_venta(Double.parseDouble(request.getParameter("iva_venta")));
			venta.setTotal_venta(Double.parseDouble(request.getParameter("total_venta")));			
			int respuesta = 0;
			try {				
				Venta venta2 = VentaJson.getVenta(request.getParameter("codigo_venta"));
				if(existe(venta, venta2) || venta.getCodigo_venta() == venta2.getCodigo_venta()) {
					mensaje = "Existing";
				}else {
					respuesta = VentaJson.postJSON(venta);				
					if(respuesta == 201) {
						mensaje = "Added";
						registrarDetalleVenta(request, response);					
					}else {
						mensaje = "Error: " + respuesta;
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
				mensaje = "Excepcion";
			}
		}else {
			mensaje = "Null";						
		}
		request.setAttribute("MENSAJE", mensaje);
		listar(request, response);
	}
	
	private void registrarDetalleVenta(HttpServletRequest request, HttpServletResponse response){		
		try {
			String[] carrito = request.getParameterValues("carrito");
			Integer counter = 1;		
			if(carrito != null) {
				for(String i:carrito) {
					String[] productoXcantidad = i.split("-");
					Long codigoVenta = Long.parseLong(request.getParameter("codigo_venta"));
					Long codigoDetalleVenta = Long.parseLong(codigoVenta+counter.toString()); //codigodetalle de venta = codigoVenta + consecutivo;
					Long codigoProducto = Long.parseLong(productoXcantidad[0]);
					Integer cantidadProducto = Integer.parseInt(productoXcantidad[1]);
					Double valorVenta = 0.0;
					Double valorIva = 0.0;
					Double valorTotal = 0.0;
					Producto producto = ProductoJson.getProducto(codigoProducto.toString());
					valorVenta = producto.getPrecio_venta()*cantidadProducto;
					valorIva = producto.getIva_compra()/100*valorVenta;
					valorTotal = valorVenta + valorIva;
					DetalleVenta detalleVenta = new DetalleVenta();
					detalleVenta.setCodigo_detalle_venta(codigoDetalleVenta);
					detalleVenta.setCodigo_venta(codigoVenta);
					detalleVenta.setCodigo_producto(codigoProducto);
					detalleVenta.setCantidad_producto(cantidadProducto);
					detalleVenta.setValor_venta(valorVenta);
					detalleVenta.setValor_iva(valorIva);
					detalleVenta.setValor_total(valorTotal);
					DetalleVentaJson.postJSON(detalleVenta);
					counter++;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}

	private void editar(HttpServletRequest request, HttpServletResponse response) {
		try {
			Venta venta = VentaJson.getVenta(request.getParameter("codigo_venta"));
			Cliente cliente = ClienteJson.getCliente(venta.getCedula_cliente().toString());
			Usuario usuario = UsuarioJson.getUsuario(venta.getCedula_usuario().toString());
			ArrayList<Producto> listaProductos = ProductoJson.getJSON();
			ArrayList<Cliente> listaClientes = ClienteJson.getJSON();
			ArrayList<Usuario> listaUsuarios = UsuarioJson.getJSON();
			String json = VentaJson.getDetalleVentas(request.getParameter("codigo_venta"));
			ArrayList<DetalleVenta> listaDetalleVentas = DetalleVentaJson.parsingDetalleVenta(json);		
			request.setAttribute("LISTA_PRODUCTOS", listaProductos);
			request.setAttribute("LISTA_CLIENTES", listaClientes);
			request.setAttribute("LISTA_USUARIOS", listaUsuarios);
			request.setAttribute("LISTA_DETALLEVENTAS", listaDetalleVentas);
			request.setAttribute("VENTA", venta);
			request.setAttribute("CLIENTE", cliente);
			request.setAttribute("USUARIO", usuario);			
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Ventas/ventasEditar.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void actualizar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("codigo_venta"))){
			Venta venta = new Venta();
			venta.setCodigo_venta(Long.parseLong(request.getParameter("codigo_venta")));
			venta.setCedula_cliente(Long.parseLong(request.getParameter("cedula_cliente")));
			venta.setCedula_usuario(Long.parseLong(request.getParameter("cedula_usuario")));
			venta.setValor_venta(Double.parseDouble(request.getParameter("valor_venta")));
			venta.setIva_venta(Double.parseDouble(request.getParameter("iva_venta")));
			venta.setTotal_venta(Double.parseDouble(request.getParameter("total_venta")));
			int respuesta = 0;
			try {				
				Venta venta2 = VentaJson.getVenta(request.getParameter("codigo_venta"));
				if(existe(venta, venta2)) {
					mensaje = "NoChanges";
				}else {
					String json = VentaJson.getDetalleVentas(request.getParameter("codigo_venta"));
					ArrayList<DetalleVenta> listaDetalleVentas = DetalleVentaJson.parsingDetalleVenta(json);
					for(DetalleVenta i:listaDetalleVentas) {
						DetalleVentaJson.deleteJSON(i.getCodigo_detalle_venta().toString());					
					}
					respuesta = VentaJson.putJSON(venta);
					if(respuesta == 200) {
						mensaje = "Updated";
						registrarDetalleVenta(request, response);
					}else {
						mensaje = "Error: " + respuesta;
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
				mensaje = "Excepcion";				
			}
		}else {
			mensaje = "Null";
			request.setAttribute("MENSAJE", mensaje);
		}
		request.setAttribute("MENSAJE", mensaje);
		listar(request, response);
	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {		
		if(esLong(request.getParameter("codigo_venta"))){
			String codigo = request.getParameter("codigo_venta");
			int respuesta = 0;
			try {
				Venta venta = VentaJson.getVenta(codigo);
				if(venta.getCodigo_venta() == null) {
					mensaje = "NoExist";
				}else {
					String json = VentaJson.getDetalleVentas(request.getParameter("codigo_venta"));
					ArrayList<DetalleVenta> listaDetalleVentas = DetalleVentaJson.parsingDetalleVenta(json);
					for(DetalleVenta i:listaDetalleVentas) {
						DetalleVentaJson.deleteJSON(i.getCodigo_detalle_venta().toString());
					}
					respuesta = VentaJson.deleteJSON(codigo);				
					if(respuesta == 200) {
						mensaje = "Deleted";
					}else {
						mensaje = "Error: " + respuesta;
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
				mensaje = "Excepcion";
			}		
		}else {
			mensaje = "Null";
		}
		request.setAttribute("MENSAJE", mensaje);
		listar(request, response);
	}
	
	private boolean existe(Venta venta1, Venta venta2) {
		if(venta2.getCodigo_venta() != null) {
			if(venta1.toString().equals(venta2.toString())) {
				return true;
			}else {
				return false;
			}
		}else {
			return false;
		}
	}
	
	private boolean esLong(String number) {
		try {
			Long.parseLong(number);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	private boolean esDouble(String number) {
		try {
			Double.parseDouble(number);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}