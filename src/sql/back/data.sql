-- ----------------------------
-- Records of articulos
-- ----------------------------
INSERT INTO `articulos` VALUES (44, 'computadora', 7);
INSERT INTO `articulos` VALUES (45, 'impresoras', 2);
INSERT INTO `articulos` VALUES (45, 'medicamentos', 3);
INSERT INTO `articulos` VALUES (43, 'pollo frito', 2);
INSERT INTO `articulos` VALUES (4, 'shampoo', 20);
INSERT INTO `articulos` VALUES (43, 'shampoo', 10);
INSERT INTO `articulos` VALUES (44, 'telefono', 2);


-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES ('27123447', 'dsumoza@gmail.com', 'sadaskjadhka', 143.400, 'David', 'Sumoza', '04265971258', NULL, 2);
INSERT INTO `clientes` VALUES ('27729212', 'josemsaad13@gmail.com', 'dadasd2112323ddasdas', 62.000, 'Jose', 'Saad', '04249215674', NULL, 2);
INSERT INTO `clientes` VALUES ('27765316', 'vanessxdl@gmail.com', 'dsdadasdasdasdasdas', 0.000, 'Vanessa', 'Lozano', '04249338629', NULL, 1);
INSERT INTO `clientes` VALUES ('28301458', 'johanadrex@gmail.com', 'uhasduhasdjbkasdkjbadsas', 0.000, 'Johana', 'Dominguez', '04249331254', '04148521426', 2);
INSERT INTO `clientes` VALUES ('28471236', 'charlyghass@gmail.com', '32u381naskjdmka', 0.000, 'Charly', 'Ghassibe', '04249123347', NULL, 2);
INSERT INTO `clientes` VALUES ('29045314', 'viclo@gmail.com', 'sadsadasasdsad', 0.000, 'Victoria', 'Lopez', '04126974123', NULL, 1);
INSERT INTO `clientes` VALUES ('30015336', 'diegoooalc@gmail.com', 'ddsadadaskldasklndas', 0.000, 'Diego', 'Alcala', '04162632721', '04249531526', 1);
INSERT INTO `clientes` VALUES ('30453753', 'miguelanggelo21@gmail.com', 'fdujhbqiudszsujnajdnawsdas', 30.000, 'Miguelanggelo', 'Sumoza', '04249125727', NULL, 1);
INSERT INTO `clientes` VALUES ('30482111', 'guss_tierre@gmail.com', 'dsasdasdasdadasd', 0.000, 'Gustavo', 'Gutierrez', '04129531428', NULL, 2);
INSERT INTO `clientes` VALUES ('C03004786', 'alexmurra@hotmail.com', 'kljsdadjsalmd2283dadad', 0.000, 'Alex', 'Murray', '17023789521', NULL, 5);

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
-- Records of encomiendas
-- ----------------------------
INSERT INTO `encomiendas` VALUES ('123ABC', 'normal', NULL, NULL, 'en progreso', 1, NULL, '28123999', 'AB622FE', '27123447', '27729212', 1.00);
INSERT INTO `encomiendas` VALUES ('232AIF', 'normal', '2021-12-13 14:09:18', '2021-12-16 14:09:18', 'culminada', 4, NULL, 'J48573221', NULL, '27729212', 'C03004786', 3.00);
INSERT INTO `encomiendas` VALUES ('245CDF', 'extendida', NULL, NULL, NULL, 1, 2, NULL, NULL, '27123447', '30482111', 0.00);
INSERT INTO `encomiendas` VALUES ('294AOP', 'normal', '2021-12-14 14:09:18', '2021-12-16 14:09:18', 'en progreso', 2, NULL, '29412369', NULL, '29045314', '28471236', 4.00);
INSERT INTO `encomiendas` VALUES ('54516da', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516db', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516dc', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516dd', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516de', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516h3', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516ha', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('54516hh', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('545d1h3', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('545d2h3', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('545d2h4', 'normal', NULL, NULL, NULL, 1, NULL, NULL, 'A56VDA', '27729212', '29045314', 45.00);
INSERT INTO `encomiendas` VALUES ('563AOS', 'normal', '2021-12-11 14:09:18', '2021-12-11 18:09:18', 'culminada', 2, NULL, 'J48573221', NULL, '27765316', '30453753', 1.00);
INSERT INTO `encomiendas` VALUES ('652HOS', 'normal', '2021-11-01 14:39:40', '2021-11-16 17:00:47', 'en progreso', 4, NULL, '29412369', NULL, '30453753', '30482111', 1.00);
INSERT INTO `encomiendas` VALUES ('999ZZZ', 'extendida', '2022-02-11 02:58:55', '2022-02-11 04:32:57', 'culminada', 1, 2, NULL, NULL, '27123447', '27729212', 0.00);
INSERT INTO `encomiendas` VALUES ('XXX123', 'extendida', NULL, NULL, 'en espera', 5, 1, NULL, NULL, '27123447', '27729212', 0.00);

-- ----------------------------
-- Records of historico_clientes
-- ----------------------------
INSERT INTO `historico_clientes` VALUES (1, '30453753', '2022-02-12 18:45:45', 20.000, 30.000);

-- ----------------------------
-- Records of historico_transportistas
-- ----------------------------
INSERT INTO `historico_transportistas` VALUES (1, '27506984', '2022-02-12 18:48:42', 15.000, 20.000);

-- ----------------------------
-- Records of invitaciones
-- ----------------------------

-- ----------------------------
-- Records of nucleos
-- ----------------------------
INSERT INTO `nucleos` VALUES (1, 1, ' S&S Pto. Ordaz Unare', '02869231487', 0.3500, 0.2000, 0.1000, 1.000);
INSERT INTO `nucleos` VALUES (2, 4, ' S&S El Callao Av. Guarapiche', '02869231288', 0.4000, 0.1500, 0.1000, 0.500);
INSERT INTO `nucleos` VALUES (4, 5, 'DHL EXPRESS Las Vegas Sunset RD Suite', '18002255345', 0.3500, 0.2500, 0.1500, 0.700);
INSERT INTO `nucleos` VALUES (5, 6, 'NUCLEO 6', '12313213213', 0.2000, 0.1000, 0.5000, 1.000);


-- ----------------------------
-- Records of paises
-- ----------------------------
INSERT INTO `paises` VALUES (1, 'Estados Unidos');
INSERT INTO `paises` VALUES (2, 'Venezuela');
INSERT INTO `paises` VALUES (3, 'Brasil');
INSERT INTO `paises` VALUES (4, 'Argentina');
INSERT INTO `paises` VALUES (6, 'Ukrania');
INSERT INTO `paises` VALUES (7, 'Bolivia');
INSERT INTO `paises` VALUES (8, 'España');

-- ----------------------------
-- Records of paquetes
-- ----------------------------
INSERT INTO `paquetes` VALUES (1, 120.000, 120.00, 120.00, 120.00, 0, '232AIF');
INSERT INTO `paquetes` VALUES (2, 10.000, 10.00, 10.00, 10.00, 0, '294AOP');
INSERT INTO `paquetes` VALUES (3, 50.000, 30.00, 30.00, 30.00, 0, '652HOS');
INSERT INTO `paquetes` VALUES (4, 100.000, 50.00, 50.00, 50.00, 0, '999ZZZ');
INSERT INTO `paquetes` VALUES (5, 20.000, 10.00, 10.00, 10.00, 0, '54516da');
INSERT INTO `paquetes` VALUES (6, 20.000, 15.00, 16.00, 11.00, 1, '54516da');
INSERT INTO `paquetes` VALUES (7, 30.000, 10.00, 15.00, 12.00, 0, '54516da');
INSERT INTO `paquetes` VALUES (8, 20.000, 10.00, 10.00, 10.00, 0, '54516db');
INSERT INTO `paquetes` VALUES (9, 20.000, 15.00, 16.00, 11.00, 1, '54516db');
INSERT INTO `paquetes` VALUES (10, 30.000, 10.00, 15.00, 12.00, 0, '54516db');
INSERT INTO `paquetes` VALUES (11, 20.000, 10.00, 10.00, 10.00, 0, '54516dc');
INSERT INTO `paquetes` VALUES (12, 20.000, 15.00, 16.00, 11.00, 1, '54516dc');
INSERT INTO `paquetes` VALUES (13, 30.000, 10.00, 15.00, 12.00, 0, '54516dc');
INSERT INTO `paquetes` VALUES (14, 20.000, 10.00, 10.00, 10.00, 0, '54516dd');
INSERT INTO `paquetes` VALUES (15, 20.000, 15.00, 16.00, 11.00, 1, '54516dd');
INSERT INTO `paquetes` VALUES (16, 30.000, 10.00, 15.00, 12.00, 0, '54516dd');
INSERT INTO `paquetes` VALUES (17, 20.000, 10.00, 10.00, 10.00, 0, '54516de');
INSERT INTO `paquetes` VALUES (18, 20.000, 15.00, 16.00, 11.00, 1, '54516de');
INSERT INTO `paquetes` VALUES (19, 30.000, 10.00, 15.00, 12.00, 0, '54516de');
INSERT INTO `paquetes` VALUES (20, 20.000, 10.00, 10.00, 10.00, 0, '54516hh');
INSERT INTO `paquetes` VALUES (21, 20.000, 15.00, 16.00, 11.00, 1, '54516hh');
INSERT INTO `paquetes` VALUES (22, 30.000, 10.00, 15.00, 12.00, 0, '54516hh');
INSERT INTO `paquetes` VALUES (23, 20.000, 10.00, 10.00, 10.00, 0, '54516ha');
INSERT INTO `paquetes` VALUES (24, 20.000, 15.00, 16.00, 11.00, 1, '54516ha');
INSERT INTO `paquetes` VALUES (25, 30.000, 10.00, 15.00, 12.00, 0, '54516ha');
INSERT INTO `paquetes` VALUES (26, 20.000, 10.00, 10.00, 10.00, 0, '54516h3');
INSERT INTO `paquetes` VALUES (27, 20.000, 15.00, 16.00, 11.00, 1, '54516h3');
INSERT INTO `paquetes` VALUES (28, 30.000, 10.00, 15.00, 12.00, 0, '54516h3');
INSERT INTO `paquetes` VALUES (29, 20.000, 10.00, 10.00, 10.00, 0, '545d1h3');
INSERT INTO `paquetes` VALUES (30, 20.000, 15.00, 16.00, 11.00, 1, '545d1h3');
INSERT INTO `paquetes` VALUES (31, 30.000, 10.00, 15.00, 12.00, 0, '545d1h3');
INSERT INTO `paquetes` VALUES (32, 20.000, 10.00, 10.00, 10.00, 0, '545d2h3');
INSERT INTO `paquetes` VALUES (33, 20.000, 15.00, 16.00, 11.00, 1, '545d2h3');
INSERT INTO `paquetes` VALUES (34, 30.000, 10.00, 15.00, 12.00, 0, '545d2h3');
INSERT INTO `paquetes` VALUES (43, 20.000, 10.00, 10.00, 10.00, 0, '545d2h4');
INSERT INTO `paquetes` VALUES (44, 20.000, 15.00, 16.00, 11.00, 1, '545d2h4');
INSERT INTO `paquetes` VALUES (45, 30.000, 10.00, 15.00, 12.00, 0, '545d2h4');

-- ----------------------------
-- Records of recorridos
-- ----------------------------
INSERT INTO `recorridos` VALUES (0, '999ZZZ', 1, 4, 'culminado', '28123999');
INSERT INTO `recorridos` VALUES (0, 'XXX123', 5, 1, 'abierto', NULL);
INSERT INTO `recorridos` VALUES (1, '999ZZZ', 4, 5, 'culminado', 'J48573221');
INSERT INTO `recorridos` VALUES (2, '999ZZZ', 5, 2, 'culminado', '27506984');

-- ----------------------------
-- Records of transportistas
-- ----------------------------
INSERT INTO `transportistas` VALUES ('27506984', 'Guss', 'Guti', '45464645456', NULL, 'dfjfrfrfrr', '1234', 20.000, 'K454654458', '2022-02-10', 0, 1, '2022-02-10', 0, 2, 5);
INSERT INTO `transportistas` VALUES ('28123999', 'Freddy', 'Reyes', '04120531528', NULL, 'frezk@gmail.com', 'jihsfadssad8921dsaas2123', 8.750, '210885054681', '2021-12-15', 0, 1, '2022-02-08', 1, 1, 1);
INSERT INTO `transportistas` VALUES ('28777156', 'Carlos', 'Ternera', '04241234451', NULL, 'telnep@gmail.com', 'jihsfdhjsadisladoas2123', 0.000, NULL, '2021-12-15', 0, 1, '2022-02-06', 0, 2, 1);
INSERT INTO `transportistas` VALUES ('29412369', 'Julian', 'Alcachofas', '04125341274', NULL, 'juanalco_1@gmail.com', 'jbhdasnsdnasduhasudhas8d212131dasd', 0.000, '21020856327', '2021-12-16', 0, 1, '2022-02-06', 0, 4, 2);
INSERT INTO `transportistas` VALUES ('J48573221', 'Alisson', 'Blossom', '12123244152', NULL, 'alibloss23@outlook.com', 'diojsadjas10129028', 17.500, 'K12345678', '2021-12-16', 0, 1, '2022-02-06', 0, 5, 4);
INSERT INTO `transportistas` VALUES ('J48874112', 'Jhon', 'Lennon', '12123255179', NULL, 'jhonlennon27@gmail.com', 'badjas7982132d', 0.000, 'K12345679', '2021-12-10', 1, 1, '2021-11-10', 0, 5, 4);

-- ----------------------------
-- Records of vehiculos
-- ----------------------------
INSERT INTO `vehiculos` VALUES ('A33315', '28123999', 'Explorer 2020', 'Toyota', 'Blanco', 'motor');
INSERT INTO `vehiculos` VALUES ('A56VDA', '28123999', 'Explorer 2020', 'Toyota', 'Blanco', 'motor');
INSERT INTO `vehiculos` VALUES ('AB622FE', '28123999', 'M1', 'BMW', 'Rojo', 'motor');
INSERT INTO `vehiculos` VALUES ('AI41AD5', '28123999', 'Explorer 2020', 'Toyota', 'Blanco', 'motor');
INSERT INTO `vehiculos` VALUES ('BC123AC', '28777156', 'Urbana', 'Scott', 'Gris', 'bicicleta');
INSERT INTO `vehiculos` VALUES ('DE947KD', '29412369', '166', 'Ferrari', 'Azul', 'motor');
INSERT INTO `vehiculos` VALUES ('KL382JD', 'J48573221', 'Caviar', 'Tesla', 'Negro', 'motor');


