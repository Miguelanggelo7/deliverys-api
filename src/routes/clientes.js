const Router = require("express-promise-router");
const db = require("../db");
const Cliente = require("../models/Cliente");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Cliente.findAll();
  res.json(rows[0]);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Cliente.findById(id);
  res.json(row[0]);
});

// Crear cliente
router.post("/", async (req, res) => {
  await Cliente.create(req.body);
  res.status(201).json({ message: "Cliente creado" });
});

// Actualizar cliente
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Cliente.update(id, req.body);
  res.json({ message: "Cliente actualizado" });
});

// Eliminar cliente
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Cliente.deleteCliente(id);
  res.json({ message: `Cliente con id ${id} eliminado` });
});

module.exports = router;