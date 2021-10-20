package com.tiendaG.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ventas")
public class Venta {
	
	@Id	
	@Column(name="codigo_venta", unique = true, nullable = false, length=20)
	private Long codigo_venta;
	
	@Column(name="cedula_cliente", nullable = false, length=20)
	private Long cedula_cliente;
	
	@Column(name="cedula_usuario", nullable = false, length=20)
	private Long cedula_usuario;
	
	@Column(name="iva_venta", nullable = false)
	private Double iva_venta;
	
	@Column(name="valor_venta", nullable = false)
	private Double valor_venta;
	
	@Column(name="total_venta", nullable = false)
	private Double total_venta;

	public Long getCodigo_venta() {
		return codigo_venta;
	}

	public void setCodigo_venta(Long codigo_venta) {
		this.codigo_venta = codigo_venta;
	}

	public Long getCedula_cliente() {
		return cedula_cliente;
	}

	public void setCedula_cliente(Long cedula_cliente) {
		this.cedula_cliente = cedula_cliente;
	}

	public Long getCedula_usuario() {
		return cedula_usuario;
	}

	public void setCedula_usuario(Long cedula_usuario) {
		this.cedula_usuario = cedula_usuario;
	}

	public Double getIva_venta() {
		return iva_venta;
	}

	public void setIva_venta(Double iva_venta) {
		this.iva_venta = iva_venta;
	}

	public Double getValor_venta() {
		return valor_venta;
	}

	public void setValor_venta(Double valor_venta) {
		this.valor_venta = valor_venta;
	}

	public Double getTotal_venta() {
		return total_venta;
	}

	public void setTotal_venta(Double total_venta) {
		this.total_venta = total_venta;
	}
	
	@Override
	public String toString() {
		return codigo_venta+cedula_cliente+cedula_usuario+iva_venta+valor_venta+total_venta+"";
	}
}
