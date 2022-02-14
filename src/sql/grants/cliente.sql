CREATE USER cliente IDENTIFIED BY 'cliente123';

GRANT ALL ON aritculos TO cliente;
GRANT INSERT, UPDATE, SELECT ON clientes TO cliente;
GRANT SELECT ON direcciones TO cliente;
GRANT SELECT, UPDATE, INSERT ON encomiendas TO cliente;
GRANT SELECT ON nucleos TO cliente;
GRANT SELECT ON paises TO cliente;
GRANT  ALL ON paquetes TO cliente;
GRANT SELECT ON vuelos TO cliente;
GRANT SELECT ON vw_transportistas_for_clientes TO cliente;

-----------------------------------------------

GRANT EXECUTE ON PROCEDURE sp_solicitar_encomienda TO cliente;
GRANT EXECUTE ON FUNCTION sf_consultar_saldo_cliente TO cliente;


