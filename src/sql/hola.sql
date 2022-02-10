CREATE TABLE `encomiendas` (
  `id` varchar(7) NOT NULL,
  `fh_salida` datetime DEFAULT NULL,
  `fh_llegada` datetime DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `nucleo_id` int(10) unsigned NOT NULL,
  `transportista_id` varchar(9) NOT NULL,
  `vehiculo_id` varchar(8) DEFAULT NULL,
  `tipo` varchar(15) NOT NULL DEFAULT '',
  `cliente_env_id` varchar(9) NOT NULL,
  `cliente_rec_id` varchar(9) NOT NULL,
  `precio` decimal(14,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `cliente_envia` (`cliente_env_id`),
  KEY `cliente_recibe` (`cliente_rec_id`),
  KEY `tranportista_local` (`transportista_id`),
  KEY `nucleo_local` (`nucleo_id`),
  KEY `fk_transportista_vehiculo` (`vehiculo_id`),
  CONSTRAINT `cliente_envia` FOREIGN KEY (`cliente_env_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `cliente_recibe` FOREIGN KEY (`cliente_rec_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_transportista_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `nucleo_local` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `tranportista_local` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `CHK_tipo_encomiendas` CHECK (`tipo` in ('normal','vuelo')),
  CONSTRAINT `CHK_fechas_encomiendas` CHECK (`fh_llegada` is null or `fh_llegada` >= `fh_salida`),
  CONSTRAINT `CHK_clientes_encomiendas` CHECK (`cliente_env_id` <> `cliente_rec_id`),
  CONSTRAINT `CHK_estado_encomiendas` CHECK (`estado` in ('en espera','en progreso','culminada','en custodia','cancelada'))
) ENGINE=InnoDB DEFAULT CHARSET=latin1