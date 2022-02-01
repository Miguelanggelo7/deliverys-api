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

  return rows[0][0];
};

const create = async (transportistas) => {
  const query = `
    INSERT INTO transportistas
    (id, nombre, apellido, telefono, alt_telefono, email, password, saldo, licencia, fecha_ingreso, disponibilidad, curso_aprobado, f_curso, antecedentes, direccion_id, nucleo_id)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
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
    transportistas.fecha_ingreso,
    transportistas.disponibilidad,
    transportistas.curso_aprobado,
    transportistas.f_curso,
    transportistas.antecedentes,
    transportistas.direccion_id,
    transportistas.nucleo_id
  ];

  await db.query(query, params);
};

const update = async (id, cliente) => {
  const query = `
    UPDATE clientes
    SET 
      id = ?, 
      email = ?, 
      password = ?, 
      saldo = ?, 
      nombre = ?, 
      apellido = ?, 
      telefono = ?, 
      alt_telefono = ?, 
      direccion_id = ?
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
    transportistas.fecha_ingreso,
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

const deleteTransportista = async (id) => {
  const query = `
    DELETE FROM transportistas
    WHERE id = ?
  `;

  const params = [id];
  await db.query(query, params);
};

module.exports = {
  findAll,
  findById,
  create,
  update,
};

module.exports.delete = deleteTransportista;