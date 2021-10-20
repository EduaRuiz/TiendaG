package com.tiendaG.model;

import javax.persistence.*;

@Entity
@Table(name = "proveedores")
public class Proveedor {
	
	@Id
	@Column(name="nit_proveedor", unique = true, nullable = false, length=20)
	private long nit_proveedor;
	
	@Column(name="ciudad_proveedor", nullable = false, length=255)
	private String ciudad_proveedor;
	
	@Column(name="direccion_proveedor", nullable = false, length=255)
	private String direccion_proveedor;
	
	@Column(name="nombre_proveedor", nullable = false, length=255)
	private String nombre_proveedor;
	
	@Column(name="telefono_proveedor", nullable = false, length=255)
	private String telefono_proveedor;

	public Long getNit_proveedor() {
		return nit_proveedor;
	}

	public void setNit_proveedor(Long nit_proveedor) {
		this.nit_proveedor = nit_proveedor;
	}

	public String getCiudad_proveedor() {
		return ciudad_proveedor;
	}

	public void setCiudad_proveedor(String ciudad_proveedor) {
		this.ciudad_proveedor = ciudad_proveedor;
	}

	public String getDireccion_proveedor() {
		return direccion_proveedor;
	}

	public void setDireccion_proveedor(String direccion_proveedor) {
		this.direccion_proveedor = direccion_proveedor;
	}

	public String getNombre_proveedor() {
		return nombre_proveedor;
	}

	public void setNombre_proveedor(String nombre_proveedor) {
		this.nombre_proveedor = nombre_proveedor;
	}

	public String getTelefono_proveedor() {
		return telefono_proveedor;
	}

	public void setTelefono_proveedor(String telefono_proveedor) {
		this.telefono_proveedor = telefono_proveedor;
	}
	
	@Override
	public String toString() {
		return nit_proveedor+ciudad_proveedor+direccion_proveedor+nombre_proveedor+telefono_proveedor+"";		
	}
}