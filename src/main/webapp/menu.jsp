<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

</head>
<body>
<ul class="nav nav-tabs justify-content-center bg-dark" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#usuarios" type="button" role="tab" aria-controls="usuarios" aria-selected="true">Usuarios</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="home-tab" data-bs-toggle="tab" data-bs-target="#clientes" type="button" role="tab" aria-controls="clientes" aria-selected="false">Clientes</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="home-tab" data-bs-toggle="tab" data-bs-target="#proveedores" type="button" role="tab" aria-controls="proveedores" aria-selected="false">Proveedores</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#productos" type="button" role="tab" aria-controls="productos" aria-selected="false">Productos</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#ventas" type="button" role="tab" aria-controls="ventas" aria-selected="false">Ventas</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="home-tab" data-bs-toggle="tab" data-bs-target="#reportes" type="button" role="tab" aria-controls="reportes" aria-selected="false">Reportes</button>
  </li>
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="usuarios" role="tabpanel" aria-labelledby="home-tab">...</div>
  <div class="tab-pane" id="clientes" role="tabpanel" aria-labelledby="profile-tab">...</div>
  <div class="tab-pane" id="proveedores" role="tabpanel" aria-labelledby="profile-tab">
  	<jsp:include page="Proveedores/proveedores.jsp"></jsp:include>
  </div>
  <div class="tab-pane fade" id="productos" role="tabpanel" aria-labelledby="profile-tab">...</div>
  <div class="tab-pane fade" id="ventas" role="tabpanel" aria-labelledby="profile-tab">...</div>
  <div class="tab-pane fade" id="reportes" role="tabpanel" aria-labelledby="profile-tab">...</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>

</body>
</html>