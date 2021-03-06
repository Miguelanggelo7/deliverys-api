const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM vuelos
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM vuelos
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Crear nueva
const create = async (vuelos) => {
  const query = `
    INSERT INTO vuelos
    (id, tiempo_retraso, descripcion_retraso, tiempo_retraso, fh_salida, fh_llegada, aerolinea,
      encomienda_id, recorrido_id)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)
    RETURNING *
  `;

  const params = [
    vuelos.id,
    vuelos.tiempo_retraso,
    vuelos.descripcion_retraso,
    vuelos.tiempo_retraso,
    vuelos.fh_salida,
    vuelos.fh_llegada,
    vuelos.aerolinea,
    vuelos.encomienda_id,
    vuelos.recorrido_id
  ];

  await db.query(query, params);
};

// Actualizar
const update = async (id, vuelos) => {
  const query = `
    UPDATE vuelos
    SET
    id = ?,
    tiempo_retraso = ?,
    descripcion_retraso = ?,
    tiempo_retraso = ?,
    fh_salida = ?,
    fh_llegada = ?,
    aerolinea = ?,
    encomienda_id = ?, 
    recorrido_id =?
    WHERE id = ?
  `;

  const params = [
    vuelos.id,
    vuelos.tiempo_retraso,
    vuelos.descripcion_retraso,
    vuelos.tiempo_retraso,
    vuelos.fh_salida,
    vuelos.fh_llegada,
    vuelos.aerolinea,
    vuelos.encomienda_id,
    vuelos.recorrido_id,
    id
  ];

  await db.query(query, params);
};

// Eliminar
const deteleVuelo = async (id) => {
  const query = `
    DELETE FROM vuelos
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, update  };
  module.exports.delete = deteleVuelo;