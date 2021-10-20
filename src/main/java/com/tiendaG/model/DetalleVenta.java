package com.tiendaG.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "detalle_ventas")
public class DetalleVenta implements DetalleVentaInterfaz {
	
	@Id	
	@Column(name="codigo_detalle_venta", unique = true, nullable = false, length=20)
	private Long codigo_detalle_venta;

	@Column(name="cantidad_producto", nullable = false, length=20)
	private Integer cantidad_producto;
	
	@JoinColumn(name = "codigo_producto", nullable = false)
	@Column(name="codigo_producto", nullable = false, length=20)
	private Long codigo_producto;
	
	@JoinColumn(name = "codigo_venta", nullable = false)
	@Column(name="codigo_venta", nullable = false, length=20)
	private Long codigo_venta;
	
	@Column(name="valor_iva", nullable = false)
	private Double valor_iva;
	
	@Column(name="valor_venta", nullable = false)
	private Double valor_venta;
	
	@Column(name="valor_total", nullable = false)
	private Double valor_total;
	
	public DetalleVenta() {
		
	}

	public DetalleVenta(Long codigo_detalle_venta, Integer cantidad_producto, Long codigo_producto, Long codigo_venta,
			Double valor_iva, Double valor_venta, Double valo_total) {
		this.codigo_detalle_venta = codigo_detalle_venta;
		this.cantidad_producto = cantidad_producto;
		this.codigo_producto = codigo_producto;
		this.codigo_venta = codigo_venta;
		this.valor_iva = valor_iva;
		this.valor_venta = valor_venta;
		this.valor_total = valo_total;
	}

	@Override
	public Long getCodigo_detalle_venta() {
		return codigo_detalle_venta;
	}

	@Override
	public Integer getCantidad_producto() {
		return cantidad_producto;
	}

	@Override
	public Long getCodigo_producto() {
		return codigo_producto;
	}

	@Override
	public Long getCodigo_venta() {
		return codigo_venta;
	}

	@Override
	public Double getValor_iva() {
		return valor_iva;
	}

	@Override
	public Double getValor_venta() {
		return valor_venta;
	}

	@Override
	public Double getValor_total() {
		return valor_total;
	}

	@Override
	public void setCodigo_detalle_venta(Long codigo_detalle_venta) {
		this.codigo_detalle_venta = codigo_detalle_venta;
	}

	@Override
	public void setCantidad_producto(Integer cantidad_producto) {
		this.cantidad_producto = cantidad_producto;
	}

	@Override
	public void setCodigo_producto(Long codigo_producto) {
		this.codigo_producto = codigo_producto;
	}

	@Override
	public void setCodigo_venta(Long codigo_venta) {
		this.codigo_venta = codigo_venta;
	}

	@Override
	public void setValor_iva(Double valor_iva) {
		this.valor_iva = valor_iva;
	}

	@Override
	public void setValor_venta(Double valor_venta) {
		this.valor_venta = valor_venta;
	}

	@Override
	public void setValor_total(Double valor_total) {
		this.valor_total = valor_total;
	}	
}