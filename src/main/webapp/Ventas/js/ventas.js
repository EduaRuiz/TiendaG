var listaProductos;
var listaUsuarios;
var listaClientes;
var listaVentas;
var listaDetalleVentas;
var listaCarro = [];
var productosEnCarro = 0;
var wrapper = $(".carritoProductos");

function listas(productos, usuarios, clientes, ventas, detalles) {
  listaProductos = productos;
  listaUsuarios = usuarios;
  listaClientes = clientes;
  listaVentas = ventas;
  listaDetalleVentas = detalles
}

//HALLA EL VALOR DE LA CONSULTA	DE PRODUCTOS
function valorProducto(cantidad, codigo) {
  if (cantidad != 0) {
    listaProductos.forEach(function (product) {
      if (product.codigo == codigo) {
        var valor = formatter.format(cantidad * product.precioVenta);
        $('#valor_producto').val(valor);
      };
    })
  }
}

//HALLA EL NOMBRE DEL PRODUCTO SELECCIONADO
function nombreProducto(codigo) {
  if (codigo != 0) {
    listaProductos.forEach(function (product) {
      if (product.codigo == codigo) {
        $('#nombre_producto').val(product.nombre);
      };
    })
  }
}

//HALLA EL NOMBRE DEL USUARIO SELECCIONADO
function nombreUsuario(cedula) {
  if (cedula != 0) {
    listaUsuarios.forEach(function (user) {
      if (user.cedula == cedula) {
        $('#nombre_usuario').val(user.nombre);
      };
    })
  }
}

//HALLA EL NOMBRE DEL CLIENTE SELECCIONADO
function nombreCliente(cedula) {
  if (cedula != 0) {
    listaClientes.forEach(function (client) {
      if (client.cedula == cedula) {
        $('#nombre_cliente').val(client.nombre);
      };
    })
  }
}

//FORMATEA EL VALOR DE CADA TOTAL A DOLARES
var formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
});

//COMPRUEBA SI EL CODIGO DE VENTA EXISTE
function existe(codigo) {
  let booleano = true;
  listaVentas.forEach(function (sell) {
    if (sell.codigo == codigo) {
      new bootstrap.Toast($('#codigoVentaExistenteToast')).show();
      $('#codigo_venta').val('');
      booleano = false;
    };
  })
  if (booleano) {
    $('#codigoVenta').val(codigo);
  }

};

//CALCULA LOS VALORES DEL TOTAL DEL CARRITO
function valorTotal() {
  var productoXcantidad = $('input[name^=carrito]').map(function (idx, elem) {
    return $(elem).val();
  }).get();

  if (productoXcantidad[0] != undefined) {
    let suma = 0;
    let ivaT = 0;
    let total = 0;
    productoXcantidad.forEach(function (elemento) {
      let carro = elemento.split("-");
      let codigo = carro[0];
      let cantidad = carro[1];
      listaProductos.forEach(function (product) {
        if (product.codigo == codigo) {
          let valor = cantidad * product.precioVenta;
          let iva = valor * (product.ivaCompra / 100);
          suma = suma + valor;
          ivaT = ivaT + iva;
        };
      });
      total = suma + ivaT;
      $('#valor_venta').val(formatter.format(suma));
      $('#iva_venta').val(formatter.format(ivaT));
      $('#total_venta').val(formatter.format(total));
      $('#valorVenta').val(suma);
      $('#ivaVenta').val(ivaT);
      $('#totalVenta').val(total);
      activarBtn();
    });
  } else {
    $('#valor_venta').val('');
    $('#iva_venta').val('');
    $('#total_venta').val('');
    $('#valorVenta').val('');
    $('#ivaVenta').val('');
    $('#totalVenta').val('');
    desactivarBtn();
  }
}

