const db = require("../db");

// Obtener todos los clientes
const findAll = async () => {
  const query = `
    SELECT *
    FROM transportistas
  `;
  const rows = await db.query(query);
  return rows[0];
};

// Obtener cliente por su cédula
const findById =  async (id) => {
  const query = `
    SELECT *
    FROM transportistas
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

const findByEncomienda = async (encomienda) => {
  const query = `
    SELECT *
    FROM vw_transportistas_for_clientes
    WHERE encomienda = ?
  `;


  const params = [encomienda];

  const rows = await db.query(query, params);

  if (typeof rows[0] === "undefined")
    throw "not-found";

  return rows[0];
}

const create = async (transportistas) => {
  const query = `
    INSERT INTO transportistas
    (id, nombre, apellido, telefono, alt_telefono, email, password, licencia, fecha_ingreso, antecedentes, direccion_id, nucleo_id)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?) 

  `;

  const params = [
    transportistas.id,
    transportistas.nombre,
    transportistas.apellido,
    transportistas.telefono,
    transportistas.alt_telefono,
    transportistas.email,
    transportistas.password,
    transportistas.licencia,
    transportistas.antecedentes,
    transportistas.direccion_id,
    transportistas.nucleo_id
  ];

  await db.query(query, params);

  return transportistas.id;
};

const update = async (id, transportistas) => {
  const query = `
    UPDATE transportistas
    SET 
      id = ?, 
      nombre = ?, 
      apellido = ?, 
      telefono = ?, 
      alt_telefono = ?, 
      email = ?,
      password = ?,
      saldo = ?,
      licencia = ?,
      disponibilidad = ?,
      curso_aprobado = ?,
      f_curso = ?,
      antecedentes = ?,
      direccion_id = ?,
      nucleo_id = ?,
    WHERE id = ? 
  `;

  const params = [
    transportistas.id,
    transportistas.nombre,
    transportistas.apellido,
    transportistas.telefono,
    transportistas.alt_telefono,
    transportistas.email,
    transportistas.password,
    transportistas.saldo,
    transportistas.licencia,
    transportistas.disponibilidad,
    transportistas.curso_aprobado,
    transportistas.f_curso,
    transportistas.antecedentes,
    transportistas.direccion_id,
    transportistas.nucleo_id,
    id
  ];

  await db.query(query, params);
};

const updateDisponibilidad = async (id, disponibilidad) => {

  const query = `
    CALL sp_cambiar_disponibilidad(?, ?)
  `;

  const params = [id, disponibilidad];

  await db.query(query, params);
}

const deleteTransportista = async (id) => {
  const query = `
    DELETE FROM transportistas
    WHERE id = ?
  `;

  const params = [id];
  
  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

const login = async (email, password) => {
  
  const query = `
    SELECT id, password = ? as is_password_correct
    FROM transportistas
    WHERE email = ?
  `
  const params = [password, email];
  const response = await db.query(query, params);

  if (response[0].length === 0){
    throw "not-found";
  }
  
  return {
    is_password_correct: response[0][0].is_password_correct === 1,
    id: response[0][0].id
  };
  
}

const retirarSaldo = async (id, monto) => {
  const query = `
    SELECT sf_retirar_saldo_transportista(?,?) as saldo
  `
  const params = [id, monto];
  const response = await db.query(query, params);

  if (!response[0][0].saldo){
    throw "not-found";
  }
  
  return response[0][0].saldo;
}

module.exports = {
  findAll,
  findById,
  create,
  update,
  updateDisponibilidad,
  login,
  retirarSaldo,
  findByEncomienda
};

module.exports.delete = deleteTransportista;