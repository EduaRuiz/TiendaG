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

import com.tiendaG.model.Cliente;

public class ClienteJson {	
	private static URL url;
	private static String sitio = "http://localhost:8080/TiendaG/clientes/";
	
	public static ArrayList<Cliente> parsingCliente(String json) throws ParseException {
		JSONParser jsonParser = new JSONParser();
		ArrayList<Cliente> lista = new ArrayList<Cliente>();
		JSONArray Cliente = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = Cliente.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Cliente cliente = new Cliente();
			cliente.setCedula_cliente(Long.parseLong(innerObj.get("cedula_cliente").toString()));
			cliente.setDireccion_cliente(innerObj.get("direccion_cliente").toString());
			cliente.setEmail_cliente(innerObj.get("email_cliente").toString());
			cliente.setNombre_cliente(innerObj.get("nombre_cliente").toString());
			cliente.setTelefono_cliente(innerObj.get("telefono_cliente").toString());
			lista.add(cliente);
		}
		return lista;
	}
	
	public static ArrayList<Cliente> getJSON() throws IOException, ParseException{
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
		ArrayList<Cliente> lista = new ArrayList<Cliente>();
		lista = parsingCliente(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(Cliente cliente) throws IOException {
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
			+ "\"cedula_cliente\": \""+ cliente.getCedula_cliente()
			+"\",\"direccion_cliente\": \""+cliente.getDireccion_cliente()
			+"\",\"email_cliente\": \""+cliente.getEmail_cliente()
			+"\",\"nombre_cliente\": \""+cliente.getNombre_cliente()
			+"\",\"telefono_cliente\":\""+cliente.getTelefono_cliente()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int putJSON(Cliente cliente) throws IOException {
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
				+ "\"cedula_cliente\": \""+cliente.getCedula_cliente()
				+"\",\"direccion_cliente\": \""+cliente.getDireccion_cliente()
				+"\",\"email_cliente\": \""+cliente.getEmail_cliente()
				+"\",\"nombre_cliente\": \""+cliente.getNombre_cliente()
				+"\",\"telefono_cliente\": \""+cliente.getTelefono_cliente()
				+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int deleteJSON(String cedula_cliente) throws IOException {		
		url = new URL(sitio+"eliminar/"+cedula_cliente);
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
	
	public static Cliente getCliente(String cedula_cliente) throws IOException, ParseException{
		url = new URL(sitio+"obtener/"+cedula_cliente);
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<Cliente> lista = new ArrayList<Cliente>();
		lista = parsingCliente("["+json+"]");
		http.disconnect();
		if(lista.isEmpty()) {
			return new Cliente();
		}else {
			return lista.get(0);
		}		
	}
}
