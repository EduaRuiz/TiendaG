package com.tiendaG.model;

import javax.persistence.*;

@Entity
@Table(name = "productos")
public class Producto {
	
	@Id
	@Column(name="codigo_producto", unique = true, nullable = false, length=20)
	private Long codigo_producto;
	
	@JoinColumn(name = "nit_proveedor", nullable = false)
	private Long nit_proveedor;
	
	@Column(name="nombre_producto", nullable = false, length=255)
	private String nombre_producto;
	
	@Column(name="precio_compra", nullable = false)
	private double precio_compra;
	
	@Column(name="precio_venta", nullable = false)
	private double precio_venta;
	
	@Column(name="iva_compra", nullable = false)
	private double iva_compra;

	public Long getCodigo_producto() {
		return codigo_producto;
	}

	public void setCodigo_producto(Long codigo_producto) {
		this.codigo_producto = codigo_producto;
	}

	public Long getNit_proveedor() {
		return nit_proveedor;
	}

	public void setNit_proveedor(Long nit_proveedor) {
		this.nit_proveedor = nit_proveedor;
	}

	public String getNombre_producto() {
		return nombre_producto;
	}

	public void setNombre_producto(String nombre_producto) {
		this.nombre_producto = nombre_producto;
	}

	public double getPrecio_compra() {
		return precio_compra;
	}

	public void setPrecio_compra(double precio_compra) {
		this.precio_compra = precio_compra;
	}

	public double getPrecio_venta() {
		return precio_venta;
	}

	public void setPrecio_venta(double precio_venta) {
		this.precio_venta = precio_venta;
	}

	public double getIva_compra() {
		return iva_compra;
	}

	public void setIva_compra(double iva_compra) {
		this.iva_compra = iva_compra;
	}
	
	@Override
	public String toString() {
		return codigo_producto+nit_proveedor+nombre_producto+precio_compra+precio_venta+iva_compra+"";		
	}
}