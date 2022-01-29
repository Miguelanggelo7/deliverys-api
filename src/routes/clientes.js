const Router = require("express-promise-router");
const db = require("../db");
const Cliente = require("../models/Cliente");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Cliente.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Cliente.findById(id);
  res.json(row);
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
  await Cliente.delete(id);
  res.json({ message: `Cliente con id ${id} ha sido eliminado` });
});

module.exports = router;