ALTER TABLE articulos
ADD CONSTRAINT `paquete_contiene` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes` (`id`) ON UPDATE CASCADE;

ALTER TABLE `clientes`
ADD CONSTRAINT `direccion_cliente` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE;

ALTER TABLE `direcciones`
ADD CONSTRAINT `fk_direcciones_paises` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id`) ON UPDATE CASCADE;


ALTER TABLE `encomiendas`
ADD CONSTRAINT `cliente_envia` FOREIGN KEY (`cliente_env_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `cliente_recibe` FOREIGN KEY (`cliente_rec_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_nucleo_id` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_nucleo_rec_id` FOREIGN KEY (`nucleo_rec_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_transportista_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_transportista_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `historico_clientes`
ADD CONSTRAINT `fk_cliente_historico` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON UPDATE CASCADE;

ALTER TABLE `historico_transportistas` 
ADD CONSTRAINT `fk_transportistas_historico` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE;

ALTER TABLE `invitaciones`
ADD CONSTRAINT `fk_invitaciones_encomienda_id` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `fk_invitaciones_transportistas_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE;

ALTER TABLE `nucleos`
ADD CONSTRAINT `direccion_nucleo` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE;

ALTER TABLE `paquetes`
ADD CONSTRAINT `fk_paquete_encomiendas` FOREIGN KEY (`encomienda_id`) REFERENCES `encomiendas` (`id`) ON UPDATE CASCADE;

ALTER TABLE `recorridos`
ADD CONSTRAINT `fk_recorridos_nucleo_des_id` FOREIGN KEY (`nucleo_des_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_recorridos_nucleo_org_id` FOREIGN KEY (`nucleo_org_id`) REFERENCES `nucleos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `fk_recorridos_transportista_id` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE `transportistas`
ADD CONSTRAINT `asociado_a` FOREIGN KEY (`nucleo_id`) REFERENCES `nucleos` (`id`) ON UPDATE CASCADE,
ADD CONSTRAINT `direccion_transportador` FOREIGN KEY (`direccion_id`) REFERENCES `direcciones` (`id`) ON UPDATE CASCADE;

ALTER TABLE `vehiculos`
ADD CONSTRAINT `transportista_vehiculo` FOREIGN KEY (`transportista_id`) REFERENCES `transportistas` (`id`) ON UPDATE CASCADE;

ALTER TABLE `vuelos`
ADD CONSTRAINT `fk_recorridos_encomienda_id_recorrido_id` FOREIGN KEY (`encomienda_id`, `recorrido_id`) REFERENCES `recorridos` (`encomienda_id`, `id`) ON DELETE NO ACTION ON UPDATE CASCADE;

