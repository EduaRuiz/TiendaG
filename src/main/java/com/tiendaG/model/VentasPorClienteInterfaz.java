package com.tiendaG.model;

public interface VentasPorClienteInterfaz {
	
	String getNombre();
	Long getCedula();
	Double getTotalVentas();
	
	void setNombre(String nombre);
	void setCedula(Long cedula);
	void setTotalVentas(Double totalVentas);
}