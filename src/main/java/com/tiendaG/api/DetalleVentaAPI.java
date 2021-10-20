package com.tiendaG.api;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tiendaG.dao.DetalleVentaDAO;
import com.tiendaG.model.DetalleVenta;

@RestController //Permite identificar el controlador de la clase
@RequestMapping("/detalleVentas") //Raiz del servicio de REST para detalle de ventas
public class DetalleVentaAPI {

	@Autowired //Inyecta el objeto dao en la API
	private DetalleVentaDAO detalleVentaDao;
	
	@GetMapping(path = "/listar") //Metodo GET que pide información
	public ResponseEntity<List<DetalleVenta >> listar(){
		return new ResponseEntity<>(detalleVentaDao.findAll(),HttpStatus.OK);
	}
	
	@PostMapping(path = "/crear") //Metodo POST que envía información
	public ResponseEntity<DetalleVenta > crear(@RequestBody DetalleVenta detalleVenta) {
		return new ResponseEntity<>(detalleVentaDao.save(detalleVenta), HttpStatus.CREATED);
	}
	
	@PutMapping(path = "/listar") //Metodo PUT para actualizar la informacion
	public ResponseEntity<Object> actualizar(@RequestBody DetalleVenta detalleVenta) {
		detalleVentaDao.save(detalleVenta);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path = "/obtener/{codigo_detalle_venta}")
	public ResponseEntity<DetalleVenta > obtener(@PathVariable("codigo_detalle_venta") Long codigo){
		Optional<DetalleVenta > proveedorOptional = detalleVentaDao.findById(codigo);
		return new ResponseEntity<>(proveedorOptional.orElse(null),HttpStatus.OK);
	}
	
	@DeleteMapping(path ="/eliminar/{codigo_detalle_venta}") //Metodo DELETE para eliminar el registro
	public ResponseEntity<Object> eliminar(@PathVariable("codigo_detalle_venta") Long codigo) throws Exception {
		Optional<DetalleVenta > detalleVenta = detalleVentaDao.findById(codigo);
		if(detalleVenta == null) {
			throw new Exception("detalleVenta a eliminar no existe.");
		}
		
		detalleVentaDao.deleteById(codigo);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
}
