DROP PROCEDURE IF EXISTS sp_validar_curso_transportista;

CREATE PROCEDURE sp_validar_curso_transportista(
	id_transportista VARCHAR(9)
)
BEGIN

	UPDATE transportistas
     SET curso_aprobado = 1, f_curso = NOW()
     WHERE id_transportista = id;
     
END;