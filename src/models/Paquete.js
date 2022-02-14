const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM paquetes
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM paquetes
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Encuentra todos los paquetes de una encomienda
const findByEncomienda = async (id) => {
  const query = `
    SELECT *
    FROM paquetes 
    WHERE encomienda_id = ?
  `;

  const params = [id];

  const [rows] = await db.query(query, params);

  return rows;
}


// Crear nueva
const create = async (paquetes) => {
  const query = `
    INSERT INTO paquetes
    (peso, alto, ancho, largo, fragil, encomienda_id)
    VALUES(?, ?, ?, ?, ?, ?)
    RETURNING *
  `;

  const params = [
    paquetes.peso,
    paquetes.alto,
    paquetes.ancho,
    paquetes.largo,
    paquetes.fragil,
    paquetes.encomienda_id
  ];

  await db.query(query, params);
};

// Actualizar
const update = async (id, paquetes) => {
  const query = `
    UPDATE paquetes
    SET
    peso = ?,
    alto = ?,
    ancho = ?,
    largo = ?,
    fragil = ?,
    encomienda_id = ?
    WHERE id = ?
  `;

  const params = [
    paquetes.peso,
    paquetes.alto,
    paquetes.ancho,
    paquetes.largo,
    paquetes.fragil,
    paquetes.encomienda_id,
    id
  ];

  await db.query(query, params);
};

// Eliminar
const deletePaquete = async (id) => {
  const query = `
    DELETE FROM paquetes
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, update, findByEncomienda  };
  module.exports.delete = deletePaquete;