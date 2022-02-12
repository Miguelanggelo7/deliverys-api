DROP FUNCTION IF EXISTS sp_validar_ingreso_transportista;

CREATE FUNCTION sp_validar_ingreso_transportista(
  IN f_ingreso DATE
)
BEGIN
	IF f_ingreso > CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fecha de ingreso inválida';
	END IF;
END;