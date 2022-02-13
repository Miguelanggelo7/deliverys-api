/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ bd2_202215_grupo2 /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE bd2_202215_grupo2;

DROP TABLE IF EXISTS articulos;
CREATE TABLE `articulos` (
  `paquete_id` int(10) unsigned NOT NULL,
  `descripcion` varchar(50) NOT NULL DEFAULT '',
  `cantidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`descripcion`,`paquete_id`),
  KEY `paquete_contiene` (`paquete_id`),
  CONSTRAINT `paquete_contiene` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS clientes;
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
  CONSTRAINT `direccion_cliente` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `CHK_telefono_clientes` CHECK (`telefono` regexp '^[0-9].*')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS direcciones;
CREATE TABLE `direcciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `ciudad` varchar(20) NOT NULL,
  `parroquia` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `direccion_unica` (`id_pais`,`estado`,`ciudad`,`parroquia`),
  CONSTRAINT `fk_direcciones_paises` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS encomiendas;
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
  CONSTRAINT `cliente_envia` FOREIGN KEY (`cliente_env_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `cliente_recibe` FOREIGN KEY (`cliente_rec_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_nucleo_id` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_nucleo_rec_id` FOREIGN KEY (`nucleo_rec_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_transportista_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_transportista_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `CHK_fechas_encomiendas` CHECK (`fh_llegada` is null or `fh_llegada` >= `fh_salida`),
  CONSTRAINT `CHK_clientes_encomiendas` CHECK (`cliente_env_id` <> `cliente_rec_id`),
  CONSTRAINT `CHK_estado_encomiendas` CHECK (`estado` in ('en espera','en progreso','culminada','en custodia','cancelada')),
  CONSTRAINT `CHK_nucleos_encomiendas` CHECK (!(`nucleo_id` <=> `nucleo_rec_id`)),
  CONSTRAINT `CHK_tipo_encomiendas` CHECK (`tipo` in ('normal','extendida')),
  CONSTRAINT `CHK_jerarquia_encomiendas` CHECK (`tipo` = 'normal' and `nucleo_rec_id` is null or `tipo` = 'extendida' and `nucleo_rec_id` is not null and `transportista_id` is null and `vehiculo_id` is null)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS historico_clientes;
CREATE TABLE `historico_clientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` varchar(9) CHARACTER SET latin1 NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` decimal(14,3) NOT NULL,
  `saldo_final` decimal(14,3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cliente_historico` (`cliente_id`),
  CONSTRAINT `fk_cliente_historico` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS historico_transportistas;
CREATE TABLE `historico_transportistas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transportista_id` varchar(9) CHARACTER SET latin1 NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` decimal(14,3) NOT NULL,
  `saldo_final` decimal(14,3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transportistas_historico` (`transportista_id`),
  CONSTRAINT `fk_transportistas_historico` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS invitaciones;
CREATE TABLE `invitaciones` (
  `transportista_id` varchar(9) CHARACTER SET latin1 NOT NULL,
  `encomienda_id` varchar(7) CHARACTER SET latin1 NOT NULL,
  `estado` varchar(15) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`transportista_id`,`encomienda_id`),
  KEY `fk_invitaciones_encomienda_id` (`encomienda_id`),
  CONSTRAINT `fk_invitaciones_encomienda_id` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_invitaciones_transportistas_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS nucleos;
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
  KEY `direccion_nucleo` (`direccion_id`),
  CONSTRAINT `direccion_nucleo` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS paises;
CREATE TABLE `paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS paquetes;
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
  CONSTRAINT `fk_paquete_encomiendas` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `CHK_fragilidad_paquetes` CHECK (`fragil` in (1,0))
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS recorridos;
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
  CONSTRAINT `fk_recorridos_nucleo_des_id` FOREIGN KEY (`nucleo_des_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_recorridos_nucleo_org_id` FOREIGN KEY (`nucleo_org_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_recorridos_transportista_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `CHK_estados_recoridos` CHECK (`estado` in ('abierto','cerrado','culminado'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS transportistas;
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
  CONSTRAINT `asociado_a` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `direccion_transportador` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `CHK_disponibilidad_transportistas` CHECK (`disponibilidad` in (1,0)),
  CONSTRAINT `CHK_capacitacion_transportistas` CHECK (`curso_aprobado` = 0 and `disponibilidad` = 0 or `curso_aprobado` = 1 and `disponibilidad` in (1,0)),
  CONSTRAINT `CHK_antecedentes_transportistas` CHECK (`antecedentes` in (1,0))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS vehiculos;
CREATE TABLE `vehiculos` (
  `id` varchar(8) NOT NULL COMMENT 'placa',
  `transportista_id` varchar(9) NOT NULL,
  `modelo` varchar(20) NOT NULL,
  `marca` varchar(13) NOT NULL,
  `color` varchar(20) NOT NULL,
  `tipo` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transportista_vehiculo` (`transportista_id`),
  CONSTRAINT `transportista_vehiculo` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `CHK_tipo_vehiculos` CHECK (`tipo` in ('motor','bicicleta'))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS vuelos;
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
  CONSTRAINT `fk_recorridos_encomienda_id_recorrido_id` FOREIGN KEY (`encomienda_id`, `recorrido_id`) REFERENCES `recorridos` (`encomienda_id`, `id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `CHK_fechas_vuelos` CHECK (`fh_llegada` is null or `fh_llegada` >= `fh_salida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;DROP PROCEDURE IF EXISTS sp_aceptar_invitacion;
CREATE PROCEDURE `sp_aceptar_invitacion`(
	_encomienda_id VARCHAR(7),
	_transportista_id VARCHAR(9),
	_vehiculo_id VARCHAR(8)
)
BEGIN
	
	IF !EXISTS(SELECT *
			FROM invitaciones
			WHERE transportista_id = _transportista_id
			AND encomienda_id = _encomienda_id) THEN
			
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_invitacion) Error: la invitacion no existe';
	END IF;
	
	UPDATE encomiendas
	SET transportista_id = _transportista_id,
		vehiculo_id = _vehiculo_id
	WHERE id = _encomienda_id;
	
	UPDATE invitaciones
	SET estado = 'aceptada'
	WHERE transportista_id = _transportista_id
	AND encomienda_id = _encomienda_id;
	
END;

DROP PROCEDURE IF EXISTS sp_agregar_vehiculo;
undefined;

DROP PROCEDURE IF EXISTS sp_cambiar_disponibilidad;
undefined;

DROP PROCEDURE IF EXISTS sp_cobrar_encomienda_cliente;
CREATE PROCEDURE `sp_cobrar_encomienda_cliente`(
	encomienda VARCHAR(7)
)
BEGIN

	UPDATE clientes c
	SET c.saldo = c.saldo - sf_calcular_costo_encomienda(encomienda)
	WHERE id = (SELECT cliente_env_id
					FROM encomiendas
					WHERE id = encomienda);
END;

DROP PROCEDURE IF EXISTS sp_enviar_invitacion;
CREATE PROCEDURE `sp_enviar_invitacion`(
	_encomienda_id VARCHAR(7)
)
BEGIN

	DECLARE random INT;
	DECLARE total INT;
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE i INTEGER DEFAULT 0;
	DECLARE _transportista_id VARCHAR(9);
	
	-- declarar cursor de transportistas que no han recibido invitacion
	-- y tienen disponiblidad
	DEClARE curTransportista CURSOR FOR 
			SELECT t.id
			FROM transportistas t
			LEFT JOIN invitaciones i ON	i.transportista_id = t.id
				AND i.encomienda_id = _encomienda_id
			WHERE i.encomienda_id IS NULL
			AND t.nucleo_id = (SELECT nucleo_id 
								FROM encomiendas
								WHERE id = _encomienda_id)
			AND t.disponibilidad;
				
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
	
	-- contar transportistas que no han recibido invitacion
	-- y tienen disponiblidad	
	SELECT COUNT(t.id)
		INTO total
		FROM transportistas t
		LEFT JOIN invitaciones i ON	i.transportista_id = t.id
			AND i.encomienda_id = _encomienda_id
		WHERE i.encomienda_id IS NULL
		AND t.nucleo_id = (SELECT nucleo_id 
							FROM encomiendas
							WHERE id = _encomienda_id)
		AND t.disponibilidad;
	
	IF total = 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_enviar_invitacion) Error: no hay transportistas disponibles';
	END IF;
	
	-- generate a random number
	SET random = FLOOR(RAND() * total);
	
	-- Open cursor
	OPEN curTransportista;
	
	WHILE i <= random DO
		FETCH curTransportista INTO _transportista_id;
		SET i = i + 1;
	END WHILE;
	
	-- close cursor
	CLOSE curTransportista;
	
	INSERT INTO invitaciones(transportista_id, encomienda_id) VALUES(_transportista_id, _encomienda_id);
	
END;

DROP PROCEDURE IF EXISTS sp_pagar_encomienda_extendida_transportistas;
CREATE PROCEDURE `sp_pagar_encomienda_extendida_transportistas`(
	_encomienda_id VARCHAR(7)
)
BEGIN
	DECLARE _transportista_id VARCHAR(9);

	DECLARE finished INTEGER DEFAULT 0;
	DECLARE comision FLOAT(255,2);


	DECLARE curTransportista CURSOR FOR 
			SELECT transportista_id
			FROM recorridos
			WHERE encomienda_id = _encomienda_id;

	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curTransportista;
	
	WHILE !finished DO
		FETCH curTransportista INTO _transportista_id;

		SELECT n.com_vuelo
		INTO comision
		FROM transportistas t
		INNER JOIN nucleos n ON n.id = t.nucleo_id
		WHERE t.id = _transportista_id;

		UPDATE transportistas t
		SET t.saldo = t.saldo + sf_calcular_costo_encomienda(_encomienda_id) 
			* comision
		WHERE id = _transportista_id;
	END WHILE;

	CLOSE curTransportista;

END;

DROP PROCEDURE IF EXISTS sp_pagar_encomienda_transportista;
CREATE PROCEDURE `sp_pagar_encomienda_transportista`(
	encomienda VARCHAR(7)
)
BEGIN
	
	DECLARE tipo_vehiculo VARCHAR(15);
	DECLARE comision FLOAT(255,2);
	
	SELECT v.tipo
	INTO tipo_vehiculo
	FROM encomiendas e
	INNER JOIN vehiculos v ON v.id = e.vehiculo_id
	WHERE e.id = encomienda;
	
	CASE tipo_vehiculo
		WHEN 'motor' THEN
			SELECT n.com_vehiculo_motor
			INTO comision
			FROM encomiendas e
			INNER JOIN nucleos n ON n.id = e.nucleo_id
			WHERE e.id = encomienda;
			
		WHEN 'bicicleta' THEN
			SELECT n.com_bicicleta
			INTO comision
			FROM encomiendas e
			INNER JOIN nucleos n ON n.id = e.nucleo_id
			WHERE e.id = encomienda;
			
	END CASE;


	UPDATE transportistas t
	SET t.saldo = t.saldo + sf_calcular_costo_encomienda(encomienda) 
		* comision
	WHERE id = (SELECT transportista_id
					FROM encomiendas
					WHERE id = encomienda);
END;

DROP PROCEDURE IF EXISTS sp_recargar_saldo_cliente;
undefined;

DROP PROCEDURE IF EXISTS sp_rechazar_invitacion;
CREATE PROCEDURE `sp_rechazar_invitacion`(
	_encomienda_id VARCHAR(7),
	_transportista_id VARCHAR(9)
)
BEGIN
	
	IF !EXISTS(SELECT *
			FROM invitaciones
			WHERE transportista_id = _transportista_id
			AND encomienda_id = _encomienda_id) THEN
			
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_rechazar_invitacion) Error: la invitacion no existe';
	END IF;
	
	UPDATE invitaciones
	SET estado = 'rechazada'
	WHERE transportista_id = _transportista_id
	AND encomienda_id = _encomienda_id;
	
	CALL sp_enviar_invitacion(_encomienda_id);
	
END;

DROP PROCEDURE IF EXISTS sp_solicitar_encomienda;
CREATE PROCEDURE `sp_solicitar_encomienda`(
	encomienda VARCHAR(7)
)
BEGIN
	
	IF !((SELECT estado
			FROM encomiendas
			WHERE id = encomienda) <=> NULL) THEN
			
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_solicitar_encomienda) Error: la encomienda ya ha sido solicitada';
	
	END IF;
	
	UPDATE encomiendas
	SET estado = 'en espera'
	WHERE id = encomienda;
	
	CALL sp_enviar_invitacion(encomienda);
END;

DROP PROCEDURE IF EXISTS sp_terminar_recorrido;
CREATE PROCEDURE `sp_terminar_recorrido`(
    _encomienda_id VARCHAR(7),
    _recorrido_id INT(10)
)
BEGIN
    DECLARE _transportista_id VARCHAR(9);
    DECLARE is_same_destiny int;
    DECLARE newOrigin int(10);
    DECLARE newDestiny int(10);

    IF (
        SELECT estado = 'abierto' OR estado = 'culminado'
        FROM recorridos
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id
    )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_terminar_recorrido) Error: el recorrido no se pude terminar';
    END IF;

    UPDATE recorridos
        SET estado = 'culminado'
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id;

    SELECT e.nucleo_rec_id = r.nucleo_des_id
        INTO is_same_destiny
        FROM encomiendas e
        INNER JOIN recorridos r ON r.encomienda_id = e.id
            AND r.id = _recorrido_id
        WHERE e.id = _encomienda_id;
    IF is_same_destiny THEN

        SELECT transportista_id
            INTO _transportista_id
            FROM recorridos
            WHERE encomienda_id = _encomienda_id
            AND id = (
                SELECT MAX(id) 
                FROM recorridos
                WHERE encomienda_id = _encomienda_id
            );

        CALL sp_update_estado(_encomienda_id, _transportista_id, NULL);

    ELSE
        SELECT nucleo_des_id
        INTO newOrigin
        FROM recorridos
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id;

        SELECT nucleo_rec_id
        INTO newDestiny
        FROM encomiendas
        WHERE id = _encomienda_id;

        INSERT INTO recorridos (id, encomienda_id, nucleo_org_id, nucleo_des_id)
            VALUES (_recorrido_id + 1, _encomienda_id, newOrigin, newDestiny);
    END IF;
END;

DROP PROCEDURE IF EXISTS sp_update_estado;
CREATE PROCEDURE `sp_update_estado`(
	encomienda VARCHAR(7),
	transportista VARCHAR(9),
	newEstado VARCHAR(15)
)
BEGIN

	DECLARE oldEstado VARCHAR(15);

	DECLARE _tipo VARCHAR(15);

	SELECT tipo
	INTO _tipo
	FROM encomiendas
	WHERE id = encomienda;
	
	IF transportista <=> NULL
		OR encomienda <=> NULL
		OR (
			_tipo = 'normal'
			AND transportista <> (
				SELECT transportista_id
				FROM encomiendas
				WHERE id = encomienda
			)
		)
		OR (
			_tipo = 'extendida'
			AND transportista NOT IN (
				SELECT transportista_id
				FROM recorridos
				WHERE encomienda_id = encomienda
				AND id = (
					SELECT MAX(id) 
					FROM recorridos
					WHERE encomienda_id = encomienda
            	)
			)
		)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_update_estado) Error: el transportista o encomienda ingresada no es valida';
	
	END IF;

	
	IF (newEstado <=> NULL) THEN
	
		SELECT estado
		INTO oldEstado
		FROM encomiendas
		WHERE id = encomienda;

		IF oldEstado <=> NULL THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = '(sp_update_estado) Error: la encomienda no ha sido iniciada, su estado no se puede actualizar';
		END IF;

		CASE oldEstado
		
			WHEN 'en espera' THEN

				SET newEstado = 'en progreso';

				UPDATE encomiendas
					SET fh_salida = NOW()
					WHERE id = encomienda;

				CALL sp_cobrar_encomienda_cliente(encomienda);
				
			WHEN 'en custodia'  THEN
			
				SET newEstado = 'en progreso';
				
			WHEN 'en progreso'  THEN
			
				SET newEstado = 'culminada';

				UPDATE encomiendas
					SET fh_llegada = NOW()
					WHERE id = encomienda;


				IF (
					SELECT tipo
					FROM encomiendas
					WHERE id = encomienda
				) = 'normal'
				THEN
					CALL sp_pagar_encomienda_transportista(encomienda);
				ELSE
					CALL sp_pagar_encomienda_extendida_transportistas(encomienda);
				END IF;
				
			ELSE 
				SET newEstado = oldEstado;
				
		END CASE;
	
	ELSEIF !(newEstado <=> 'en custodia')
		AND !(newEstado <=> 'cancelada') THEN
		
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_update_estado) Error: el estado ingresado no es valido';
		
	END IF;
	
	UPDATE encomiendas
	SET estado = newEstado
	WHERE id = encomienda;
	
END;

DROP PROCEDURE IF EXISTS sp_validar_ingreso_transportista;
undefined;

DROP Function IF EXISTS sf_calcular_costo_paquete;
undefined;

DROP Function IF EXISTS sf_encomiendas_totales_transportista;
undefined;

DROP TRIGGER IF EXISTS tg_historico_cliente;
CREATE TRIGGER tg_historico_cliente
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
	IF NEW.saldo <> OLD.saldo THEN
		INSERT INTO historico_clientes (cliente_id, fecha, valor, saldo_final)
		VALUES (NEW.id, NOW(), NEW.saldo - OLD.saldo, NEW.saldo);
	END IF;
END;

DROP TRIGGER IF EXISTS tg_before_encomiendas_insert_estado;
CREATE TRIGGER tg_before_encomiendas_insert_estado
    BEFORE INSERT
    ON encomiendas FOR EACH ROW
BEGIN
    IF NEW.tipo = 'extendida' THEN
        SET NEW.estado = 'en espera';
                
    END IF;
END;

DROP TRIGGER IF EXISTS tg_after_encomiendas_insert_publicar_recorrido;
CREATE TRIGGER tg_after_encomiendas_insert_publicar_recorrido
    AFTER INSERT
    ON encomiendas FOR EACH ROW
BEGIN
    IF NEW.tipo = 'extendida' THEN
        INSERT INTO recorridos (id, encomienda_id, nucleo_org_id, nucleo_des_id)
            VALUES (0, NEW.id, NEW.nucleo_id, NEW.nucleo_rec_id);
                
    END IF;
END;

DROP TRIGGER IF EXISTS tg_CHK_vehiculo_id;
CREATE TRIGGER tg_CHK_vehiculo_id
	BEFORE UPDATE
	ON encomiendas FOR EACH ROW
BEGIN
	IF !(OLD.vehiculo_id <=> NEW.vehiculo_id)
		AND !(NEW.vehiculo_id <=> NULL)
		AND !((SELECT transportista_id
				FROM vehiculos
				WHERE id = NEW.vehiculo_id) <=> OLD.transportista_id)
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: el transportista es NULL o el vehiculo no pertenece al transportista';
    END IF;
END;

DROP TRIGGER IF EXISTS tg_chk_recorrido_transportista;
CREATE TRIGGER tg_chk_recorrido_transportista
	BEFORE UPDATE
	ON recorridos FOR EACH ROW
BEGIN
	IF !(OLD.transportista_id <=> NEW.transportista_id)
		AND (
			SELECT nucleo_id
			FROM transportistas
			WHERE id = NEW.transportista_id
		) <> NEW.nucleo_org_id
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(tg_chk_recorrido_transportista) Error: el transportista 
			no pertenece al nucleo de origen del recorrido';
    END IF;
END;

DROP TRIGGER IF EXISTS validar_fecha_transportista_insert;
CREATE TRIGGER validar_fecha_transportista_insert
BEFORE INSERT ON transportistas
FOR EACH ROW
BEGIN
  CALL sp_validar_ingreso_transportista(NEW.fecha_ingreso);
END;

DROP TRIGGER IF EXISTS validar_fecha_transportista_update;
CREATE TRIGGER validar_fecha_transportista_update
BEFORE UPDATE ON transportistas
FOR EACH ROW
BEGIN
  CALL sp_validar_ingreso_transportista(NEW.fecha_ingreso);
END;

DROP TRIGGER IF EXISTS tg_historico_transportista;
CREATE TRIGGER tg_historico_transportista
AFTER UPDATE ON transportistas
FOR EACH ROW
BEGIN
	IF NEW.saldo <> OLD.saldo THEN
		INSERT INTO historico_transportistas (transportista_id, fecha, valor, saldo_final)
		VALUES (NEW.id, NOW(), NEW.saldo - OLD.saldo, NEW.saldo);
	END IF;
END;