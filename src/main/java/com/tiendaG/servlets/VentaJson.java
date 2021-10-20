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

import com.tiendaG.model.Venta;
import com.tiendaG.model.VentasPorClienteInterfaz;
import com.tiendaG.model.VentasPorCliente;

public class VentaJson {
	private static URL url;
	private static String sitio = "http://localhost:8080/TiendaG/ventas/";
	
	public static ArrayList<Venta> parsingVenta(String json) throws ParseException {		
		JSONParser jsonParser = new JSONParser();
		ArrayList<Venta> lista = new ArrayList<Venta>();
		JSONArray Venta = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = Venta.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Venta venta = new Venta();
			venta.setCodigo_venta(Long.parseLong(innerObj.get("codigo_venta").toString()));
			venta.setCedula_cliente(Long.parseLong(innerObj.get("cedula_cliente").toString()));
			venta.setCedula_usuario(Long.parseLong(innerObj.get("cedula_usuario").toString()));
			venta.setValor_venta(Double.parseDouble(innerObj.get("valor_venta").toString()));
			venta.setIva_venta(Double.parseDouble(innerObj.get("iva_venta").toString()));
			venta.setTotal_venta(Double.parseDouble(innerObj.get("total_venta").toString()));
			lista.add(venta);
		}
		return lista;
	}
	
	public static ArrayList<Venta> getJSON() throws IOException, ParseException{
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
		ArrayList<Venta> lista = new ArrayList<Venta>();
		lista = parsingVenta(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(Venta venta) throws IOException {
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
			+ "\"codigo_venta\":\""+ venta.getCodigo_venta()
			+"\",\"cedula_cliente\":\""+venta.getCedula_cliente()
			+"\",\"cedula_usuario\":\""+venta.getCedula_usuario()
			+"\",\"valor_venta\":\""+venta.getValor_venta()
			+"\",\"iva_venta\":\""+venta.getIva_venta()
			+"\",\"total_venta\":\""+venta.getTotal_venta()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int putJSON(Venta venta) throws IOException {
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
				+ "\"codigo_venta\":\""+ venta.getCodigo_venta()
				+"\",\"cedula_cliente\": \""+venta.getCedula_cliente()
				+"\",\"cedula_usuario\": \""+venta.getCedula_usuario()
				+"\",\"valor_venta\":\""+venta.getValor_venta()
				+"\",\"iva_venta\":\""+venta.getIva_venta()
				+"\",\"total_venta\":\""+venta.getTotal_venta()
				+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int deleteJSON(String codigo_venta) throws IOException {		
		url = new URL(sitio+"eliminar/"+codigo_venta);
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
	
	public static Venta getVenta(String codigo_venta) throws IOException, ParseException{
		url = new URL(sitio+"obtener/"+codigo_venta);
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<Venta> lista = new ArrayList<Venta>();
		lista = parsingVenta("["+json+"]");
		http.disconnect();
		if(lista.isEmpty()) {
			return new Venta();
		}else {
			return lista.get(0);
		}		
	}
	
	public static String getDetalleVentas(String codigo_venta) throws IOException, ParseException{
		url = new URL(sitio+"detalleVentas/"+codigo_venta);
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		http.disconnect();
		return json;
	}
	
	public static ArrayList<VentasPorClienteInterfaz> getVentasPorClienteJSON() throws IOException, ParseException{
		url = new URL(sitio+"ventasPorCliente");
		HttpURLConnection http = (HttpURLConnection)url.openConnection();
		http.setRequestMethod("GET");		
		http.setRequestProperty("Accept", "application/json");
		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";
		for (int i = 0; i<inp.length ; i++) {
			json += (char)inp[i];
			}
		ArrayList<VentasPorClienteInterfaz> lista = new ArrayList<VentasPorClienteInterfaz>();
		lista = parsingVentasPorCliente(json);
		http.disconnect();
		return lista;
	}
	
	public static ArrayList<VentasPorClienteInterfaz> parsingVentasPorCliente(String json) throws ParseException {		
		JSONParser jsonParser = new JSONParser();
		ArrayList<VentasPorClienteInterfaz> lista = new ArrayList<VentasPorClienteInterfaz>();
		JSONArray j = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = j.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			VentasPorClienteInterfaz registro = new VentasPorCliente();
			registro.setNombre(innerObj.get("nombre").toString());
			registro.setCedula(Long.parseLong(innerObj.get("cedula").toString()));
			registro.setTotalVentas(Double.parseDouble(innerObj.get("totalVentas").toString()));
			lista.add(registro);
		}
		return lista;
	}
}