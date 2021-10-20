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

import com.tiendaG.dao.ProductoDAO;
import com.tiendaG.model.Producto;

@RestController //Permite identificar el controlador de la clase
@RequestMapping("/productos") //Raiz del servicio de REST para productos
public class ProductoAPI {

	@Autowired //Inyecta el objeto dao en la API
	private ProductoDAO productoDao;
	
	@GetMapping(path = "/listar") //Metodo GET que pide información
	public ResponseEntity<List<Producto>> listar(){
		return new ResponseEntity<>(productoDao.findAll(),HttpStatus.OK);
	}
	
	@PostMapping(path = "/crear") //Metodo POST que envía información
	public ResponseEntity<Producto> crear(@RequestBody Producto producto) {
		return new ResponseEntity<>(productoDao.save(producto), HttpStatus.CREATED);
	}
	
	@PutMapping(path = "/actualizar") //Metodo PUT para actualizar la informacion
	public ResponseEntity<Object> actualizar(@RequestBody Producto producto) {
		productoDao.save(producto);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path = "/obtener/{codigo_producto}")
	public ResponseEntity<Producto> obtener(@PathVariable("codigo_producto") Long codigo){
		Optional<Producto> proveedorOptional = productoDao.findById(codigo);
		return new ResponseEntity<>(proveedorOptional.orElse(null),HttpStatus.OK);
	}
	
	@DeleteMapping(path ="/eliminar/{codigo_producto}") //Metodo DELETE para eliminar el registro
	public ResponseEntity<Object> eliminar(@PathVariable("codigo_producto") Long codigo) throws Exception {
		Optional<Producto> producto = productoDao.findById(codigo);
		if(producto == null) {
			throw new Exception("Producto a eliminar no existe.");
		}else {
			productoDao.deleteById(codigo);
			return new ResponseEntity<>(HttpStatus.OK);			
		}
	}	
}