package com.tiendaG.servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.tiendaG.model.Producto;
import com.tiendaG.model.Proveedor;

@WebServlet("/Productos")
@MultipartConfig
public class ProductoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOGGER = Logger.getLogger(ProductoServlet.class.getCanonicalName());
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
			ArrayList<Producto> lista = ProductoJson.getJSON();
			ArrayList<Proveedor> listaP = ProveedorJson.getJSON();
			request.setAttribute("LISTA_PRODUCTOS", lista);
			request.setAttribute("LISTA_PROVEEDORES", listaP);
			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Productos/productos.jsp");
			dispatcher.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	private void agregar(HttpServletRequest request, HttpServletResponse response) {
		if(esLong(request.getParameter("codigo_producto")) &&
				esLong(request.getParameter("nit_proveedor")) &&
				esDouble(request.getParameter("precio_compra")) &&
				esDouble(request.getParameter("precio_venta")) &&
				esDouble(request.getParameter("iva_compra"))) {
			Producto producto = new Producto();
			producto.setCodigo_producto(Long.parseLong(request.getParameter("codigo_producto")));
			producto.setNombre_producto(request.getParameter("nombre_producto"));
			producto.setNit_proveedor(Long.parseLong(request.getParameter("nit_proveedor")));
			producto.setPrecio_compra(Double.parseDouble(request.getParameter("precio_compra")));
			producto.setPrecio_venta(Double.parseDouble(request.getParameter("precio_venta")));
			producto.setIva_compra(Double.parseDouble(request.getParameter("iva_compra")));
			int respuesta = 0;
			System.out.println();
			try {
				Producto producto2 = ProductoJson.getProducto(request.getParameter("codigo_producto"));
				if(existe(producto, producto2) || producto.getCodigo_producto() == producto2.getCodigo_producto()) {
					mensaje = "Existing";
				}else {
					respuesta = ProductoJson.postJSON(producto);
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
		if(esLong(request.getParameter("codigo_producto")) &&
				esLong(request.getParameter("nit_proveedor")) &&
				esDouble(request.getParameter("precio_compra")) &&
				esDouble(request.getParameter("precio_venta")) &&
				esDouble(request.getParameter("iva_compra"))) {
			Producto producto = new Producto();
			producto.setCodigo_producto(Long.parseLong(request.getParameter("codigo_producto")));
			producto.setNombre_producto(request.getParameter("nombre_producto"));
			producto.setNit_proveedor(Long.parseLong(request.getParameter("nit_proveedor")));
			producto.setPrecio_compra(Double.parseDouble(request.getParameter("precio_compra")));
			producto.setPrecio_venta(Double.parseDouble(request.getParameter("precio_venta")));
			producto.setIva_compra(Double.parseDouble(request.getParameter("iva_compra")));
			int respuesta = 0;
			try {
				Producto producto2 = ProductoJson.getProducto(request.getParameter("codigo_producto"));
				if(existe(producto, producto2)) {
					mensaje = "NoChanges";
				}else {
					respuesta = ProductoJson.putJSON(producto);
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
		if(esLong(request.getParameter("codigo_producto"))) {			
			String codigo = request.getParameter("codigo_producto");
			int respuesta = 0;
			try {
				Producto producto = ProductoJson.getProducto(codigo);
				if(producto.getCodigo_producto() == null) {
					mensaje = "NoExist";
				}else {
					respuesta = ProductoJson.deleteJSON(codigo);
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
	    final String path = getServletContext().getRealPath("/"+"Productos/CSVsFiles");
	    final Part filePart = request.getPart("CSV-File");
	    final String fileName = filePart.getSubmittedFileName();
	    OutputStream out = null;
	    InputStream filecontent = null;
	    final PrintWriter writer = response.getWriter();
	    try {
	        out = new FileOutputStream(new File(path + File.separator + fileName));
	        filecontent = filePart.getInputStream();
	        int read = 0;
	        final byte[] bytes = new byte[filecontent.available()];
	        while ((read = filecontent.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        writer.println(path + File.separator + fileName);
		    importar(path + File.separator + fileName);
		    mensaje = "Imported";
		    request.setAttribute("MENSAJE", mensaje);
		    listar(request, response);
	    } catch (FileNotFoundException fne) {
	        writer.println("error");
	        LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}", new Object[]{fne.getMessage()});
	    } finally {
	        if (out != null) {
	            out.close();
	        }
	        if (filecontent != null) {
	            filecontent.close();
	        }
	        if (writer != null) {
	            writer.close();
	        }
	    }		
	}
	
	private void importar(String path) {
        ArrayList<Producto> productos = new ArrayList<>();
        try {
            BufferedReader entrada = new BufferedReader(new FileReader(path));
            String s;
            while ((s = entrada.readLine()) != null){
                String[] informacion = s.split(",");
                Producto producto = new Producto();
                producto.setCodigo_producto(Long.parseLong(informacion[0]));
                producto.setNombre_producto(informacion[1]);
                producto.setNit_proveedor(Long.parseLong(informacion[2]));
                producto.setPrecio_compra(Long.parseLong(informacion[3]));
                producto.setPrecio_venta(Long.parseLong(informacion[4]));
                producto.setIva_compra(Long.parseLong(informacion[5]));
                productos.add(producto);
            }
            entrada.close();
            for(Producto producto:productos) {
            	ProductoJson.postJSON(producto);
            }
        }catch (IOException e){
            e.printStackTrace();
        }
	}
	
	private boolean existe(Producto producto1, Producto producto2) {
		if(producto2.getCodigo_producto() != null) {
			if(producto1.toString().equals(producto2.toString())) {
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