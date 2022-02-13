DROP TRIGGER IF EXISTS tg_historico_paquete;
CREATE DEFINER=`deliverys_api_server`@`%` TRIGGER tg_historico_cliente
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
	IF NEW.saldo <> OLD.saldo THEN
		INSERT INTO historico_clientes (cliente_id, fecha, valor, saldo_final)
		VALUES (NEW.id, NOW(), NEW.saldo - OLD.saldo, NEW.saldo);
	END IF;
END