CREATE TABLE `articulos` (
  `paquete_id` int(10) unsigned NOT NULL,
  `descripcion` varchar(50) NOT NULL DEFAULT '',
  `cantidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`descripcion`,`paquete_id`),
  KEY `paquete_contiene` (`paquete_id`)
) ENGINE=InnoDB;

CREATE TABLE `clientes` (
  `id` varchar(9) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `saldo` decimal(14,3) unsigned NOT NULL,
  `nombre` varchar(16) NOT NULL,
  `apellido` varchar(16) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `alt_telefono` varchar(11) DEFAULT NULL,
  `direccion_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_cliente` (`direccion_id`),
  CONSTRAINT `CHK_telefono_clientes` CHECK (`telefono` regexp '^[0-9].*')
) ENGINE=InnoDB;

CREATE TABLE `direcciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `ciudad` varchar(20) NOT NULL,
  `parroquia` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `direccion_unica` (`id_pais`,`estado`,`ciudad`,`parroquia`)
) ENGINE=InnoDB AUTO_INCREMENT=18;

CREATE TABLE `encomiendas` (
  `id` varchar(7) NOT NULL,
  `tipo` varchar(15) NOT NULL DEFAULT '',
  `fh_salida` datetime DEFAULT NULL,
  `fh_llegada` datetime DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `nucleo_id` int(10) unsigned NOT NULL,
  `nucleo_rec_id` int(10) unsigned DEFAULT NULL,
  `transportista_id` varchar(9) DEFAULT NULL,
  `vehiculo_id` varchar(8) DEFAULT NULL,
  `cliente_env_id` varchar(9) NOT NULL,
  `cliente_rec_id` varchar(9) NOT NULL,
  `precio` decimal(14,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `cliente_envia` (`cliente_env_id`),
  KEY `cliente_recibe` (`cliente_rec_id`),
  KEY `fk_transportista_vehiculo` (`vehiculo_id`),
  KEY `fk_transportista_id` (`transportista_id`),
  KEY `fk_nucleo_id` (`nucleo_id`),
  KEY `fk_nucleo_rec_id` (`nucleo_rec_id`),
  CONSTRAINT `CHK_fechas_encomiendas` CHECK (`fh_llegada` is null or `fh_llegada` >= `fh_salida`),
  CONSTRAINT `CHK_clientes_encomiendas` CHECK (`cliente_env_id` <> `cliente_rec_id`),
  CONSTRAINT `CHK_estado_encomiendas` CHECK (`estado` in ('en espera','en progreso','culminada','en custodia','cancelada')),
  CONSTRAINT `CHK_nucleos_encomiendas` CHECK (!(`nucleo_id` <=> `nucleo_rec_id`)),
  CONSTRAINT `CHK_tipo_encomiendas` CHECK (`tipo` in ('normal','extendida')),
  CONSTRAINT `CHK_jerarquia_encomiendas` CHECK (`tipo` = 'normal' and `nucleo_rec_id` is null or `tipo` = 'extendida' and `nucleo_rec_id` is not null and `transportista_id` is null and `vehiculo_id` is null)
) ENGINE=InnoDB;

CREATE TABLE `historico_clientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` varchar(9) CHARACTER SET latin1 NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` decimal(14,3) NOT NULL,
  `saldo_final` decimal(14,3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cliente_historico` (`cliente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2;

CREATE TABLE `historico_transportistas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transportista_id` varchar(9) CHARACTER SET latin1 NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` decimal(14,3) NOT NULL,
  `saldo_final` decimal(14,3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transportistas_historico` (`transportista_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2;

CREATE TABLE `invitaciones` (
  `transportista_id` varchar(9) CHARACTER SET latin1 NOT NULL,
  `encomienda_id` varchar(7) CHARACTER SET latin1 NOT NULL,
  `estado` varchar(15) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`transportista_id`,`encomienda_id`),
  KEY `fk_invitaciones_encomienda_id` (`encomienda_id`)
) ENGINE=InnoDB;

CREATE TABLE `nucleos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `direccion_id` int(10) unsigned NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `com_vuelo` decimal(5,4) DEFAULT NULL,
  `com_vehiculo_motor` decimal(5,4) DEFAULT NULL,
  `com_bicicleta` decimal(5,4) DEFAULT NULL,
  `precio_por_kg` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_nucleo` (`direccion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6;

CREATE TABLE `paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9;

CREATE TABLE `paquetes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `peso` decimal(10,3) unsigned NOT NULL COMMENT 'gramos\r\n',
  `alto` decimal(6,2) unsigned NOT NULL COMMENT 'cm',
  `ancho` decimal(6,2) unsigned NOT NULL COMMENT 'cm',
  `largo` decimal(6,2) unsigned NOT NULL COMMENT 'cm',
  `fragil` tinyint(1) NOT NULL,
  `encomienda_id` varchar(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paquete_encomiendas` (`encomienda_id`),
  CONSTRAINT `CHK_fragilidad_paquetes` CHECK (`fragil` in (1,0))
) ENGINE=InnoDB AUTO_INCREMENT=46;

CREATE TABLE `recorridos` (
  `id` int(10) unsigned NOT NULL,
  `encomienda_id` varchar(7) CHARACTER SET latin1 NOT NULL,
  `nucleo_org_id` int(10) unsigned NOT NULL,
  `nucleo_des_id` int(10) unsigned NOT NULL,
  `estado` varchar(10) NOT NULL DEFAULT 'abierto',
  `transportista_id` varchar(9) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`,`encomienda_id`) USING BTREE,
  KEY `fk_recorridos_transportista_id` (`transportista_id`),
  KEY `fk_recorridos_nucleo_org_id` (`nucleo_org_id`),
  KEY `fk_recorridos_nucleo_des_id` (`nucleo_des_id`),
  KEY `fk_recorridos_encomienda_id` (`encomienda_id`),
  CONSTRAINT `CHK_estados_recorridos` CHECK (`estado` in ('abierto','cerrado','culminado'))
) ENGINE=InnoDB;

CREATE TABLE `transportistas` (
  `id` varchar(9) NOT NULL,
  `nombre` varchar(16) NOT NULL,
  `apellido` varchar(16) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `alt_telefono` varchar(11) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `saldo` decimal(14,3) unsigned NOT NULL DEFAULT 0.000,
  `licencia` varchar(12) DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `disponibilidad` tinyint(1) NOT NULL,
  `curso_aprobado` tinyint(1) NOT NULL,
  `f_curso` date DEFAULT NULL,
  `antecedentes` tinyint(1) NOT NULL,
  `direccion_id` int(10) unsigned NOT NULL,
  `nucleo_id` int(255) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_transportador` (`direccion_id`),
  KEY `asociado_a` (`nucleo_id`),
  CONSTRAINT `CHK_disponibilidad_transportistas` CHECK (`disponibilidad` in (1,0)),
  CONSTRAINT `CHK_capacitacion_transportistas` CHECK (`curso_aprobado` = 0 and `disponibilidad` = 0 or `curso_aprobado` = 1 and `disponibilidad` in (1,0)),
  CONSTRAINT `CHK_antecedentes_transportistas` CHECK (`antecedentes` in (1,0))
) ENGINE=InnoDB;

CREATE TABLE `vehiculos` (
  `id` varchar(8) NOT NULL COMMENT 'placa',
  `transportista_id` varchar(9) NOT NULL,
  `modelo` varchar(20) NOT NULL,
  `marca` varchar(13) NOT NULL,
  `color` varchar(20) NOT NULL,
  `tipo` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transportista_vehiculo` (`transportista_id`),
  CONSTRAINT `CHK_tipo_vehiculos` CHECK (`tipo` in ('motor','bicicleta'))
) ENGINE=InnoDB;

CREATE TABLE `vuelos` (
  `id` varchar(8) NOT NULL,
  `tiempo_retraso` time DEFAULT NULL,
  `descripcion_retraso` varchar(100) DEFAULT NULL,
  `tiempo_estimado` time NOT NULL,
  `fh_salida` datetime NOT NULL,
  `fh_llegada` datetime DEFAULT NULL,
  `aerolinea` varchar(30) NOT NULL,
  `encomienda_id` varchar(7) NOT NULL,
  `recorrido_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recorridos_encomienda_id_recorrido_id` (`encomienda_id`,`recorrido_id`),
    CONSTRAINT `CHK_fechas_vuelos` CHECK (`fh_llegada` is null or `fh_llegada` >= `fh_salida`)
) ENGINE=InnoDB;

