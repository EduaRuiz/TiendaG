package com.tiendaG.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "usuarios")
public class Usuario {

	@Id
	@Column(name="cedula_usuario", unique = true, nullable = false, length=20)
	private Long cedula_usuario;
	
	@Column(name="email_usuario", nullable = false, length=255)
	private String email_usuario;
	
	@Column(name="nombre_usuario", nullable = false, length=255)
	private String nombre_usuario;
	
	@Column(name="password", nullable = false, length=255)
	private String password;
	
	@Column(name="usuario", nullable = false, length=255)
	private String usuario;

	public Long getCedula_usuario() {
		return cedula_usuario;
	}

	public void setCedula_usuario(Long cedula_usuario) {
		this.cedula_usuario = cedula_usuario;
	}

	public String getEmail_usuario() {
		return email_usuario;
	}

	public void setEmail_usuario(String email_usuario) {
		this.email_usuario = email_usuario;
	}

	public String getNombre_usuario() {
		return nombre_usuario;
	}

	public void setNombre_usuario(String nombre_usuario) {
		this.nombre_usuario = nombre_usuario;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	@Override
	public String toString() {
		return cedula_usuario+email_usuario+nombre_usuario+usuario+password+"";		
	}
}