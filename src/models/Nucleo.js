const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM nucleos
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM nucleos
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Crear nueva
const create = async (nucleos) => {
  const query = `
    INSERT INTO nucleos
    (id, direccion_id, nombre, telefono, com_vuelo, com_vehiculo_motor, com_bicicleta)
    VALUES(?, ?, ?, ?, ?, ?, ?)
    RETURNING *
  `;

  const params = [
    nucleos.id,
    nucleos.direccion_id,
    nucleos.nombre,
    nucleos.telefono,
    nucleos.com_vuelo,
    nucleos.com_vehiculo_motor,
    nucleos.com_bicicleta
  ];

  const row = await db.query(query, params);

  return row;
};

// Actualizar
const update = async (id, nucleos) => {
  const query = `
    UPDATE nucleos
    SET
    id = ?,
    direccion_id = ?,
    nombre = ?,
    telefono = ?,
    com_vuelo = ?,
    com_vehiculo_motor = ?,
    com_bicicleta = ?
    WHERE id = ?
  `;

  const params = [
    nucleos.id,
    nucleos.direccion_id,
    nucleos.nombre,
    nucleos.telefono,
    nucleos.com_vuelo,
    nucleos.com_vehiculo_motor,
    nucleos.com_bicicleta,
    id
  ];

  await db.query(query, params);
};

// Eliminar
const deleteNucleo = async (id) => {
  const query = `
    DELETE FROM nucleos
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, update  };
  module.exports.delete = deleteNucleo;