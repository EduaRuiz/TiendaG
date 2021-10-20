package com.tiendaG.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tiendaG.model.DetalleVentaInterfaz;
import com.tiendaG.model.Venta;
import com.tiendaG.model.VentasPorClienteInterfaz;

public interface VentaDAO extends JpaRepository <Venta, Long> {
	
	@Query(nativeQuery = true,
			value="SELECT c.nombre_cliente AS nombre, v.cedula_cliente AS cedula, sum(v.total_venta) AS totalVentas FROM ventas v NATURAL JOIN clientes c GROUP BY v.cedula_cliente")
	public List<VentasPorClienteInterfaz> consulta();
	
	@Query(nativeQuery = true,
			value="SELECT * FROM detalle_ventas WHERE codigo_venta = ?1")
	public List<DetalleVentaInterfaz> detalleVentas(String codigo_venta);
}