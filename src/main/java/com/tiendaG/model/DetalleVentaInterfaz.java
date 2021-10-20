package com.tiendaG.model;

public interface DetalleVentaInterfaz {
	
	public Long getCodigo_detalle_venta();

	public Integer getCantidad_producto();

	public Long getCodigo_producto();

	public Long getCodigo_venta();

	public Double getValor_iva();

	public Double getValor_venta();

	public Double getValor_total();

	public void setCodigo_detalle_venta(Long codigo_detalle_venta);

	public void setCantidad_producto(Integer cantidad_producto);	

	public void setCodigo_producto(Long codigo_producto);	

	public void setCodigo_venta(Long codigo_venta);
	
	public void setValor_iva(Double valor_iva);	

	public void setValor_venta(Double valor_venta);	

	public void setValor_total(Double valor_total);
}