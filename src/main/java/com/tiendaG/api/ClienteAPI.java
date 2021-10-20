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

import com.tiendaG.dao.ClienteDAO;
import com.tiendaG.model.Cliente;

@RestController //Permite identificar el controlador de la clase
@RequestMapping("/clientes") //Raiz del servicio de REST para clientes
public class ClienteAPI {
	
	@Autowired //Inyecta el objeto dao en la API
	private ClienteDAO clienteDao;
	
	@GetMapping(path = "/listar") //Metodo GET que pide información
	public ResponseEntity<List<Cliente>> listar(){
		return new ResponseEntity<>(clienteDao.findAll(),HttpStatus.OK);
	}
	
	@PostMapping(path = "/crear") //Metodo POST que envía información
	public ResponseEntity<Cliente> crear(@RequestBody Cliente cliente) {
		return new ResponseEntity<>(clienteDao.save(cliente), HttpStatus.CREATED);
	}
	
	@PutMapping(path = "/actualizar") //Metodo PUT para actualizar la informacion
	public ResponseEntity<Object> actualizar(@RequestBody Cliente cliente) {
		clienteDao.save(cliente);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path = "/obtener/{cedula_cliente}") //Metodo GET trae la información
	public ResponseEntity<Cliente> obtener(@PathVariable("cedula_cliente") Long nit){
		Optional<Cliente> clienteOptional = clienteDao.findById(nit);
		return new ResponseEntity<>(clienteOptional.orElse(null),HttpStatus.OK);
	}
	
	@DeleteMapping(path ="/eliminar/{cedula_cliente}") //Metodo DELETE para eliminar el registro
	public ResponseEntity<Object> eliminar(@PathVariable("cedula_cliente") Long id) {
		clienteDao.deleteById(id);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
