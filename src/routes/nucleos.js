const Router = require("express-promise-router");
const db = require("../db");
const Nucleo = require("../models/Nucleo");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Nucleo.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Nucleo.findById(id);
  res.json(row);
});

// Crear 
router.post("/", async (req, res) => {
  const row = await Nucleo.create(req.body);
  res.status(201).json(row);
});

// Actualizar 
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Nucleo.update(id, req.body);
  res.json({ message: "Nucleo actualizado" });
});

// Eliminar 
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Nucleo.delete(id);
  res.json({ message: `Nucleo con id ${id} ha sido eliminado` });
});

module.exports = router;