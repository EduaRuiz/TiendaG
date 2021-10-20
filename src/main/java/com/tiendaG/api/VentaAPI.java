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

import com.tiendaG.dao.VentaDAO;
import com.tiendaG.model.DetalleVentaInterfaz;
import com.tiendaG.model.Venta;
import com.tiendaG.model.VentasPorClienteInterfaz;

@RestController //Permite identificar el controlador de la clase
@RequestMapping("/ventas") //Raiz del servicio de REST para proveedores
public class VentaAPI {

	@Autowired //Inyecta el objeto dao en la API
	private VentaDAO ventaDao;
	
	@GetMapping(path = "/listar") //Metodo GET que pide información
	public ResponseEntity<List<Venta>> listar(){
		return new ResponseEntity<>(ventaDao.findAll(),HttpStatus.OK);
	}
	
	@PostMapping(path = "/crear") //Metodo POST que envía información
	public ResponseEntity<Venta> crear(@RequestBody Venta venta) {
		return new ResponseEntity<>(ventaDao.save(venta), HttpStatus.CREATED);
	}
	
	@PutMapping(path = "/actualizar") //Metodo PUT para actualizar la informacion
	public ResponseEntity<Object> actualizar(@RequestBody Venta venta) {
		ventaDao.save(venta);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path = "/obtener/{codigo_venta}")
	public ResponseEntity<Venta> obtener(@PathVariable("codigo_venta") Long codigo){
		Optional<Venta> ventaOptional = ventaDao.findById(codigo);
		return new ResponseEntity<>(ventaOptional.orElse(null),HttpStatus.OK);
	}
	
	@DeleteMapping(path ="/eliminar/{codigo_venta}") //Metodo DELETE para eliminar el registro
	public ResponseEntity<Object> eliminar(@PathVariable("codigo_venta") Long codigo) throws Exception {
		Optional<Venta> venta = ventaDao.findById(codigo);
		if(venta == null) {
			throw new Exception("venta a eliminar no existe.");
		}
		
		ventaDao.deleteById(codigo);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path="/ventasPorCliente")
	public ResponseEntity<List<VentasPorClienteInterfaz>> ventasXcliente(){
		return new ResponseEntity<>(ventaDao.consulta(),HttpStatus.OK);
	}
	
	@GetMapping(path="/detalleVentas/{codigo_venta}")
	public ResponseEntity<List<DetalleVentaInterfaz>> detallesVentas(@PathVariable("codigo_venta") String codigo_venta){
		return new ResponseEntity<>(ventaDao.detalleVentas(codigo_venta),HttpStatus.OK);
	}	
}