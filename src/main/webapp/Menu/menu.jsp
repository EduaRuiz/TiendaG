<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/favicon.jpg" href="favicon.ico"/>
        <link href="favicon.ico" rel="icon" type="image/x-icon"/>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

    </head>
    <body>
        <div>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a href="http://localhost:8080/TiendaG/Menu/menuPpal.jsp" class="navbar-brand">TiendaG</a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#MenuG">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="MenuG">
                        <ul class="navbar-nav text-center ms-auto">
                            <li class="nav-item">
                                <a style="border:none;" href="./Usuarios" class="btn btn-outline-light mx-1" target="_self">Usuarios</a>
                            </li>
                            <li class="nav-item">
                                <a style="border:none;" href="./Clientes" class="btn btn-outline-light mx-1" target="_self">Clientes</a>
                            </li>
                            <li class="nav-item">
                                <a style="border:none;" href="./Proveedores" class="btn btn-outline-light mx-1" target="_self">Proveedores</a>
                            </li>
                            <li class="nav-item">
                                <a style="border:none;" href="./Productos" class="btn btn-outline-light mx-1" target="_self">Productos</a>
                            </li>
                            <li class="nav-item">
                                <a style="border:none;" href="./Ventas" class="btn btn-outline-light mx-1" target="_self">Ventas</a>
                            </li>
                            <li class="nav-item dropdown">
                             <a class="nav-link dropdown-toggle text-white mx-1" href="#" id="reportes" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                               Reporte Ventas
                              </a>
                              <ul class="dropdown-menu" aria-labelledby="reportes">
	                              <li><a class="dropdown-item" href="./Reportes?opcion=usuarios">Listado de Usuarios</a></li>
	                              <li><a class="dropdown-item" href="./Reportes?opcion=clientes">Listado de Clientes</a></li>
	                              <li><a class="dropdown-item" href="./Reportes?opcion=ventasPorCliente">Ventas por Cliente</a></li>
                             </ul>
                          </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    </body>
</html>