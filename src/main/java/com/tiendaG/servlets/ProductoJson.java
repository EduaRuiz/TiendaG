package com.tiendaG.servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.tiendaG.model.Producto;

public class ProductoJson {
	private static URL url;
	private static String sitio = "http://localhost:8080/TiendaG/productos/";
	
	public static ArrayList<Producto> parsingProducto(String json) throws ParseException {
		JSONParser jsonParser = new JSONParser();
		ArrayList<Producto> lista = new ArrayList<Producto>();
		JSONArray Producto = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = Producto.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Producto producto = new Producto();
			producto.setCodigo_producto(Long.parseLong(innerObj.get("codigo_producto").toString()));
			producto.setNombre_producto(innerObj.get("nombre_producto").toString());
			producto.setNit_proveedor(Long.parseLong(innerObj.get("nit_proveedor").toString()));
			producto.setPrecio_compra(Double.parseDouble(innerObj.get("precio_compra").toString()));
			producto.setPrecio_venta(Double.parseDouble(innerObj.get("precio_venta").toString()));
			producto.setIva_compra(Double.parseDouble(innerObj.get("iva_compra").toString()));
			lista.add(producto);
		}
		return lista;
	}
	
	public static ArrayList<Producto> getJSON() throws IOException, ParseException{
		url = new URL(sitio+"listar");
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<Producto> lista = new ArrayList<Producto>();
		lista = parsingProducto(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(Producto producto) throws IOException {
		url = new URL(sitio+"crear");
		HttpURLConnection http;
		http = (HttpURLConnection)url.openConnection();
		try {
			http.setRequestMethod("POST");
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
		http.setDoOutput(true);
		http.setRequestProperty("Accept", "application/json");
		http.setRequestProperty("Content-Type", "application/json");
		String data = "{"
			+ "\"codigo_producto\":\""+ producto.getCodigo_producto()
			+"\",\"nombre_producto\": \""+producto.getNombre_producto()
			+"\",\"nit_proveedor\": \""+producto.getNit_proveedor()
			+"\",\"precio_compra\":\""+producto.getPrecio_compra()
			+"\",\"precio_venta\":\""+producto.getPrecio_venta()
			+"\",\"iva_compra\":\""+producto.getIva_compra()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int putJSON(Producto producto) throws IOException {
		url = new URL(sitio+"actualizar");
		HttpURLConnection http;
		http = (HttpURLConnection)url.openConnection();
		try {
			http.setRequestMethod("PUT");
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
		http.setDoOutput(true);
		http.setRequestProperty("Accept", "application/json");
		http.setRequestProperty("Content-Type", "application/json");
		String data = "{"
			+ "\"codigo_producto\":\""+ producto.getCodigo_producto()
			+"\",\"nombre_producto\": \""+producto.getNombre_producto()
			+"\",\"nit_proveedor\": \""+producto.getNit_proveedor()
			+"\",\"precio_compra\":\""+producto.getPrecio_compra()
			+"\",\"precio_venta\":\""+producto.getPrecio_venta()
			+"\",\"iva_compra\":\""+producto.getIva_compra()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int deleteJSON(String codigo_producto) throws IOException {		
		url = new URL(sitio+"eliminar/"+codigo_producto);
		HttpURLConnection http = (HttpURLConnection) url.openConnection();
		try {
			http.setRequestMethod("DELETE");
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
		http.setDoOutput(true);
		http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded" );
		http.connect();
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static Producto getProducto(String codigo_producto) throws IOException, ParseException{
		url = new URL(sitio+"obtener/"+codigo_producto);
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<Producto> lista = new ArrayList<Producto>();
		lista = parsingProducto("["+json+"]");
		http.disconnect();
		if(lista.isEmpty()) {
			return new Producto();
		}else {
			return lista.get(0);
		}		
	}
}