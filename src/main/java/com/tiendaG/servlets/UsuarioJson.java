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

import com.tiendaG.model.Usuario;

public class UsuarioJson {	
	private static URL url;
	private static String sitio = "http://localhost:8080/TiendaG/usuarios/";
	
	public static ArrayList<Usuario> parsingUsuario(String json) throws ParseException {
		JSONParser jsonParser = new JSONParser();
		ArrayList<Usuario> lista = new ArrayList<Usuario>();
		JSONArray Usuario = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = Usuario.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Usuario usuario = new Usuario();
			usuario.setCedula_usuario(Long.parseLong(innerObj.get("cedula_usuario").toString()));
			usuario.setEmail_usuario(innerObj.get("email_usuario").toString());
			usuario.setNombre_usuario(innerObj.get("nombre_usuario").toString());
			usuario.setUsuario(innerObj.get("usuario").toString());
			usuario.setPassword(innerObj.get("password").toString());
			lista.add(usuario);
		}
		return lista;
	}
	
	public static ArrayList<Usuario> getJSON() throws IOException, ParseException{
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
		ArrayList<Usuario> lista = new ArrayList<Usuario>();
		lista = parsingUsuario(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(Usuario usuario) throws IOException {
		url = new URL(sitio+"obtener");
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
			+ "\"cedula_usuario\": \""+ usuario.getCedula_usuario()
			+"\",\"email_usuario\": \""+usuario.getEmail_usuario()
			+"\",\"nombre_usuario\": \""+usuario.getNombre_usuario()
			+"\",\"password\": \""+usuario.getPassword()
			+"\",\"usuario\": \""+usuario.getUsuario()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int putJSON(Usuario usuario) throws IOException {
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
				+ "\"cedula_usuario\": \""+ usuario.getCedula_usuario()
				+"\",\"email_usuario\": \""+usuario.getEmail_usuario()
				+"\",\"nombre_usuario\": \""+usuario.getNombre_usuario()
				+"\",\"password\": \""+usuario.getPassword()
				+"\",\"usuario\": \""+usuario.getUsuario()
				+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int deleteJSON(String cedula_usuario) throws IOException {		
		url = new URL(sitio+"eliminar/"+cedula_usuario);
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
	
	public static Usuario getUsuario(String cedula_usuario) throws IOException, ParseException{
		url = new URL(sitio+"obtener/"+cedula_usuario);
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<Usuario> lista = new ArrayList<Usuario>();
		lista = parsingUsuario("["+json+"]");
		http.disconnect();
		if(lista.isEmpty()) {
			return new Usuario();
		}else {
			return lista.get(0);
		}		
	}
}