package com.tiendaG.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tiendaG.model.Cliente;

public interface ClienteDAO extends JpaRepository <Cliente, Long> {

}
