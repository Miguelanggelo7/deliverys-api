const db = require("../db");

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
  aceptar,
  rechazar
};