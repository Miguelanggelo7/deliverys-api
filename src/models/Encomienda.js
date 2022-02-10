const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM encomiendas
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM encomiendas
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Crear nueva
const create = async (encomiendas) => {
  const query = `
    INSERT INTO encomiendas
    (id, fh_salida, fh_llegada, estado, tipo, cliente_env_id, cliente_rec_id, nucleo_lcl_id, nucleo_ext_id, transp_lcl_id, transp_ext_id, precio)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  const params = [
    encomiendas.id,
    encomiendas.fh_salida,
    encomiendas.fh_llegada,
    encomiendas.estado,
    encomiendas.tipo,
    encomiendas.cliente_env_id,
    encomiendas.cliente_rec_id,
    encomiendas.nucleo_lcl_id,
    encomiendas.nucleo_ext_id,
    encomiendas.transp_lcl_id,
    encomiendas.transp_ext_id,
    encomiendas.precio
  ];

  const row = await db.query(query, params);

  return row;
};

// Actualizar
const update = async (id, encomiendas) => {
  const query = `
    UPDATE encomiendas
    SET
    id = ?,
    fh_salida = ?,
    fh_llegada = ?,
    estado = ?,
    tipo = ?,
    cliente_env_id = ?,
    cliente_rec_id = ?,
    nucleo_lcl_id = ?,
    nucleo_ext_id = ?,
    transp_lcl_id = ?,
    transp_ext_id = ?,
    precio = ?
    WHERE id = ?
  `;

  const params = [
    encomiendas.id,
    encomiendas.fh_salida,
    encomiendas.fh_llegada,
    encomiendas.estado,
    encomiendas.tipo,
    encomiendas.cliente_env_id,
    encomiendas.cliente_rec_id,
    encomiendas.nucleo_lcl_id,
    encomiendas.nucleo_ext_id,
    encomiendas.transp_lcl_id,
    encomiendas.transp_ext_id,
    encomiendas.precio,
    id
  ];

  await db.query(query, params);
};

//Actualizar Estado Encomienda
const updateEstado = async (encomienda_id, transportista_id, estado) => {
  const query = `CALL sp_update_estado(?,?,?)`;

  const params = [encomienda_id, transportista_id, estado];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";

}

// Eliminar
const deleteEncomiendas = async (id) => {
  const query = `
    DELETE FROM encomiendas
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, update, updateEstado };
  module.exports.delete = deleteEncomiendas;