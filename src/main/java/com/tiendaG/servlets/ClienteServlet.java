package com.tiendaG.servlets;

import java.io.IOException;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tiendaG.model.Cliente;

@WebServlet("/Clientes")
public class ClienteServlet extends HttpServlet{
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
			ArrayList<Cliente> lista = ClienteJson.getJSON();
			request.setAttribute("LISTA_CLIENTES", lista);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Clientes/clientes.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	private void agregar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("cedula_cliente"))) {
			Cliente cliente = new Cliente();
			cliente.setCedula_cliente(Long.parseLong(request.getParameter("cedula_cliente")));
			cliente.setDireccion_cliente(request.getParameter("direccion_cliente"));
			cliente.setEmail_cliente(request.getParameter("email_cliente"));
			cliente.setNombre_cliente(request.getParameter("nombre_cliente"));
			cliente.setTelefono_cliente(request.getParameter("telefono_cliente"));
			int respuesta = 0;
			try {
				Cliente cliente2 = ClienteJson.getCliente(request.getParameter("cedula_cliente"));
				if(existe(cliente, cliente2) || cliente.getCedula_cliente() == cliente2.getCedula_cliente()){
					mensaje = "Existing";
				}else {
					respuesta = ClienteJson.postJSON(cliente);
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
		if(esLong(request.getParameter("cedula_cliente"))) {
			Cliente cliente = new Cliente();
			cliente.setCedula_cliente(Long.parseLong(request.getParameter("cedula_cliente")));
			cliente.setDireccion_cliente(request.getParameter("direccion_cliente"));
			cliente.setEmail_cliente(request.getParameter("email_cliente"));
			cliente.setNombre_cliente(request.getParameter("nombre_cliente"));
			cliente.setTelefono_cliente(request.getParameter("telefono_cliente"));
			int respuesta = 0;
			try {
				Cliente cliente2 = ClienteJson.getCliente(request.getParameter("cedula_cliente"));
				if(existe(cliente, cliente2)){
					mensaje = "NoChanges";
				}else {
					respuesta = ClienteJson.putJSON(cliente);
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
		if(esLong(request.getParameter("cedula_cliente"))) {
			String cedula = request.getParameter("cedula_cliente");
			int respuesta = 0;
			try {
				Cliente cliente = ClienteJson.getCliente(cedula);
				if(cliente.getCedula_cliente() == null) {
					mensaje = "NoExist";
				}else {
					respuesta = ClienteJson.deleteJSON(cedula);
					if(respuesta == 200) {
						mensaje = "Deleted";
					}else {
						mensaje = "Error";
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
	
	private boolean existe(Cliente cliente1, Cliente cliente2) {
		if(cliente2.getCedula_cliente() != null) {
			if(cliente1.toString().equals(cliente2.toString())) {
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