const db = require("../db");

const findAll = async () => {
  const query = `
    SELECT * FROM invitaciones
    ORDER BY fecha_hora ASC
  `;

  const response = await db.query(query);

  if (response[0].affectedRows === 0)
    throw "not-found";

  return response[0];
}

const findByTransportistaId = async (transportista_id) => {
  const query = `
    SELECT * FROM invitaciones
    WHERE transportista_id = ?
    AND estado IS NULL
    ORDER BY fecha_hora ASC
  `;

  const params = [transportista_id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";

    return response[0];
}

const aceptar = async (encomienda_id, transportista_id, vehiculo_id) => {
  const query = `CALL sp_aceptar_invitacion(?,?,?)`;

  const params = [encomienda_id, transportista_id, vehiculo_id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found"; 
}


const rechazar = async (encomienda_id, transportista_id) => {
  const query = `CALL sp_rechazar_invitacion(?,?)`;

  const params = [encomienda_id, transportista_id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found"; 
}

module.exports = {
  findAll,
  findByTransportistaId,
  aceptar,
  rechazar
};