//FORMATEA LA SELECCION
function limpiarConsulta() {
  $("#codigo_producto").val('default').selectpicker("refresh");
  $("#nombre_producto").val('');
  $("#cantidad_producto").val('');
  $("#valor_producto").val('');
}

//EVENTO QUE REVISA SI LA CANTIDAD DE PRODUCTO CAMBIA
$('#cantidad_producto').on('change paste keyup input', function (e) {
  var codigo = $('#codigo_producto').val();
  valorProducto(this.value, codigo);

});

//EVENTO QUE REVISA SI LE CODIGO DE PRODUCTO SELECCIONADO CAMBIA
$('#codigo_producto').on('change', function (e) {
  var cantidad = $('#cantidad_producto').val();
  nombreProducto(this.value);
  valorProducto(cantidad, this.value);
});

//EVENTO QUE REVISA SI LA CEDULA DEL USUARIO SELECCIONADO CAMBIA
$('#cedula_usuario').on('change', function (e) {
  nombreUsuario(this.value);
});

//EVENTO QUE REVISA SI LA CEDULA DEL CLIENTE SELECCIONADO CAMBIA
$('#cedula_cliente').on('change', function (e) {
  nombreCliente(this.value);
});

//TODA LA FUNCION SE ENCARGA DE GESTIONAR EL CARRITO
$(document).ready(function () {
  var max_fields = 9;
  var add_button = $("#agregarBtn");

  //PARTE ENCARGADA DE AGREGAR PRODUCTOS AL CARRITO  
  $(add_button).click(function (e) {
    e.preventDefault();
    existe($('#codigo_venta').val());
    if ($('#codigo_producto').val() != 0 && $('#cantidad_producto').val() != 0 && $('#cedula_cliente').val() != 0 && $('#cedula_usuario').val() != 0 && $('#codigo_venta').val() != 0) {
      let existe = false;
      listaCarro.forEach((producto) => {
        if ($("#codigo_producto").val() == producto.codigo) {
          productoExistente();
          existe = true;
        };
      });
      if (!existe) {
        if (productosEnCarro < max_fields) {
          productoNuevo();
          productosEnCarro++;
        } else {
          new bootstrap.Toast($('#limiteToast')).show();
        };          
      };
      productoEnCarro();
      limpiarConsulta();
      valorTotal();
    } else if ($('#cedula_cliente').val() == 0) {
      new bootstrap.Toast($('#clienteToast')).show();
    } else if ($('#cedula_usuario').val() == 0) {
      new bootstrap.Toast($('#usuarioToast')).show();
    } else if ($('#codigo_venta').val() == 0) {
      new bootstrap.Toast($('#codigoVentaToast')).show();
    } else if ($('#codigo_producto').val() == 0) {
      new bootstrap.Toast($('#codigoProductoToast')).show();
    } else if ($('#cantidad_producto').val() == 0) {
      new bootstrap.Toast($('#cantidadProductoToast')).show();
    };    
  });

  //PARTE ENCARGADA DE ELEIMINAR PRODUCTOS DEL CARRITO
  $(wrapper).on("click", "#eliminarBtn", function (e) {
    e.preventDefault();
    $(this).parent('div').remove();
    productosEnCarro--;
    valorTotal();
    productoEnCarro();
    new bootstrap.Toast($('#productoEliminadoToast')).show();
  });
});

//DESACTIVA BOTON CONFIRMAR AL ARRANCAR
$(document).ready(function () {
  $(':input[type="submit"]').prop('disabled', true);
});

//DESACTIVA BOTON CONFIRMAR
function desactivarBtn() {
  $(':input[type="submit"]').prop('disabled', true);
};

//ACTIVA BOTON CONFIRMAR
function activarBtn() {
  $(':input[type="submit"]').prop('disabled', false);
};

