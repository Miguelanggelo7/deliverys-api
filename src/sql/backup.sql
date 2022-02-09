/*
 Navicat Premium Data Transfer

 Source Server         : proyecto SBD2
 Source Server Type    : MariaDB
 Source Server Version : 100507
 Source Host           : labs-dbservices01.ucab.edu.ve:3306
 Source Schema         : bd2_202215_grupo2

 Target Server Type    : MariaDB
 Target Server Version : 100507
 File Encoding         : 65001

 Date: 09/02/2022 16:14:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for articulos
-- ----------------------------
DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articulos
-- ----------------------------
INSERT INTO `articulos` VALUES (1, 'Anillo');
INSERT INTO `articulos` VALUES (2, 'Camisa');
INSERT INTO `articulos` VALUES (3, 'Pasta de dientes');
INSERT INTO `articulos` VALUES (4, 'Toalla Sanitaria');
INSERT INTO `articulos` VALUES (5, 'Play Station 5');
INSERT INTO `articulos` VALUES (6, 'Play Station 4');
INSERT INTO `articulos` VALUES (7, 'Cámara');
INSERT INTO `articulos` VALUES (8, 'Laptop');
INSERT INTO `articulos` VALUES (9, 'CPU');

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `peso_min` decimal(10, 3) UNSIGNED NOT NULL,
  `precio` decimal(10, 2) UNSIGNED NOT NULL,
  `dimension_min` decimal(10, 2) UNSIGNED NOT NULL,
  `fragilidad` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categorias
-- ----------------------------
INSERT INTO `categorias` VALUES (1, 8000.000, 20.00, 60000.00, 0);
INSERT INTO `categorias` VALUES (2, 14000.000, 20.00, 90000.00, 0);
INSERT INTO `categorias` VALUES (3, 4000.000, 15.00, 5000.00, 1);

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes`  (
  `id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `saldo` decimal(14, 3) UNSIGNED NOT NULL,
  `nombre` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellido` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `telefono` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alt_telefono` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `direccion_id` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `direccion_cliente`(`direccion_id`) USING BTREE,
  CONSTRAINT `direccion_cliente` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES ('27123447', 'dsumoza@gmail.com', 'sadaskjadhka', 0.000, 'David', 'Sumoza', '04265971258', NULL, 2);
INSERT INTO `clientes` VALUES ('27729212', 'josemsaad13@gmail.com', 'dadasd2112323ddasdas', 62.000, 'Jose', 'Saad', '04249215674', NULL, 2);
INSERT INTO `clientes` VALUES ('27765316', 'vanessxdl@gmail.com', 'dsdadasdasdasdasdas', 0.000, 'Vanessa', 'Lozano', '04249338629', NULL, 1);
INSERT INTO `clientes` VALUES ('28301458', 'johanadrex@gmail.com', 'uhasduhasdjbkasdkjbadsas', 0.000, 'Johana', 'Dominguez', '04249331254', '04148521426', 2);
INSERT INTO `clientes` VALUES ('28471236', 'charlyghass@gmail.com', '32u381naskjdmka', 0.000, 'Charly', 'Ghassibe', '04249123347', NULL, 2);
INSERT INTO `clientes` VALUES ('29045314', 'viclo@gmail.com', 'sadsadasasdsad', 0.000, 'Victoria', 'Lopez', '04126974123', NULL, 1);
INSERT INTO `clientes` VALUES ('30015336', 'diegoooalc@gmail.com', 'ddsadadaskldasklndas', 0.000, 'Diego', 'Alcala', '04162632721', '04249531526', 1);
INSERT INTO `clientes` VALUES ('30453753', 'miguelanggelo21@gmail.com', 'fdujhbqiudszsujnajdnawsdas', 10.000, 'Miguelanggelo', 'Sumoza', '04249125727', NULL, 1);
INSERT INTO `clientes` VALUES ('30482111', 'guss_tierre@gmail.com', 'dsasdasdasdadasd', 0.000, 'Gustavo', 'Gutierrez', '04129531428', NULL, 2);
INSERT INTO `clientes` VALUES ('C03004786', 'alexmurra@hotmail.com', 'kljsdadjsalmd2283dadad', 0.000, 'Alex', 'Murray', '17023789521', NULL, 5);

-- ----------------------------
-- Table structure for contiene
-- ----------------------------
DROP TABLE IF EXISTS `contiene`;
CREATE TABLE `contiene`  (
  `articulo_id` int(10) UNSIGNED NOT NULL,
  `paquete_id` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`articulo_id`, `paquete_id`) USING BTREE,
  INDEX `paquete_contiene`(`paquete_id`) USING BTREE,
  CONSTRAINT `articulo_contiene` FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `paquete_contiene` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contiene
-- ----------------------------

-- ----------------------------
-- Table structure for direcciones
-- ----------------------------
DROP TABLE IF EXISTS `direcciones`;
CREATE TABLE `direcciones`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NOT NULL,
  `estado` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ciudad` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `parroquia` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `direccion_unica`(`id_pais`, `estado`, `ciudad`, `parroquia`) USING BTREE,
  CONSTRAINT `fk_direcciones_paises` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of direcciones
-- ----------------------------
INSERT INTO `direcciones` VALUES (5, 1, 'Nevada', 'Las Vegas', 'Clark');
INSERT INTO `direcciones` VALUES (4, 2, 'Bolivar', 'El Callao', 'El Callao');
INSERT INTO `direcciones` VALUES (14, 2, 'Bolivar', 'Guayana', 'Cachamay');
INSERT INTO `direcciones` VALUES (6, 2, 'Bolivar', 'Guayana', 'Caroni');
INSERT INTO `direcciones` VALUES (1, 2, 'Bolivar', 'Guayana', 'Unare');
INSERT INTO `direcciones` VALUES (2, 2, 'Bolivar', 'Guayana', 'Vista al Sol');

-- ----------------------------
-- Table structure for encomiendas
-- ----------------------------
DROP TABLE IF EXISTS `encomiendas`;
CREATE TABLE `encomiendas`  (
  `id` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fh_salida` datetime NULL DEFAULT NULL,
  `fh_llegada` datetime NULL DEFAULT NULL,
  `estado` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nucleo_id` int(10) UNSIGNED NOT NULL,
  `transportista_id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tipo` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `cliente_env_id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cliente_rec_id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `precio` decimal(14, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cliente_envia`(`cliente_env_id`) USING BTREE,
  INDEX `cliente_recibe`(`cliente_rec_id`) USING BTREE,
  INDEX `tranportista_local`(`transportista_id`) USING BTREE,
  INDEX `nucleo_local`(`nucleo_id`) USING BTREE,
  CONSTRAINT `cliente_envia` FOREIGN KEY (`cliente_env_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `cliente_recibe` FOREIGN KEY (`cliente_rec_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `nucleo_local` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `tranportista_local` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of encomiendas
-- ----------------------------
INSERT INTO `encomiendas` VALUES ('123ABC', '2021-05-11 14:09:18', '2021-06-01 17:01:45', 'culminada', 1, '28123999', 'normal', '27123447', '27729212', 1.00);
INSERT INTO `encomiendas` VALUES ('232AIF', '2021-12-13 14:09:18', '2021-12-16 14:09:18', 'culminada', 4, 'J48573221', 'vuelo', '27729212', 'C03004786', 3.00);
INSERT INTO `encomiendas` VALUES ('294AOP', '2021-12-14 14:09:18', '2021-12-16 14:09:18', 'en progreso', 2, '29412369', 'normal', '29045314', '28471236', 4.00);
INSERT INTO `encomiendas` VALUES ('563AOS', '2021-12-11 14:09:18', '2021-12-11 18:09:18', 'culminada', 2, 'J48573221', 'normal', '27765316', '30453753', 1.00);
INSERT INTO `encomiendas` VALUES ('652HOS', '2021-11-01 14:39:40', '2021-11-16 17:00:47', 'en progreso', 4, '29412369', 'vuelo', '30453753', '30482111', 1.00);

-- ----------------------------
-- Table structure for invitaciones
-- ----------------------------
DROP TABLE IF EXISTS `invitaciones`;
CREATE TABLE `invitaciones`  (
  `transportista_id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `encomienda_id` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`transportista_id`, `encomienda_id`) USING BTREE,
  INDEX `encomienda_invitada`(`encomienda_id`) USING BTREE,
  CONSTRAINT `encomienda_invitada` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transportista_invitado` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of invitaciones
-- ----------------------------

-- ----------------------------
-- Table structure for nucleos
-- ----------------------------
DROP TABLE IF EXISTS `nucleos`;
CREATE TABLE `nucleos`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `telefono` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `com_vuelo` decimal(5, 4) NULL DEFAULT NULL,
  `com_vehiculo_motor` decimal(5, 4) NULL DEFAULT NULL,
  `com_bicicleta` decimal(5, 4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `direccion_nucleo`(`direccion_id`) USING BTREE,
  CONSTRAINT `direccion_nucleo` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nucleos
-- ----------------------------
INSERT INTO `nucleos` VALUES (1, 1, ' S&S Pto. Ordaz Unare', '02869231487', 0.3500, 0.2000, 0.1000);
INSERT INTO `nucleos` VALUES (2, 4, ' S&S El Callao Av. Guarapiche', '02869231288', 0.4000, 0.1500, 0.1000);
INSERT INTO `nucleos` VALUES (4, 5, 'DHL EXPRESS Las Vegas Sunset RD Suite', '18002255345', 0.3500, 0.2500, 0.1500);

-- ----------------------------
-- Table structure for paises
-- ----------------------------
DROP TABLE IF EXISTS `paises`;
CREATE TABLE `paises`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paises
-- ----------------------------
INSERT INTO `paises` VALUES (1, 'Estados Unidos');
INSERT INTO `paises` VALUES (2, 'Venezuela');
INSERT INTO `paises` VALUES (3, 'Brasil');
INSERT INTO `paises` VALUES (4, 'Argentina');

-- ----------------------------
-- Table structure for paquetes
-- ----------------------------
DROP TABLE IF EXISTS `paquetes`;
CREATE TABLE `paquetes`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `peso` decimal(10, 3) UNSIGNED NOT NULL COMMENT 'gramos\r\n',
  `alto` decimal(6, 2) UNSIGNED NOT NULL COMMENT 'cm',
  `ancho` decimal(6, 2) UNSIGNED NOT NULL COMMENT 'cm',
  `largo` decimal(6, 2) UNSIGNED NOT NULL COMMENT 'cm',
  `fragil` tinyint(1) NOT NULL,
  `encomienda_id` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `encomienda_paquete`(`encomienda_id`) USING BTREE,
  CONSTRAINT `encomienda_paquete` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paquetes
-- ----------------------------
INSERT INTO `paquetes` VALUES (1, 120.000, 120.00, 120.00, 120.00, 0, '123ABC');

-- ----------------------------
-- Table structure for recargas
-- ----------------------------
DROP TABLE IF EXISTS `recargas`;
CREATE TABLE `recargas`  (
  `cliente_id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `monto` decimal(14, 3) UNSIGNED NOT NULL,
  PRIMARY KEY (`cliente_id`, `fecha_hora`) USING BTREE,
  CONSTRAINT `cliente_recarga` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recargas
-- ----------------------------
INSERT INTO `recargas` VALUES ('27729212', '2021-12-17 02:17:57', 40.000);
INSERT INTO `recargas` VALUES ('30453753', '2021-12-17 00:04:23', 20.000);
INSERT INTO `recargas` VALUES ('30453753', '2021-12-17 02:15:04', 10.000);

-- ----------------------------
-- Table structure for transportistas
-- ----------------------------
DROP TABLE IF EXISTS `transportistas`;
CREATE TABLE `transportistas`  (
  `id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellido` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `telefono` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alt_telefono` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `saldo` decimal(14, 3) UNSIGNED NULL DEFAULT 0.000,
  `licencia` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `disponibilidad` tinyint(1) NOT NULL,
  `curso_aprobado` tinyint(1) NOT NULL,
  `f_curso` date NULL DEFAULT NULL,
  `antecedentes` tinyint(1) NOT NULL,
  `direccion_id` int(10) UNSIGNED NOT NULL,
  `nucleo_id` int(255) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `direccion_transportador`(`direccion_id`) USING BTREE,
  INDEX `asociado_a`(`nucleo_id`) USING BTREE,
  CONSTRAINT `asociado_a` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `direccion_transportador` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transportistas
-- ----------------------------
INSERT INTO `transportistas` VALUES ('28123999', 'Freddy', 'Reyes', '04120531528', NULL, 'frezk@gmail.com', 'jihsfadssad8921dsaas2123', 0.000, '210885054681', '2021-12-15', 0, 1, NULL, 1, 1, 1);
INSERT INTO `transportistas` VALUES ('28777156', 'Carlos', 'Ternera', '04241234451', NULL, 'telnep@gmail.com', 'jihsfdhjsadisladoas2123', NULL, NULL, '2021-12-15', 0, 1, NULL, 0, 2, 1);
INSERT INTO `transportistas` VALUES ('29412369', 'Julian', 'Alcachofas', '04125341274', NULL, 'juanalco_1@gmail.com', 'jbhdasnsdnasduhasudhas8d212131dasd', 0.000, '21020856327', '2021-12-16', 0, 0, NULL, 0, 4, 2);
INSERT INTO `transportistas` VALUES ('J48573221', 'Alisson', 'Blossom', '12123244152', NULL, 'alibloss23@outlook.com', 'diojsadjas10129028', NULL, 'K12345678', '2021-12-16', 0, 0, NULL, 0, 5, 4);
INSERT INTO `transportistas` VALUES ('J48874112', 'Jhon', 'Lennon', '12123255179', NULL, 'jhonlennon27@gmail.com', 'badjas7982132d', 0.000, 'K12345679', '2021-12-10', 1, 1, '2021-11-10', 0, 5, 4);

-- ----------------------------
-- Table structure for vehiculos
-- ----------------------------
DROP TABLE IF EXISTS `vehiculos`;
CREATE TABLE `vehiculos`  (
  `id` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'placa',
  `transportista_id` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `modelo` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `marca` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `color` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tipo` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transportista_vehiculo`(`transportista_id`) USING BTREE,
  CONSTRAINT `transportista_vehiculo` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vehiculos
-- ----------------------------
INSERT INTO `vehiculos` VALUES ('AB622FE', '28123999', 'M1', 'BMW', 'Rojo', 'motor');
INSERT INTO `vehiculos` VALUES ('BC123AC', '28777156', 'Urbana', 'Scott', 'Gris', 'bicicleta');
INSERT INTO `vehiculos` VALUES ('DE947KD', '29412369', '166', 'Ferrari', 'Azul', 'motor');
INSERT INTO `vehiculos` VALUES ('KL382JD', 'J48573221', 'Caviar', 'Tesla', 'Negro', 'motor');

-- ----------------------------
-- Table structure for viajes
-- ----------------------------
DROP TABLE IF EXISTS `viajes`;
CREATE TABLE `viajes`  (
  `vuelo_id` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `encomienda_id` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`vuelo_id`, `encomienda_id`) USING BTREE,
  INDEX `carga`(`encomienda_id`) USING BTREE,
  CONSTRAINT `carga` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `viaja_en` FOREIGN KEY (`vuelo_id`) REFERENCES `vuelos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viajes
-- ----------------------------

-- ----------------------------
-- Table structure for vuelos
-- ----------------------------
DROP TABLE IF EXISTS `vuelos`;
CREATE TABLE `vuelos`  (
  `id` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tiempo_retraso` time NULL DEFAULT NULL,
  `descripcion_retraso` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tiempo_estimado` time NOT NULL,
  `fh_salida` datetime NOT NULL,
  `fh_llegada` datetime NULL DEFAULT NULL,
  `aerolinea` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vuelos
-- ----------------------------
INSERT INTO `vuelos` VALUES ('22OK', NULL, NULL, '02:09:18', '2021-12-17 17:39:40', NULL, 'Conviasa');

-- ----------------------------
-- Function structure for sf_calcular_costo_encomienda
-- ----------------------------
DROP FUNCTION IF EXISTS `sf_calcular_costo_encomienda`;
delimiter ;;
CREATE FUNCTION `sf_calcular_costo_encomienda`(id VARCHAR(7))
 RETURNS float(255,2)
BEGIN

    DECLARE total FLOAT (255,2);
    
	SELECT SUM(c.precio)
	INTO total
	FROM encomiendas e, paquetes p, categorias c
	WHERE p.encomienda_id = e.id
	AND p.categoria_id = c.id;
	
	RETURN total;
   

END
;;
delimiter ;

-- ----------------------------
-- Function structure for sf_calcular_costo_paquete
-- ----------------------------
DROP FUNCTION IF EXISTS `sf_calcular_costo_paquete`;
delimiter ;;
CREATE FUNCTION `sf_calcular_costo_paquete`()

;;
delimiter ;

-- ----------------------------
-- Function structure for sf_consultar_saldo_cliente
-- ----------------------------
DROP FUNCTION IF EXISTS `sf_consultar_saldo_cliente`;
delimiter ;;
CREATE FUNCTION `sf_consultar_saldo_cliente`()

;;
delimiter ;

-- ----------------------------
-- Function structure for sf_encomiendas_totales_transportista
-- ----------------------------
DROP FUNCTION IF EXISTS `sf_encomiendas_totales_transportista`;
delimiter ;;
CREATE FUNCTION `sf_encomiendas_totales_transportista`()

;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_cambiar_disponibilidad
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_cambiar_disponibilidad`;
delimiter ;;
CREATE PROCEDURE `sp_cambiar_disponibilidad`()

;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_recargar_saldo_cliente
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_recargar_saldo_cliente`;
delimiter ;;
CREATE PROCEDURE `sp_recargar_saldo_cliente`()

;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_update_estado
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_update_estado`;
delimiter ;;
CREATE PROCEDURE `sp_update_estado`(encomienda VARCHAR(7))
BEGIN
	DECLARE oldEstado VARCHAR(15);
	DECLARE newEstado VARCHAR(15);
	
	SELECT estado
	INTO oldEstado
	FROM encomiendas
	WHERE id = encomienda;

	CASE oldEstado
	
		WHEN 'en espera' THEN

				SET newEstado = 'en progreso';
				-- Registrar fecha de salida
				UPDATE encomiendas
					SET fh_salida = NOW()
					WHERE id = encomienda;
			
		WHEN 'en custodia'  THEN
		
			SET newEstado = 'en progreso';
			
		WHEN 'en progreso'  THEN
		
			SET newEstado = 'culminada';
			
		ELSE 
		
			SET newEstado = oldEstado;
			
	END CASE;
	
	UPDATE encomiendas
	SET estado = newEstado
	WHERE id = encomienda;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_validar_ingreso_transportista
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_validar_ingreso_transportista`;
delimiter ;;
CREATE PROCEDURE `sp_validar_ingreso_transportista`()

;;
delimiter ;

-- ----------------------------
-- Triggers structure for table transportistas
-- ----------------------------
DROP TRIGGER IF EXISTS `validar_fecha_transportista_insert`;
delimiter ;;
CREATE TRIGGER `validar_fecha_transportista_insert` BEFORE INSERT ON `transportistas` FOR EACH ROW BEGIN
  CALL sp_validar_ingreso_transportista(NEW.fecha_ingreso);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table transportistas
-- ----------------------------
DROP TRIGGER IF EXISTS `validar_fecha_transportista_update`;
delimiter ;;
CREATE TRIGGER `validar_fecha_transportista_update` BEFORE UPDATE ON `transportistas` FOR EACH ROW BEGIN
  CALL sp_validar_ingreso_transportista(NEW.fecha_ingreso);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
