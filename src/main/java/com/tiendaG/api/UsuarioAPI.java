package com.tiendaG.api;

import java.util.List;
import java.util.Optional;

import java.lang.Long;

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

import com.tiendaG.dao.UsuarioDAO;
import com.tiendaG.model.Usuario;

@RestController //Permite identificar el controlador de la clase
@RequestMapping("/usuarios") //Raiz del servicio de REST para proveedores
public class UsuarioAPI {

	@Autowired //Inyecta el objeto dao en la API
	private UsuarioDAO usuarioDao;
	
	@GetMapping(path = "/listar") //Metodo GET que pide información
	public ResponseEntity<List<Usuario>> listar(){
		return new ResponseEntity<>(usuarioDao.findAll(),HttpStatus.OK);
	}
	
	@PostMapping(path = "/crear") //Metodo POST que envía información
	public ResponseEntity<Usuario> crear(@RequestBody Usuario usuario) {
		return new ResponseEntity<>(usuarioDao.save(usuario), HttpStatus.CREATED);
	}
	
	@PutMapping(path = "/actualizar") //Metodo PUT para actualizar la informacion
	public ResponseEntity<Object> actualizar(@RequestBody Usuario usuario) {
		usuarioDao.save(usuario);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(path = "/obtener/{cedula_usuario}") //Metodo GET trae la información
	public ResponseEntity<Usuario> obtener(@PathVariable("cedula_usuario") Long cedula){
		Optional<Usuario> usuarioOptional = usuarioDao.findById(cedula);
		return new ResponseEntity<>(usuarioOptional.orElse(null),HttpStatus.OK);
	}
	
	@DeleteMapping(path ="/eliminar/{cedula_usuario}") //Metodo DELETE para eliminar el registro
	public ResponseEntity<Object> eliminar(@PathVariable("cedula_usuario") Long cedula) throws Exception {
		Optional<Usuario> usuario = usuarioDao.findById(cedula);
		if(usuario == null) {
			throw new Exception("Usuario a eliminar no existe.");
		}else {
			usuarioDao.deleteById(cedula);
			return new ResponseEntity<>(HttpStatus.OK);
		}
	}
}