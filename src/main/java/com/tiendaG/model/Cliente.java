package com.tiendaG.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "clientes")
public class Cliente {

	@Id	
	@Column(name="cedula_cliente", unique = true, nullable = false, length=20)
	private Long cedula_cliente;
	
	@Column(name="direccion_cliente", nullable = false, length=255)
	private String direccion_cliente;
	
	@Column(name="email_cliente", nullable = false, length=255)
	private String email_cliente;
	
	@Column(name="nombre_cliente", nullable = false, length=255)
	private String nombre_cliente;
	
	@Column(name="telefono_cliente", nullable = false, length=255)
	private String telefono_cliente;

	public Long getCedula_cliente() {
		return cedula_cliente;
	}

	public void setCedula_cliente(Long cedula_cliente) {
		this.cedula_cliente = cedula_cliente;
	}

	public String getDireccion_cliente() {
		return direccion_cliente;
	}

	public void setDireccion_cliente(String direccion_cliente) {
		this.direccion_cliente = direccion_cliente;
	}

	public String getEmail_cliente() {
		return email_cliente;
	}

	public void setEmail_cliente(String email_cliente) {
		this.email_cliente = email_cliente;
	}

	public String getNombre_cliente() {
		return nombre_cliente;
	}

	public void setNombre_cliente(String nombre_cliente) {
		this.nombre_cliente = nombre_cliente;
	}

	public String getTelefono_cliente() {
		return telefono_cliente;
	}

	public void setTelefono_cliente(String telefono_cliente) {
		this.telefono_cliente = telefono_cliente;
	}

	@Override
	public String toString() {
		return cedula_cliente+direccion_cliente+email_cliente+nombre_cliente+telefono_cliente+"";		
	}
}