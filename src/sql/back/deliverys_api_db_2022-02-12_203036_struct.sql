/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ deliverys_api_db /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE deliverys_api_db;

DROP TABLE IF EXISTS articulos;
CREATE TABLE `articulos` (
  `paquete_id` int(10) unsigned NOT NULL,
  `descripcion` varchar(50) NOT NULL DEFAULT '',
  `cantidad` int(10) unsigned NOT NULL,
  PRIMARY KEY (`descripcion`,`paquete_id`),
  KEY `paquete_contiene` (`paquete_id`),
  CONSTRAINT `paquete_contiene` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS clientes;
CREATE TABLE `clientes` (
  `id` varchar(9) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `saldo` decimal(14,3) unsigned NOT NULL DEFAULT '0.000',
  `nombre` varchar(16) NOT NULL,
  `apellido` varchar(16) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `alt_telefono` varchar(11) DEFAULT NULL,
  `direccion_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email_clientes` (`email`),
  KEY `direccion_cliente` (`direccion_id`),
  CONSTRAINT `direccion_cliente` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE
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
  `precio` decimal(14,2) NOT NULL DEFAULT '0.00',
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
  CONSTRAINT `fk_transportista_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS historico_clientes;
CREATE TABLE `historico_clientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` varchar(9) NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` decimal(14,3) NOT NULL,
  `saldo_final` decimal(14,3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cliente_historico` (`cliente_id`),
  CONSTRAINT `fk_cliente_historico` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS historico_transportistas;
CREATE TABLE `historico_transportistas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transportista_id` varchar(9) NOT NULL,
  `fecha` datetime NOT NULL,
  `valor` decimal(14,3) NOT NULL,
  `saldo_final` decimal(14,3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transportistas_historico` (`transportista_id`),
  CONSTRAINT `fk_transportistas_historico` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS invitaciones;
CREATE TABLE `invitaciones` (
  `transportista_id` varchar(9) NOT NULL,
  `encomienda_id` varchar(7) NOT NULL,
  `estado` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`transportista_id`,`encomienda_id`),
  KEY `fk_invitaciones_encomienda_id` (`encomienda_id`),
  CONSTRAINT `fk_invitaciones_encomienda_id` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_invitaciones_transportistas_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS nucleos;
CREATE TABLE `nucleos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `direccion_id` int(10) unsigned NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `com_vuelo` decimal(5,4) NOT NULL,
  `com_vehiculo_motor` decimal(5,4) NOT NULL,
  `com_bicicleta` decimal(5,4) NOT NULL,
  `precio_por_kg` decimal(10,3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `direccion_nucleo` (`direccion_id`),
  CONSTRAINT `direccion_nucleo` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS paises;
CREATE TABLE `paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

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
  CONSTRAINT `fk_paquete_encomiendas` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS recorridos;
CREATE TABLE `recorridos` (
  `id` int(10) unsigned NOT NULL,
  `encomienda_id` varchar(7) NOT NULL,
  `nucleo_org_id` int(10) unsigned NOT NULL,
  `nucleo_des_id` int(10) unsigned NOT NULL,
  `estado` varchar(10) NOT NULL DEFAULT 'abierto',
  `transportista_id` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`id`,`encomienda_id`) USING BTREE,
  KEY `fk_recorridos_transportista_id` (`transportista_id`),
  KEY `fk_recorridos_nucleo_org_id` (`nucleo_org_id`),
  KEY `fk_recorridos_nucleo_des_id` (`nucleo_des_id`),
  KEY `fk_recorridos_encomienda_id` (`encomienda_id`),
  CONSTRAINT `fk_recorridos_encomienda_id` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_recorridos_nucleo_des_id` FOREIGN KEY (`nucleo_des_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_recorridos_nucleo_org_id` FOREIGN KEY (`nucleo_org_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_recorridos_transportista_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS transportistas;
CREATE TABLE `transportistas` (
  `id` varchar(9) NOT NULL,
  `nombre` varchar(16) NOT NULL,
  `apellido` varchar(16) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `alt_telefono` varchar(11) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `saldo` decimal(14,3) unsigned NOT NULL DEFAULT '0.000',
  `licencia` varchar(12) DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `disponibilidad` tinyint(1) NOT NULL DEFAULT '0',
  `curso_aprobado` tinyint(1) NOT NULL DEFAULT '0',
  `f_curso` date DEFAULT NULL,
  `antecedentes` tinyint(1) NOT NULL,
  `direccion_id` int(10) unsigned NOT NULL,
  `nucleo_id` int(255) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email_transportistas` (`email`) USING BTREE,
  KEY `direccion_transportador` (`direccion_id`),
  KEY `asociado_a` (`nucleo_id`),
  CONSTRAINT `asociado_a` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `direccion_transportador` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE
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
  CONSTRAINT `transportista_vehiculo` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE
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
  CONSTRAINT `fk_recorridos_encomienda_id_recorrido_id` FOREIGN KEY (`encomienda_id`, `recorrido_id`) REFERENCES `recorridos` (`encomienda_id`, `id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;DROP PROCEDURE IF EXISTS sp_aceptar_invitacion;
CREATE PROCEDURE `sp_aceptar_invitacion`(
	_encomienda_id VARCHAR(7),
	_transportista_id VARCHAR(9),
	_vehiculo_id VARCHAR(8)
)
BEGIN

	IF _vehiculo_id <=> NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_invitacion) Error: vehiculo no puede ser NULL';
	END IF;
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

DROP PROCEDURE IF EXISTS sp_aceptar_recorrido;
CREATE PROCEDURE `sp_aceptar_recorrido`(_encomienda_id VARCHAR(7),
    _recorrido_id INT(10),
    _transportista_id VARCHAR(9),
    _nucleo_des_id INT(10))
BEGIN

    IF (
        SELECT estado <> 'abierto'
        FROM recorridos
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id
    )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_recorrido) Error: el recorrido no esta disponible';
    END IF;
    UPDATE recorridos
        SET transportista_id = _transportista_id,
            nucleo_des_id = _nucleo_des_id,
            estado = 'cerrado'
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id;
    IF (
        SELECT estado
        FROM encomiendas
        WHERE id = _encomienda_id
    ) = 'en espera'
    THEN
        CALL sp_update_estado(_encomienda_id, _transportista_id, NULL);
    END IF;
END;

DROP PROCEDURE IF EXISTS sp_agregar_vehiculo;
CREATE PROCEDURE `sp_agregar_vehiculo`(
  IN id VARCHAR(8),
  IN transportista_id VARCHAR(9),
  IN modelo VARCHAR(20),
  IN marca VARCHAR(13),
  IN color VARCHAR(20),
  IN tipo VARCHAR(15)
)
BEGIN
	IF tipo = "motor" THEN
		SET @licencia = (SELECT licencia FROM transportistas t WHERE t.id = transportista_id);
		IF ISNULL(@licencia) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El transportista no posee licencia registrada, por lo que no se podrá registrar un vehiculo a motor';
		END IF;
	END IF;
	INSERT INTO vehiculos VALUES(id, transportista_id, modelo, marca, color, tipo);
	SELECT * FROM vehiculos v WHERE v.id = id;
END;

DROP PROCEDURE IF EXISTS sp_cambiar_disponibilidad;
CREATE PROCEDURE `sp_cambiar_disponibilidad`(
  IN transportista_id VARCHAR(9),
  IN new_disp TINYINT(1)
)
BEGIN
		DECLARE licencia VARCHAR(12);
		SET @disp = (SELECT disponibilidad FROM transportistas WHERE id = transportista_id);
		IF ISNULL(@disp) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El transportista que ingresó no existe';
		END IF;
		IF @disp = new_disp THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usted ingresó la misma disponibilidad, por lo que no hubo cambios';
		END IF;
    IF new_disp = FALSE THEN
			UPDATE transportistas SET disponibilidad = FALSE WHERE id = transportista_id;
    ELSE

			SET licencia = (SELECT t.licencia FROM transportistas t WHERE t.id = transportista_id);
			IF (ISNULL(licencia)) THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transportista no posee licencia registrada';
			END IF;
			IF (SELECT COUNT(*) FROM vehiculos v WHERE v.transportista_id = transportista_id) = 0 THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transportista no posee vehiculos asociados';
			END IF;
			IF (SELECT NOT t.curso_aprobado FROM transportistas t WHERE t.id = transportista_id) THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transportista debe haber completado el curso';
			END IF;
			UPDATE transportistas SET disponibilidad = true WHERE id = transportista_id;
    END IF;
END;

DROP PROCEDURE IF EXISTS sp_cobrar_encomienda_cliente;
CREATE PROCEDURE `sp_cobrar_encomienda_cliente`(encomienda VARCHAR(7))
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
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
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
	SET random = FLOOR(RAND() * total);
	OPEN curTransportista;
	WHILE i <= random DO
		FETCH curTransportista INTO _transportista_id;
		SET i = i + 1;
	END WHILE;
	CLOSE curTransportista;
	INSERT INTO invitaciones(transportista_id, encomienda_id) VALUES(_transportista_id, _encomienda_id);
END;

DROP PROCEDURE IF EXISTS sp_pagar_encomienda_extendida_transportistas;
CREATE PROCEDURE `sp_pagar_encomienda_extendida_transportistas`(_encomienda_id VARCHAR(7))
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
CREATE PROCEDURE `sp_recargar_saldo_cliente`(
	IN id_cliente VARCHAR(9), IN monto_recarga DECIMAL(14,3)
)
BEGIN
	
	UPDATE clientes
        SET saldo = saldo + monto_recarga
        WHERE id_cliente = id;
END;

DROP PROCEDURE IF EXISTS sp_rechazar_invitacion;
CREATE PROCEDURE `sp_rechazar_invitacion`(_encomienda_id VARCHAR(7),
	_transportista_id VARCHAR(9))
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

DROP PROCEDURE IF EXISTS sp_retirar_saldo_transportista;
CREATE PROCEDURE `sp_retirar_saldo_transportista`(
	IN id_transportista VARCHAR(9), IN monto_retiro DECIMAL(14,3)
)
BEGIN
	
	UPDATE transportistas
        SET saldo = saldo - monto_retiro
        WHERE id_transportista = id;
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
CREATE PROCEDURE `sp_terminar_recorrido`(_encomienda_id VARCHAR(7),
    _recorrido_id INT(10))
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
CREATE PROCEDURE `sp_validar_ingreso_transportista`(
  f_ingreso DATE
)
BEGIN
	IF f_ingreso > CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fecha de ingreso inválida';
	END IF;
END;

DROP Function IF EXISTS sf_calcular_costo_encomienda;
CREATE FUNCTION `sf_calcular_costo_encomienda`(_id VARCHAR(7)) RETURNS float(255,2)
BEGIN

    DECLARE total FLOAT (255,2);
	SELECT SUM(sf_calcular_costo_paquete(p.id))
	INTO total
	FROM encomiendas e
	LEFT JOIN paquetes p ON p.encomienda_id = e.id
	WHERE e.id = _id;
	RETURN total;
END;

DROP Function IF EXISTS sf_calcular_costo_paquete;
CREATE FUNCTION `sf_calcular_costo_paquete`(
    id_paquete INT(10)
) RETURNS decimal(14,3)
BEGIN

    RETURN (
	SELECT (p.alto*p.ancho*p.largo)/5000 * n.precio_por_kg
	FROM paquetes p, nucleos n, encomiendas e
	WHERE id_paquete = p.id AND p.encomienda_id = e.id AND e.nucleo_id = n.id
    );
END;

DROP Function IF EXISTS sf_consultar_saldo_cliente;
CREATE FUNCTION `sf_consultar_saldo_cliente`(
    id_cliente VARCHAR(9)
) RETURNS decimal(14,3)
BEGIN

    RETURN( 
        SELECT saldo
        FROM clientes
        WHERE id_cliente = id
    );
END;

DROP Function IF EXISTS sf_encomiendas_totales_transportista;
CREATE FUNCTION `sf_encomiendas_totales_transportista`(
  transportista_id VARCHAR(9)
) RETURNS int(11)
BEGIN
    RETURN ( 
        SELECT COUNT(*)
        FROM recorridos r
        WHERE r.transportista_id = transportista_id
    );
END;

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

DROP TRIGGER IF EXISTS tg_before_encomiendas_insert_id;
CREATE TRIGGER tg_before_encomiendas_insert_id
    BEFORE INSERT
    ON encomiendas FOR EACH ROW
BEGIN
    DECLARE _id VARCHAR(7);
    SELECT MAX(id)
    INTO _id
    FROM encomiendas;
    SET _id = HEX(CONV(_id, 16, 10) + 1);
    WHILE LENGTH(_id) < 7 DO
        SET _id = CONCAT('0', _id);
    END WHILE;
    SET NEW.id = _id;
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