//AGREGAR PRODUCTO NUEVO A LA CANASTA
function productoNuevo() {
  $('#cedulaCliente').val($('#cedula_cliente').val());
  $('#cedulaUsuario').val($('#cedula_usuario').val());
  $(wrapper).append(
    '<div class="row mb-1">' +
    '<div class="col-1"></div>' +
    '<button type="button" class="col-1 btn btn-danger btn-sm" id="eliminarBtn">Eliminar</button>' +
    '<input type="hidden" id="'+$("#codigo_producto").val()+'" name="carrito" value="'+$("#codigo_producto").val()+'-'+$("#cantidad_producto").val()+'">' +
    '<input class="col-2 text-center" type="number" value="'+$("#codigo_producto").val()+'" readonly>' +
    '<input class="col" type="text" value="'+$("#nombre_producto").val()+'" readonly>' +
    '<input class="col-1 text-center" id="'+$("#codigo_producto").val()+'cantidad" type="number" value="'+$("#cantidad_producto").val()+'" readonly>' +
    '<input class="col text-end" id="'+$("#codigo_producto").val()+'valor" type="text" value="'+$("#valor_producto").val()+'" readonly>' +
    '<div class="col-1"></div>' +
    '</div>');
    new bootstrap.Toast($('#productoAgregadoToast')).show();
};

//AGREGAR PRODUCTO EXISTENTE A LA CANASTA
function productoExistente() {
  listaCarro.forEach((producto) => {
    if ($("#codigo_producto").val() == producto.codigo) {
      let idOculto = "#" + producto.codigo;
      let idCAntidad = "#" + producto.codigo + "cantidad";
      let idValor = "#" + producto.codigo + "valor";
      let cantidad = parseInt($("#cantidad_producto").val()) + parseInt(producto.cantidad);
      $(idOculto).val($("#codigo_producto").val() + '-' + cantidad);
      $(idCAntidad).val(cantidad);
      let valor;
      listaProductos.forEach(function (product) {
        if (product.codigo == producto.codigo) {
          valor = cantidad * product.precioVenta;
        };
        $(idValor).val(formatter.format(valor));
      });
    };
  });
  new bootstrap.Toast($('#productoActualizadoToast')).show();
};

//FUNCION QUE REVISA SI EL PRODUCTO YA ESTÁ INCLUIDO EN EL CARRO
function productoEnCarro() {
  listaCarro = [];
  document.getElementsByName('carrito').forEach((producto) => {
    let temp = {
      codigo: producto.value.split("-")[0],
      cantidad: producto.value.split("-")[1]
    }
    listaCarro.push(temp);
  });
};

//FUNCION PARA AGREGAR DATOS DE VETA EXISTENTE
function llenarCarro(){
  listaDetalleVentas.forEach(function (detalle) {
    let nombre;
    let valor;
    listaProductos.forEach(function (product) {
      if (product.codigo == detalle.codigoProducto) {
        valor = formatter.format(detalle.cantidadProducto * product.precioVenta);
        nombre = product.nombre;
      };
    });
    $(wrapper).append(
      '<div class="row mb-1">' +
      '<div class="col-1"></div>' +
      '<button type="button" class="col-1 btn btn-danger btn-sm" id="eliminarBtn">Eliminar</button>' +
      '<input type="hidden" id="'+detalle.codigoProducto+'" name="carrito" value="'+detalle.codigoProducto+'-'+detalle.cantidadProducto+'">' +
      '<input class="col-2 text-center" type="number" value="'+detalle.codigoProducto+'" readonly>' +
      '<input class="col" type="text" value="'+nombre+'" readonly>' +
      '<input class="col-1 text-center" id="'+detalle.codigoProducto+'cantidad" type="number" value="'+detalle.cantidadProducto+'" readonly>' +
      '<input class="col text-end" id="'+detalle.codigoProducto+'valor" type="text" value="'+valor+'" readonly>' +
      '<div class="col-1"></div>' +
      '</div>');      
    productosEnCarro++; 
  });
  productoEnCarro();
  limpiarConsulta();
  valorTotal();
};