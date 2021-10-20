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
import com.tiendaG.model.Usuario;
import com.tiendaG.model.VentasPorClienteInterfaz;

@WebServlet("/Reportes")
public class ReporteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<Cliente> listaClientes = ClienteJson.getJSON();
			ArrayList<Usuario> listaUsuarios = UsuarioJson.getJSON();
			ArrayList<VentasPorClienteInterfaz> listaVentasPorCliente = VentaJson.getVentasPorClienteJSON();
			request.setAttribute("LISTA_CLIENTES", listaClientes);
			request.setAttribute("LISTA_USUARIOS", listaUsuarios);
			request.setAttribute("LISTA_VENTAS_POR_CLIENTE", listaVentasPorCliente);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Reportes/reportes.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}