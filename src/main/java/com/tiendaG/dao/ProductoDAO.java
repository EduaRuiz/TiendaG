package com.tiendaG.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tiendaG.model.Producto;

public interface ProductoDAO extends JpaRepository<Producto, Long> {

}
