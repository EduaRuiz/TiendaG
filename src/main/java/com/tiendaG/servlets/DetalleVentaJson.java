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

import com.tiendaG.model.DetalleVenta;

public class DetalleVentaJson {
	private static URL url;
	private static String sitio = "http://localhost:8080/TiendaG/detalleVentas/";
	
	public static ArrayList<DetalleVenta> parsingDetalleVenta(String json) throws ParseException {
		JSONParser jsonParser = new JSONParser();
		ArrayList<DetalleVenta> lista = new ArrayList<DetalleVenta>();
		JSONArray DetalleVenta = (JSONArray) jsonParser.parse(json);
		Iterator<?> i = DetalleVenta.iterator();
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			DetalleVenta detalleVenta = new DetalleVenta();
			detalleVenta.setCodigo_detalle_venta(Long.parseLong(innerObj.get("codigo_detalle_venta").toString()));
			detalleVenta.setCantidad_producto(Integer.parseInt(innerObj.get("cantidad_producto").toString()));
			detalleVenta.setCodigo_producto(Long.parseLong(innerObj.get("codigo_producto").toString()));
			detalleVenta.setCodigo_venta(Long.parseLong(innerObj.get("codigo_venta").toString()));
			detalleVenta.setValor_venta(Double.parseDouble(innerObj.get("valor_venta").toString()));
			detalleVenta.setValor_iva(Double.parseDouble(innerObj.get("valor_iva").toString()));
			detalleVenta.setValor_total(Double.parseDouble(innerObj.get("valor_total").toString()));
			lista.add(detalleVenta);
		}
		return lista;
	}
	
	public static ArrayList<DetalleVenta> getJSON() throws IOException, ParseException{
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
		ArrayList<DetalleVenta> lista = new ArrayList<DetalleVenta>();
		lista = parsingDetalleVenta(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(DetalleVenta detalleVenta) throws IOException {
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
			+ "\"codigo_detalle_venta\": \""+ detalleVenta.getCodigo_detalle_venta()
			+"\",\"cantidad_producto\": \""+detalleVenta.getCantidad_producto()
			+"\",\"codigo_producto\": \""+detalleVenta.getCodigo_producto()
			+"\",\"codigo_venta\": \""+detalleVenta.getCodigo_venta()			
			+"\",\"valor_venta\":\""+detalleVenta.getValor_venta()
			+"\",\"valor_iva\":\""+detalleVenta.getValor_iva()
			+"\",\"valor_total\":\""+detalleVenta.getValor_total()
			+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int putJSON(DetalleVenta detalleVenta) throws IOException {
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
				+ "\"codigo_detalle_venta\":\""+ detalleVenta.getCodigo_detalle_venta()
				+"\",\"cantidad_producto\": \""+detalleVenta.getCantidad_producto()
				+"\",\"codigo_producto\": \""+detalleVenta.getCodigo_producto()
				+"\",\"codigo_venta\": \""+detalleVenta.getCodigo_venta()			
				+"\",\"valor_venta\":\""+detalleVenta.getValor_venta()
				+"\",\"valor_iva\":\""+detalleVenta.getValor_iva()
				+"\",\"valor_total\":\""+detalleVenta.getValor_total()
				+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static int deleteJSON(String codigo_detalle_venta) throws IOException {		
		url = new URL(sitio+"eliminar/"+codigo_detalle_venta);
		HttpURLConnection http = (HttpURLConnection) url.openConnection();
		try {
			http.setRequestMethod("DELETE");
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
		http.setDoOutput(true);
		http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		http.connect();
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
	public static DetalleVenta getDetalleVenta(String codigo_venta) throws IOException, ParseException{
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
		ArrayList<DetalleVenta> lista = new ArrayList<DetalleVenta>();
		lista = parsingDetalleVenta("["+json+"]");
		http.disconnect();
		if(lista.isEmpty()) {
			return new DetalleVenta();
		}else {
			return lista.get(0);
		}		
	}
}