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

import com.tiendaG.dao.ProveedorDAO;
import com.tiendaG.model.Proveedor;

@RestController //Permite identificar el controlador de la clase
@RequestMapping("/proveedores") //Raiz del servicio de REST para proveedores
public class ProveedorAPI {
	
	@Autowired //Inyecta el objeto dao en la API
	private ProveedorDAO proveedorDao;
	
	@GetMapping(path = "/listar") //Metodo GET que pide información
	public ResponseEntity<List<Proveedor>> listar(){
		return new ResponseEntity<>(proveedorDao.findAll(),HttpStatus.OK);
	}
	
	@PostMapping(path = "/crear") //Metodo POST que envía información
	public ResponseEntity<Proveedor> crear(@RequestBody Proveedor proveedor) {
		return new ResponseEntity<>(proveedorDao.save(proveedor), HttpStatus.CREATED);
	}
	
	@PutMapping(path = "/actualizar") //Metodo PUT para actualizar la informacion
	public ResponseEntity<Object> actualizar(@RequestBody Proveedor proveedor) {
		proveedorDao.save(proveedor);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path = "/obtener/{nit_proveedor}")
	public ResponseEntity<Proveedor> obtener(@PathVariable("nit_proveedor") Long nit){
		Optional<Proveedor> proveedorOptional = proveedorDao.findById(nit);
		return new ResponseEntity<>(proveedorOptional.orElse(null),HttpStatus.OK);
	}
	
	@DeleteMapping(path ="/eliminar/{nit_proveedor}") //Metodo DELETE para eliminar el registro
	public ResponseEntity<Object> eliminar(@PathVariable("nit_proveedor") Long id) {
		proveedorDao.deleteById(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
