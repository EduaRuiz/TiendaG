package com.tiendaG.model;


public class VentasPorCliente implements VentasPorClienteInterfaz {
	private String nombre;
	private Long cedula;
	private Double totalVentas;
	
	@Override
	public String getNombre() {
		return nombre;
	}
	@Override
	public Long getCedula() {
		return cedula;
	}
	@Override
	public Double getTotalVentas() {
		return totalVentas;
	}
	@Override
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	@Override
	public void setCedula(Long cedula) {
		this.cedula = cedula;
	}
	@Override
	public void setTotalVentas(Double totalVentas) {
		this.totalVentas = totalVentas;
	}
}