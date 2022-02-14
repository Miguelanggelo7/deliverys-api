CREATE USER transportista IDENTIFIED BY 'transportista123';

GRANT ALL ON aritculos TO transportista;
GRANT SELECT ON direcciones TO transportista;
GRANT SELECT, UPDATE ON encomiendas TO transportista;
GRANT SELECT ON invitaciones TO transportista;
GRANT SELECT ON nucleos TO transportista;
GRANT SELECT ON paises TO transportista;
GRANT ALL ON paquetes TO transportista;
GRANT SELECT ON recorridos TO transportista;
GRANT SELECT, INSERT, UPDATE (
        id, 
        nombre, 
        apellido, 
        telefono, 
        alt_telefono, 
        email, 
        `password`, 
        licencia,
        antecedentes,
        direccion_id,
        nucleo_id
    ) 
ON transportistas
TO transportista;
GRANT ALL ON vehiculos TO transportista;
GRANT INSERT, UPDATE, SELECT ON vuelos TO transportista;
GRANT EXECUTE ON PROCEDURE sp_aceptar_invitacion TO transportista;
GRANT EXECUTE ON PROCEDURE sp_rechazar_invitacion TO transportista;
GRANT EXECUTE ON PROCEDURE sp_aceptar_recorrido TO transportista;
GRANT EXECUTE ON PROCEDURE sp_agregar_vehiculo TO transportista;
GRANT EXECUTE ON PROCEDURE sp_cambiar_disponibilidad TO transportista;
GRANT EXECUTE ON PROCEDURE sp_terminar_recorrido TO transportista;
GRANT EXECUTE ON PROCEDURE sp_update_estado TO transportista;
GRANT EXECUTE ON FUNCTION sf_retirar_saldo_transportista TO transportista;
GRANT SELECT ON vw_clientes_for_transportistas TO transportista;


SHOW GRANTS FOR transportista