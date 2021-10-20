package com.tiendaG.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tiendaG.model.Proveedor;

@WebServlet("/Proveedores")
public class ProveedorServlet extends HttpServlet {
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
			case "agregar":
				agregar(request, response);
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
			ArrayList<Proveedor> lista = ProveedorJson.getJSON();
			request.setAttribute("LISTA_PROVEEDORES", lista);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Proveedores/proveedores.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	private void agregar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("nit_proveedor"))) {
			Proveedor proveedor = new Proveedor();
			proveedor.setNit_proveedor(Long.parseLong(request.getParameter("nit_proveedor")));
			proveedor.setNombre_proveedor(request.getParameter("nombre_proveedor"));
			proveedor.setTelefono_proveedor(request.getParameter("telefono_proveedor"));
			proveedor.setCiudad_proveedor(request.getParameter("ciudad_proveedor"));
			proveedor.setDireccion_proveedor(request.getParameter("direccion_proveedor"));
			int respuesta = 0;
			try {
				Proveedor proveedor2 = ProveedorJson.getProveedor(request.getParameter("nit_proveedor"));
				if(existe(proveedor, proveedor2) || proveedor.getNit_proveedor() == proveedor2.getNit_proveedor()) {
					mensaje = "Existing";
				}else {
					respuesta = ProveedorJson.postJSON(proveedor);
					if(respuesta == 201) {
						mensaje = "Added";
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
	
	private void actualizar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("nit_proveedor"))) {
			Proveedor proveedor = new Proveedor();
			proveedor.setNit_proveedor(Long.parseLong(request.getParameter("nit_proveedor")));
			proveedor.setNombre_proveedor(request.getParameter("nombre_proveedor"));
			proveedor.setTelefono_proveedor(request.getParameter("telefono_proveedor"));
			proveedor.setCiudad_proveedor(request.getParameter("ciudad_proveedor"));
			proveedor.setDireccion_proveedor(request.getParameter("direccion_proveedor"));
			int respuesta = 0;
			try {
				Proveedor proveedor2 = ProveedorJson.getProveedor(request.getParameter("codigo_proveedor"));
				if(existe(proveedor, proveedor2)) {
					mensaje = "NoChanges";
				}else {
					respuesta = ProveedorJson.putJSON(proveedor);
					if(respuesta == 200) {
						mensaje = "Updated";
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

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("nit_proveedor"))) {
			String nit = request.getParameter("nit_proveedor");
			int respuesta = 0;
			try {
				Proveedor proveedor = ProveedorJson.getProveedor(nit);
				if(proveedor.getNit_proveedor() == null) {
					mensaje = "NoExist";
				}else {
					respuesta = ProveedorJson.deleteJSON(nit);
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
	
	private boolean existe(Proveedor proveedor1, Proveedor proveedor2) {
		if(proveedor2.getNit_proveedor() != null) {
			if(proveedor1.toString().equals(proveedor2.toString())) {
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
}