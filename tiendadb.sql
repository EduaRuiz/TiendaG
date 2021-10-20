CREATE DATABASE `tiendadb`;

CREATE TABLE `clientes` (
  `cedula_cliente` bigint NOT NULL,
  `direccion_cliente` varchar(255) DEFAULT NULL,
  `email_cliente` varchar(255) DEFAULT NULL,
  `nombre_cliente` varchar(255) DEFAULT NULL,
  `telefono_cliente` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cedula_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `detalle_ventas` (
  `codigo_detalle_venta` bigint NOT NULL,
  `cantidad_producto` int NOT NULL,
  `codigo_producto` bigint NOT NULL,
  `codigo_venta` bigint NOT NULL,
  `valor_total` double DEFAULT NULL,
  `valor_venta` double DEFAULT NULL,
  `valoriva` double DEFAULT NULL,
  PRIMARY KEY (`codigo_detalle_venta`),
  KEY `codigo_producto` (`codigo_producto`),
  KEY `codigo_venta` (`codigo_venta`),
  CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo_producto`),
  CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`codigo_venta`) REFERENCES `ventas` (`codigo_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productos` (
  `codigo_producto` bigint NOT NULL,
  `iva_compra` double DEFAULT NULL,
  `nit_proveedor` bigint NOT NULL,
  `nombre_producto` varchar(255) DEFAULT NULL,
  `precio_compra` double DEFAULT NULL,
  `precio_venta` double DEFAULT NULL,
  PRIMARY KEY (`codigo_producto`),
  KEY `nit_proveedor` (`nit_proveedor`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`nit_proveedor`) REFERENCES `proveedores` (`nit_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `proveedores` (
  `nit_proveedor` bigint NOT NULL,
  `ciudad_proveedor` varchar(255) NOT NULL,
  `direccion_proveedor` varchar(255) NOT NULL,
  `nombre_proveedor` varchar(255) NOT NULL,
  `telefono_proveedor` varchar(255) NOT NULL,
  PRIMARY KEY (`nit_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuarios` (
  `cedula_usuario` bigint NOT NULL,
  `email_usuario` varchar(255) NOT NULL,
  `nombre_usuario` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `usuario` varchar(255) NOT NULL,
  PRIMARY KEY (`cedula_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ventas` (
  `codigo_venta` bigint NOT NULL,
  `cedula_cliente` bigint NOT NULL,
  `cedula_usuario` bigint NOT NULL,
  `ivaventa` double DEFAULT NULL,
  `total_venta` double DEFAULT NULL,
  `valor_venta` double DEFAULT NULL,
  PRIMARY KEY (`codigo_venta`),
  KEY `cedula_cliente` (`cedula_cliente`),
  KEY `cedula_usuario` (`cedula_usuario`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cedula_cliente`) REFERENCES `clientes` (`cedula_cliente`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`cedula_usuario`) REFERENCES `usuarios` (`cedula_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
