package com.tiendaG.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tiendaG.model.Usuario;

@WebServlet("/Usuarios")
public class UsuarioServlet extends HttpServlet{
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
			case "ingresar":
				ingresar(request, response);
				break;
		}			
	}

	private void ingresar(HttpServletRequest request, HttpServletResponse response) {
		try {
			ArrayList<Usuario> lista = UsuarioJson.getJSON();
			String usuario = request.getParameter("usuario");
			String password = request.getParameter("password");
			Boolean flag = false;
			for(Usuario i:lista) {
				if(i.getUsuario().equals(usuario) && i.getPassword().equals(password)) {
					flag = true;
				}
			}
			if(flag) {
				mensaje = "Welcome";
				request.setAttribute("MENSAJE", mensaje);
				listar(request, response);
			}else {
				response.sendRedirect("./?mensaje=Wrong");
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {		
		try {
			ArrayList<Usuario> lista = UsuarioJson.getJSON();
			request.setAttribute("LISTA_USUARIOS", lista);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Usuarios/usuarios.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	private void agregar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("cedula_usuario"))) {
			Usuario usuario = new Usuario();
			usuario.setCedula_usuario(Long.parseLong(request.getParameter("cedula_usuario")));
			usuario.setEmail_usuario(request.getParameter("email_usuario"));
			usuario.setNombre_usuario(request.getParameter("nombre_usuario"));
			usuario.setUsuario(request.getParameter("usuario"));
			usuario.setPassword(request.getParameter("password"));
			int respuesta = 0;
			try {
				Usuario usuario2 = UsuarioJson.getUsuario(request.getParameter("cedula_usuario"));
				if(existe(usuario, usuario2)
						|| usuario.getCedula_usuario() == usuario2.getCedula_usuario()
						|| usuario.getUsuario().equals(usuario2.getUsuario())){
					mensaje = "Existing";
				}else {
					respuesta = UsuarioJson.postJSON(usuario);
					if(respuesta == 201) {
						mensaje = "Added";
					}else {
						mensaje = "Error: "+respuesta;
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
		if(esLong(request.getParameter("cedula_usuario"))) {
			Usuario usuario = new Usuario();
			usuario.setCedula_usuario(Long.parseLong(request.getParameter("cedula_usuario")));
			usuario.setEmail_usuario(request.getParameter("email_usuario"));
			usuario.setNombre_usuario(request.getParameter("nombre_usuario"));
			usuario.setUsuario(request.getParameter("usuario"));
			usuario.setPassword(request.getParameter("password"));
			int respuesta = 0;
			try {
				Usuario usuario2 = UsuarioJson.getUsuario(request.getParameter("cedula_usuario"));
				ArrayList<Usuario> lista = UsuarioJson.getJSON();
				Integer flag = 0;
				for(Usuario i:lista) {
					if(i.getUsuario().equals(usuario2.getUsuario())) {
						flag++;
					}
				}
				if(existe(usuario, usuario2)){
					mensaje = "NoChanges";
				}else if(flag > 1) {
					mensaje = "Existing";
				}else {					
					respuesta = UsuarioJson.putJSON(usuario);
					if(respuesta == 200) {
						mensaje = "Updated";
					}else {
						mensaje = "Error: "+respuesta;
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
		if(esLong(request.getParameter("cedula_usuario"))) {
			String cedula = request.getParameter("cedula_usuario");
			int respuesta = 0;
			try {
				Usuario usuario = UsuarioJson.getUsuario(cedula);
				if(usuario.getCedula_usuario() == null) {
					mensaje = "NoExist";
				}else {
					respuesta = UsuarioJson.deleteJSON(cedula);
					if(respuesta == 200) {
						mensaje = "Deleted";
					}else {
						mensaje = "Error: "+respuesta;
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
	
	private boolean existe(Usuario usuario1, Usuario usuario2) {
		if(usuario2.getCedula_usuario() != null) {
			if(usuario1.toString().equals(usuario2.toString())) {
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