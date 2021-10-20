function ventasPorCliente(listaVentasPorClientes, total){
	var tabla = $(".table");
	$(tabla).append(
		'<thead class="table-dark">'+
			'<tr>'+
				'<th scope="col">Nombre</th>'+
				'<th scope="col">C&eacute;dula Cliente</th>'+
				'<th scope="col">Total Ventas</th>'+
			'</tr>'+
		'</thead>'+
		'<tbody id="myTable" class="cuerpoTable">'+
		'</tbody>'+
		'<tfoot class="table-dark">'+
			'<tr>'+
				'<td>Total</td>'+
				'<td></td>'+
				'<td class="text-end">'+total+'</td>'+
			'</tr>'+
		'</tfoot>)'
	);
	var cuerpo = $(".cuerpoTable");
	listaVentasPorClientes.forEach(function (fila){
		$(cuerpo).append(
			'<tr>'+
				'<td class="text-start">'+fila.cedula+'</td>'+
				'<td>'+fila.nombre+'</td>'+
				'<td class="text-end">'+formatter.format(fila.total)+'</td>'+
			'</tr>'
		);
	});
};

function clientes(listaClientes){
	var tabla = $(".table");
	$(tabla).append(
		'<thead class="table-dark">'+
			'<tr>'+
				'<th scope="col">Cedula</th>'+
				'<th scope="col">Nombre</th>'+
				'<th scope="col">Email</th>'+
				'<th scope="col">Telefono</th>'+
				'<th scope="col">Direccion</th>'+
			'</tr>'+
		'</thead>'+
		'<tbody id="myTable" class="cuerpoTable">'+
		'</tbody>'
	);
	var cuerpo = $(".cuerpoTable");
	listaClientes.forEach(function (fila){
		$(cuerpo).append(
			'<tr>'+
				'<td class="text-start">'+fila.cedula+'</td>'+
				'<td>'+fila.nombre+'</td>'+
				'<td class="text-end">'+fila.email+'</td>'+
				'<td class="text-end">'+fila.telefono+'</td>'+
				'<td class="text-end">'+fila.direccion+'</td>'+
			'</tr>'
		);
	});
};

function usuarios(listaUsuarios){
	var tabla = $(".table");
	$(tabla).append(
		'<thead class="table-dark">'+
			'<tr>'+
				'<th scope="col">Cedula</th>'+
				'<th scope="col">Nombre</th>'+
				'<th scope="col">Email</th>'+
				'<th scope="col">Usuario</th>'+
				'<th scope="col">Contrase&ntilde;a</th>'+
			'</tr>'+
		'</thead>'+
		'<tbody id="myTable" class="cuerpoTable">'+
		'</tbody>'
	);
	var cuerpo = $(".cuerpoTable");
	listaUsuarios.forEach(function (fila){
		$(cuerpo).append(
			'<tr>'+
				'<td class="text-start">'+fila.cedula+'</td>'+
				'<td>'+fila.nombre+'</td>'+
				'<td class="text-end">'+fila.email+'</td>'+
				'<td class="text-end">'+fila.usuario+'</td>'+
				'<td class="text-end">'+fila.password+'</td>'+
			'</tr>'
		);
	});
};