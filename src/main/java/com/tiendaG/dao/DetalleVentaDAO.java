package com.tiendaG.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tiendaG.model.DetalleVenta;

public interface DetalleVentaDAO extends JpaRepository <DetalleVenta, Long> {

}
