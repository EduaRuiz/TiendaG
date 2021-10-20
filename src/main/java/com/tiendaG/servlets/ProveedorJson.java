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

import com.tiendaG.model.Proveedor;

public class ProveedorJson {
	private static URL url;
	private static String sitio = "http://localhost:8080/TiendaG/proveedores/";
	
	public static ArrayList<Proveedor> parsingProveedor(String json) throws ParseException {
		JSONParser jsonParser = new JSONParser();
		ArrayList<Proveedor> lista = new ArrayList<Proveedor>();
		JSONArray Proveedor = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = Proveedor.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Proveedor proveedor = new Proveedor();
			proveedor.setNit_proveedor(Long.parseLong(innerObj.get("nit_proveedor").toString()));
			proveedor.setNombre_proveedor(innerObj.get("nombre_proveedor").toString());
			proveedor.setTelefono_proveedor(innerObj.get("telefono_proveedor").toString());
			proveedor.setCiudad_proveedor(innerObj.get("ciudad_proveedor").toString());
			proveedor.setDireccion_proveedor(innerObj.get("direccion_proveedor").toString());
			lista.add(proveedor);
		}
		return lista;
	}
	
	public static ArrayList<Proveedor> getJSON() throws IOException, ParseException{
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
		ArrayList<Proveedor> lista = new ArrayList<Proveedor>();
		lista = parsingProveedor(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(Proveedor proveedor) throws IOException {
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
			+ "\"nit_proveedor\": \""+ proveedor.getNit_proveedor()
			+"\",\"nombre_proveedor\": \""+proveedor.getNombre_proveedor()
			+"\",\"telefono_proveedor\": \""+proveedor.getTelefono_proveedor()
			+"\",\"ciudad_proveedor\": \""+proveedor.getCiudad_proveedor()
			+"\",\"direccion_proveedor\": \""+proveedor.getDireccion_proveedor()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int putJSON(Proveedor proveedor) throws IOException {
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
			+ "\"nit_proveedor\": \""+ proveedor.getNit_proveedor()
			+"\",\"nombre_proveedor\": \""+proveedor.getNombre_proveedor()
			+"\",\"telefono_proveedor\": \""+proveedor.getTelefono_proveedor()
			+"\",\"ciudad_proveedor\": \""+proveedor.getCiudad_proveedor()
			+"\",\"direccion_proveedor\": \""+proveedor.getDireccion_proveedor()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int deleteJSON(String nit_proveedor) throws IOException {		
		url = new URL(sitio+"eliminar/"+nit_proveedor);
		HttpURLConnection http = (HttpURLConnection) url.openConnection();
		try {
			http.setRequestMethod("DELETE");
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
		http.setDoOutput(true);
		http.setRequestProperty("Accept", "application/json");
		http.setRequestProperty("Content-Type", "application/json");
		http.connect();
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static Proveedor getProveedor(String nit_proveedor) throws IOException, ParseException{
		url = new URL(sitio+"obtener/"+nit_proveedor);
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<Proveedor> lista = new ArrayList<Proveedor>();
		lista = parsingProveedor("["+json+"]");
		http.disconnect();
		if(lista.isEmpty()) {
			return new Proveedor();
		}else {
			return lista.get(0);
		}		
	}
}