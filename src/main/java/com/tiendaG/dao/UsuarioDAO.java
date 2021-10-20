package com.tiendaG.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tiendaG.model.Usuario;

public interface UsuarioDAO extends JpaRepository<Usuario, Long> {
}