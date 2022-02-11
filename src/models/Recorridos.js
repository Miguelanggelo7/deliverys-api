const db = require("../db");

// Obtener todos los recorridos
const findAll = async () => {
  const query = `
    SELECT *
    FROM recorridos
  `;
  const rows = await db.query(query);
  return rows[0];
};

// Obtener todos los recorridos disponibles de un nucleo determinado
const findByNucleo =  async (nucleo) => {
  const query = `
    SELECT *
    FROM recorridos
    WHERE nucleo_org_id = ?
    AND estado = 'abierto'
  `;

  const params = [nucleo];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Obtener por id
const findById =  async (encomienda_id, recorrido_id) => {
  const query = `
    SELECT *
    FROM recorridos
    WHERE encomienda_id = ?
    AND id = ?
  `;

  const params = [encomienda_id, recorrido_id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};


const aceptarRecorrido =  async (encomienda_id, recorrido_id, transportista_id, nucleo_des_id) => {
  const query = `
    CALL sp_aceptar_recorrido(?,?,?,?)
  `;

  const params = [encomienda_id, recorrido_id, transportista_id, nucleo_des_id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

const terminarRecorrido =  async (encomienda_id, recorrido_id) => {
  const query = `
    CALL sp_terminar_recorrido(?,?)
  `;

  const params = [encomienda_id, recorrido_id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};


module.exports = {
  findAll,
  findByNucleo,
  findById,
  aceptarRecorrido,
  terminarRecorrido
};